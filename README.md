**TODO**
 * Create omop schema
 * Create omop v6 tables (non-vocab)
 * Read in sql export, convert `copy ... from stdin` to `insert into ... values`
   - remove `\N`
   - add quotes around values
 * Run the converted sql
 * Apply indices and constraints (to vocab)
 * Create view of vocab tables in the new schema
 * Create results schema + concept hierarchy
 * Run Achilles

# Process
Inputs:
- cdm schema name
- results schema name
- source name and source key

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
11. Run Achilles from Jupyter notebook
12. Add new source in Atlas Configuration
    - copy connection string details from existing (connection string, user, password)
    - cdm = `<schema_name>`
    - results = `<results_schema_name>`
    - temp = temp
    - vocabulary = vocab
