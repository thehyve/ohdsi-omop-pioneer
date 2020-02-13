# PIONEER OMOP repository
Contents:
* OMOP CDM definition plus extensions
* Data loading scripts
* PIONEER vocabulary extension

# Data loading process
As implemented in [load_cdm_data.ipynb](load_cdm_data.ipynb)

Inputs:
- cdm schema name
- results schema name

1. `CREATE SCHEMA <schema_name>;`
2. `SET search_path TO <schema_name>;`
3. pioneer_omop_cdm/OMOP CDM postgresql v6_0_dev ddl.sql
4. load data
5. pioneer_omop_cdm/OMOP CDM postgresql v6_0_dev constraints.sql
6. pioneer_omop_cdm/OMOP CDM postgresql v6_0_dev pk indexes.sql
7. other/vocab_view.sql
8. `CREATE SCHEMA <results_schema_name>;`
9. `SET search_path TO <results_schema_name>;`
10. other/results_ddl_hierarchy_2.7.4.sql
11. Run Achilles in R
12. Add new source in Atlas Configuration via configuration UI
