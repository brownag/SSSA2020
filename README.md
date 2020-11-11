## Andrew's Soil Science Society of America (SSSA) 2020 Presentations:

### [Enhancing Accuracy and Applicability of U.S. Soil Taxonomy (PDF)](https://github.com/brownag/SSSA2020/raw/master/Enhancing%20Accuracy%20and%20Applicability%20of%20U.S.%20Soil%20Taxonomy/Enhancing-Accuracy-and-Applicability-of-U.S.-Soil-Taxonomy.pdf)

#### Abstract

Pedologic knowledge has been hard won through the work of countless soil and earth scientists. This knowledge been distilled into standards and classification systems that allow us to consistently reason over diverse and complex natural systems. As new needs arise and knowledge is gained, criteria for classification and separation of concepts are refined and historic criteria are called in to question. Determining potential impacts of new or altered criteria throughout a classification system is complicated and time-consuming – perfect for the application of computer-aided reasoning. However, soils data and soil classification systems, particularly U.S. Soil Taxonomy, have nuances that require careful consideration.

Changes to criteria that affect fundamental diagnostic features in Soil Taxonomy can have large influences on classification and, by association, grouping of soil concepts that are similar for use and management in soil surveys. We have developed data structures and computer code in the R package “aqp," or Algorithms for Quantitative Pedology, that are capable of reasoning over soil profile data and criteria. This implementation of concepts has offered novel opportunities for data-driven analyses relating properties (predicted or observed) to taxonomic or interpretive groups. Routines for programmatic identification of soil features such as argillic horizons and mollic epipedons are fundamental steps towards automated classification using U.S. Soil Taxonomy.

---

### [Expanding the Toolkit for Soil Scientists: the {aqp} R package (PDF)](https://github.com/brownag/SSSA2020/raw/master/Expanding%20the%20Toolkit%20for%20Soil%20Scientists/Expanding-the-Toolkit-for-Soil-Scientists.pdf)

#### Abstract

Algorithms for Quantitative Pedology was designed to be a “toolkit for soil scientists.” The aqp R package provides functions that support data-driven tasks such as visualization, aggregation, and classification of soil profiles. The code is open-source and under active development by members of the National Cooperative Soil Survey (https://github.com/ncss-tech/aqp). The aqp project is an example of 10 years of continuity of analytical software development by volunteers and government employees.

Recent additions to the package include new functionality for working with groups and portions of profiles. Major changes have been made to the structure of the SoilProfileCollection object, iteration (profileApply), filtering (filter) and sub-setting ([[, glom, split/combine). For iteration over large (n > 10,000) collections of soil profiles, optimizations have yielded over an order of magnitude decrease in processing time relative to earlier versions (pre-1.18.5), bringing larger analyses within reach. New “verbs” simplify syntax: allowing users to answer their pedologic questions with fewer intermediate steps and lines of code. These enhancements provide a basis for new functions that use horizon attributes to estimate U.S. Soil Taxonomy criteria, diagnostic features, and more.

With pedon and component data obtained from the soilDB R package (https://github.com/ncss-tech/soilDB) and other sources, new aqp functions can be used to increase efficiency of quality control on soil survey data, for evaluation of taxonomic structures, as well as for testing of new criteria. The automated estimation of taxonomic criteria has been successfully applied in review of 2020 NCSS Regional Standards and Taxonomy Committee Proposals as well as for routine soil survey applications in the Southwest Soil Survey Region.

### {xaringan} R markdown slides

For a crash course in {xaringan} slides check out this great presentation from the 2019 _Advanced R Markdown Workshop_ (ARM) or other great resources from the package author.

 - http://arm.rbind.io/slides/xaringan.html

 - https://bookdown.org/yihui/rmarkdown/xaringan.html
 
 - https://slides.yihui.org/xaringan/incremental.html
