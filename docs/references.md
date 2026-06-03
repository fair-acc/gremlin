# GREMLIN — References

## Citing GREMLIN

```bibtex
@software{gremlin_software,
  title        = {{GREMLIN} -- {GR}een Energy Monitoring for Large
                  {IN}frastructure},
  author       = {Steinhagen, Ralph J. and others},
  organization = {GSI Helmholtzzentrum f{\"u}r Schwerionenforschung / FAIR},
  year         = {2026},
  url          = {https://github.com/fair-acc/gremlin},
  note         = {Developed under EU Horizon Europe Grant Agreement
                  No.\ 101275935 (iRIS).},
  doi          = {10.5281/zenodo.20520246}
}

@misc{iris_project,
  title        = {{iRIS} -- Intelligent Research Infrastructure
                  Sustainability},
  howpublished = {EU Horizon Europe Grant Agreement No.\ 101275935},
  year         = {2026},
  url          = {https://ec.europa.eu/info/funding-tenders/opportunities/portal/screen/opportunities/projects-details/43108390/101275935/HORIZON}
}

@software{pulsed_power_ml,
  title        = {pulsed-power-ml: machine-learning prototypes for
                  pulsed-power and energy disaggregation},
  author       = {{fair-acc contributors}},
  organization = {GSI Helmholtzzentrum f{\"u}r Schwerionenforschung / FAIR},
  year         = {TODO},
  url          = {https://github.com/fair-acc/pulsed-power-ml}
  % doi       = {TODO: locate Zenodo DOI if one exists}
}
```

## Bibliography

### Non-Intrusive Load Monitoring (NILM) and disaggregation

- <a id="hart1992"></a>G. W. Hart, "Nonintrusive appliance load monitoring," *Proc. IEEE*, vol. 80, no. 12, pp. 1870–1891, Dec. 1992. doi: [10.1109/5.192069](https://doi.org/10.1109/5.192069).
- <a id="gupta-electrisense-2010"></a>S. Gupta, M. S. Reynolds, and S. N. Patel, "ElectriSense: single-point sensing using EMI for electrical event detection and classification in the home," in *Proc. 12th ACM Int. Conf. Ubiquitous Computing (UbiComp '10)*, Copenhagen, Denmark, 2010, pp. 139–148. doi: [10.1145/1864349.1864375](https://doi.org/10.1145/1864349.1864375).
- <a id="kolter-johnson-redd-2011"></a>J. Z. Kolter and M. J. Johnson, "REDD: a public data set for energy disaggregation research," in *Proc. SustKDD Workshop on Data Mining Applications in Sustainability*, San Diego, CA, 2011. [Project page](https://energy.duke.edu/content/redd-reference-energy-disaggregation-data-set).
- <a id="zeifman-roth-2011"></a>M. Zeifman and K. Roth, "Nonintrusive appliance load monitoring: review and outlook," *IEEE Trans. Consumer Electronics*, vol. 57, no. 1, pp. 76–84, Feb. 2011. doi: [10.1109/TCE.2011.5735484](https://doi.org/10.1109/TCE.2011.5735484).
- <a id="zoha-2012"></a>A. Zoha, A. Gluhak, M. A. Imran, and S. Rajasegarar, "Non-intrusive load monitoring approaches for disaggregated energy sensing: a survey," *Sensors*, vol. 12, no. 12, pp. 16838–16866, Dec. 2012. doi: [10.3390/s121216838](https://doi.org/10.3390/s121216838).
- <a id="batra-nilmtk-2014"></a>N. Batra, J. Kelly, O. Parson, H. Dutta, W. Knottenbelt, A. Rogers, A. Singh, and M. Srivastava, "NILMTK: an open source toolkit for non-intrusive load monitoring," in *Proc. 5th Int. Conf. Future Energy Systems (ACM e-Energy)*, Cambridge, UK, 2014. doi: [10.1145/2602044.2602051](https://doi.org/10.1145/2602044.2602051).
- <a id="kelly-knottenbelt-neural-2015"></a>J. Kelly and W. Knottenbelt, "Neural NILM: deep neural networks applied to energy disaggregation," in *Proc. 2nd ACM Int. Conf. Embedded Systems for Energy-Efficient Built Environments (BuildSys '15)*, Seoul, 2015, pp. 55–64. doi: [10.1145/2821650.2821672](https://doi.org/10.1145/2821650.2821672).
- <a id="kelly-knottenbelt-ukdale-2015"></a>J. Kelly and W. Knottenbelt, "The UK-DALE dataset, domestic appliance-level electricity demand and whole-house demand from five UK homes," *Scientific Data*, vol. 2, art. 150007, 2015. doi: [10.1038/sdata.2015.7](https://doi.org/10.1038/sdata.2015.7).

### Foundations and historical lineage of EM-signature observation

- <a id="hertz1888"></a>H. Hertz, "Über die Ausbreitung der elektrischen Kraft" (On the propagation of electric force), *Annalen der Physik*, vol. 270, no. 7, pp. 551–569, 1888. doi: [10.1002/andp.18882700708](https://doi.org/10.1002/andp.18882700708).
- <a id="nsa-tempest-1972"></a>National Security Agency, *TEMPEST: A Signal Problem* (declassified), *Cryptologic Spectrum*, 1972 (declassified 2007). [PDF](https://www.nsa.gov/portals/75/documents/news-features/declassified-documents/cryptologic-spectrum/tempest.pdf).
- <a id="vaneck1985"></a>W. van Eck, "Electromagnetic radiation from video display units: an eavesdropping risk?," *Computers & Security*, vol. 4, no. 4, pp. 269–286, Dec. 1985. doi: [10.1016/0167-4048(85)90046-X](https://doi.org/10.1016/0167-4048(85)90046-X).
- <a id="kuhn-emanations-2003"></a>M. G. Kuhn, "Compromising emanations: eavesdropping risks of computer displays," Univ. Cambridge Computer Laboratory, Tech. Rep. UCAM-CL-TR-577, Dec. 2003. doi: [10.48456/tr-577](https://doi.org/10.48456/tr-577).
- <a id="kuhn-flat-panel-2005"></a>M. G. Kuhn, "Electromagnetic eavesdropping risks of flat-panel displays," in *Privacy Enhancing Technologies (PET 2004)*, LNCS vol. 3424, Berlin: Springer, 2005, pp. 88–107. doi: [10.1007/11423409_7](https://doi.org/10.1007/11423409_7).

### Ageing as signature — component-level EM evolution

The basis for GREMLIN's *availability* axis: as power-electronic components age, their conducted-EMI and harmonic signatures evolve
in measurable, characteristic ways *before* the device fails.

- <a id="kulkarni-cap-2012"></a>C. S. Kulkarni, J. R. Celaya, K. Goebel, and G. Biswas, "Physics-based electrolytic capacitor degradation models for prognostic studies under thermal overstress," in *Proc. European Conf. Prognostics and Health Management Society*, 2012, vol. 1, no. 1. doi: [10.36001/phme.2012.v1i1.1423](https://doi.org/10.36001/phme.2012.v1i1.1423).
- <a id="boyer-buck-2014"></a>A. Boyer, H. Huang, and S. Ben Dhia, "Impact of thermal aging on emission of a buck DC-DC converter," in *2014 Int. Symp. Electromagnetic Compatibility, Tokyo*, 2014, pp. 77–80. [Preprint on HAL](https://hal.science/hal-01006115).
- <a id="huang-buck-2015"></a>H. Huang, A. Boyer, and S. Ben Dhia, "Analysis and modeling of passive device degradation for a long-term electromagnetic emission study of a DC–DC converter," *Microelectronics Reliability*, vol. 55, no. 9–10, pp. 2061–2066, 2015. doi: [10.1016/j.microrel.2015.06.142](https://doi.org/10.1016/j.microrel.2015.06.142).
- <a id="dimech-igbt-2018"></a>E. Dimech and J. F. Dawson, "Electrical parameters characterization of aged IGBTs by thermo-electrical overstress," in *IECON 2018 — 44th Annual Conf. IEEE Industrial Electronics Society*, 2018, pp. 5924–5929. doi: [10.1109/IECON.2018.8591088](https://doi.org/10.1109/IECON.2018.8591088).
- <a id="dimech-igbt-2024"></a>E. Dimech and J. F. Dawson, "IGBT's ageing and its impacts on the EM conducted emissions," in *EMC Europe 2024 (IEEE Int. Symp. Electromagnetic Compatibility)*, 2024. doi: [10.1109/EMCEurope59828.2024.10722359](https://doi.org/10.1109/EMCEurope59828.2024.10722359). [Open-access post-print (University of Malta OAR)](https://www.um.edu.mt/library/oar/bitstream/123456789/130250/1/IGBTs_Ageing_and_its_Impacts_on_the_EM_Conducted_Emissions_2024.pdf); [York Pure portal](https://pure.york.ac.uk/portal/en/publications/igbts-ageing-and-its-impacts-on-the-em-conducted-emissions).

### Platform and tooling

- <a id="gnuradio4"></a>FAIR-ACC contributors, *GNU Radio 4.0 (`gnuradio4`)* (software), GSI/FAIR. <https://github.com/fair-acc/gnuradio4>
- <a id="onnx"></a>ONNX, *Open Neural Network Exchange — open standard for machine-learning interoperability*. <https://onnx.ai/>

### Project and predecessor

- <a id="pulsed-power-ml"></a>R. J. Steinhagen, J. Heuser, S. Förstel, T. Kittler, and A. Krimm, *pulsed-power-ml* (software), GSI/FAIR. <https://github.com/fair-acc/pulsed-power-ml>
- <a id="iris-grant"></a><a id="iris-eu-portal"></a>iRIS — *Intelligent Research Infrastructure Sustainability*, EU Horizon Europe Grant Agreement No. 101275935. [Project page on the EU Funding & Tenders portal](https://ec.europa.eu/info/funding-tenders/opportunities/portal/screen/opportunities/projects-details/43108390/101275935/HORIZON)
- <a id="iris-zenodo-community"></a>iRIS Zenodo community. <https://zenodo.org/communities/101275935/>
- <a id="iris-zenodo-records"></a>iRIS Zenodo records. <https://zenodo.org/communities/101275935/records>
