// shoot.mjs <out-dir> [light|dark] [viewer-url]: screenshots every view and step of the deck served on localhost:8000
// (./serve.sh --no-open); needs GR4_PRESENT set to a gr4-present checkout, and `node --experimental-websocket` on Node 20
// SHOOT_VIEW=<id> starts at that view (the first shot is the only full-size one), SHOOT_ADVANCE=<n> presses Right n times
// before the first shot (to catch a later step full-size), SHOOT_MAX=<n> stops after n shots
import { mkdir, writeFile } from "node:fs/promises";
import path from "node:path";
import { pathToFileURL } from "node:url";

// an import specifier cannot be computed, so the harness is loaded dynamically from the checkout GR4_PRESENT names
const harness = path.resolve(process.env.GR4_PRESENT ?? path.join(path.dirname(new URL(import.meta.url).pathname), "../../gr4-present"), "devtools/browser_harness.mjs");
const { launchBrowser, openPage } = await import(pathToFileURL(harness).href);

const out = process.argv[2] ?? "shots/light";
const theme = process.argv[3] ?? "light";
const viewer = process.argv[4] ?? "https://ralphsteinhagen.github.io/gr4-present/minimal/"; // the deck has no live charts
await mkdir(out, { recursive: true });
const browser = await launchBrowser(["--window-size=1600,900", "--disable-features=LocalNetworkAccessChecks,PrivateNetworkAccessRespectPreflightResults,PrivateNetworkAccessSendPreflights", `--force-color-profile=srgb`]);
const log = [];
try {
  const url = `${viewer}?presentation=${encodeURIComponent("http://localhost:8000")}&theme=${theme}${process.env.SHOOT_VIEW ? `&view=${process.env.SHOOT_VIEW}` : ""}`;
  const page = await openPage(browser, url);
  log.push(`opened ${url}`);
  if (theme === "dark") {
    // the viewer follows prefers-color-scheme; emulate it and reload so the runtime starts under it
    await page.command("Emulation.setEmulatedMedia", { features: [{ name: "prefers-color-scheme", value: "dark" }] }); // persists across the service worker's reload
  }
  log.push(`isolated: ${await page.waitFor("window.crossOriginIsolated === true", 90_000)}`);
  log.push(`launched: ${await page.waitFor("!!document.getElementById('launch')?.classList.contains('done')", 120_000)}`);
  await page.waitFor("(document.getElementById('canvas')?.width ?? 0) > 0");
  await page.waitFor("(globalThis.gr4Location || '').includes('view=')", Number(process.env.SHOOT_TIMEOUT ?? 120_000)); // a heavy first view needs longer
  await page.evaluate("document.getElementById('canvas').focus()");
  await new Promise((r) => setTimeout(r, 3000));
  for (let i = 0; i < Number(process.env.SHOOT_ADVANCE ?? 0); ++i) {
    await page.press("ArrowRight", "ArrowRight", 39);
    await new Promise((r) => setTimeout(r, Number(process.env.SHOOT_WAIT ?? 2500))); // SHOOT_WAIT ms: a timed reveal may still be running
  }
  let location = await page.evaluate("globalThis.gr4Location || ''");
  for (let shot = 0; shot < Number(process.env.SHOOT_MAX ?? 150); ++shot) {
    await new Promise((r) => setTimeout(r, 1200)); // fades and image decoding
    const file = path.join(out, `${String(shot).padStart(3, "0")}-${location.replace(/[^a-z0-9=&-]/gi, "_")}.png`);
    await page.screenshot(file);
    log.push(`${shot}: ${location}`);
    await page.press("ArrowRight", "ArrowRight", 39);
    let next = location;
    try {
      next = await page.waitFor(`(globalThis.gr4Location || '') !== ${JSON.stringify(location)} ? (globalThis.gr4Location || '') : false`, 8000);
    } catch {
      break; // the last view
    }
    location = next;
  }
  await writeFile(path.join(out, "console.txt"), page.consoleLines.join("\n"));
  await page.close();
} catch (error) {
  log.push(`error: ${error.message}`);
} finally {
  await browser.stop();
  await writeFile(path.join(out, "log.txt"), log.join("\n"));
  console.log(log.join("\n"));
}
