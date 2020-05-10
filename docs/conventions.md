# General conventions

## OMOP CDM
### Version
PIONEER datasets are converted to [OMOP CDM V6.0.0](https://github.com/OHDSI/CommonDataModel/wiki) plus [oncology extensions](https://github.com/OHDSI/OncologyWG/wiki).
The *Episode* and *Episode Event* tables are added to the OMOP CDM. 
In addition, the fields ``modifier_of_event`` and ``modifier_of_field_concept_id`` are added to the *Measurement* table.

## OMOP Vocabularies
### Version
The latest OMOP vocabulary can be downloaded from [Athena](http://athena.ohdsi.org/).
The version loaded on the central PIONEER server can be found by going to the [Atlas Configuration](https://pioneer-atlas.thehyve.net/#/configure) page 
(at the time of writing this is `v5.0 01-AUG-19`). 

### Mapping
Terms found in the source data are mapped to concepts in the OMOP standard vocabularies to achieve semantic interoperability. In most cases a mapping to a standard concept with the same meaning as the source term can be made. If this is not possible, we map the source term to a non-standard concept. If there is also no non-standard concept matching the source term, then we create a custom 'PIONEER' concept.

To summarise, we have the following three options for semantic mapping, with decreasing priority:
1. Mapping to a standard concept
2. Mapping to a non-standard concept
3. Mapping to a custom PIONEER concept

### Custom vocabulary
Whenever appropriate concepts are missing in the OMOP Vocabulary, custom concepts are used.
These custom concepts are aligned within PIONEER. 
The PIONEER custom vocabulary can be found [here](https://github.com/thehyve/ohdsi-omop-pioneer/tree/master/pioneer_custom_vocabulary).

If a custom concept is added to the PIONEER custom vocabulary, and this custom concept becomes obsolete in a later stage of the ETL development process, 
the custom concept is not removed from the PIONEER custom vocabulary but is assigned a "D" (Deleted) in the ``standard_concept`` column of the PIONEER custom vocabulary file.  

### Other conventions
* [Concept id 4163261](https://athena.ohdsi.org/search-terms/terms/4163261) ('Malignant tumor of prostate') is used to record a diagnosis of prostate cancer.



## Syntactic mapping
In general we try to 

### Date
- When only year is stored in the data (and month and day are missing), the first of July (07-01) is used as a proxy. This day will be, on average, the closest to the actual date.
- When year is not stored in the dataset, the following steps and conventions are followed:
	1. Decide whether the record will be kept. A missing date could point to a quality issue in the source data. If decided not the keep the record, do not map the date. 
	2. If decided to map the record:
       1. Try to derive year from the context, for example take the data of a related procedure when mapping a conditioning regimen.
       2. If year can not be derived, use ``1970-01-01`` for both ``start_date`` and ``end_date``.
	   
	   Exception: When ``observation_period.observation_period_end_date can`` not be derived, take last date of ETL run.

### Condition Occurrence
In some cases the primary diagnosis is not captured in the data itself, but has to derived from the protocol. 
For instance in ERSPC, the diagnosis of prostate cancer is not recorded separately (only a year of PCa diagnosis is given).
In that case a condition occurrence record "Malignant tumor of prostate" ([4163261](https://athena.ohdsi.org/search-terms/terms/4163261)) is stored.  

### Care site & Location
Due to privacy reasons, the exact care site and location values are not mapped to the corresponding OMOP tables. 

### CDM Source
The name and location of the dataset are not captured in the `cdm_source` table.
A record is created in this table, with the ETL date, source extraction date, ETL reference, vocab version and OMOP CDM version.