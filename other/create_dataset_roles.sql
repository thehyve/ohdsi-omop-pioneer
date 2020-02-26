-- Create read access roles for when a new dataset has been added.
-- Separate access roles are created for the results schema, the CDM schema and the combination of the two.
-- The following statements assume the results schema is named like <cdm_schema_name>_results. If not, adjust accordingly.

CREATE ROLE <dataset_schema_name>_results_group WITH NOLOGIN; -- Role for the results schema
CREATE ROLE <dataset_schema_name>_data_group WITH NOLOGIN; -- Role for the CDM data schema
CREATE ROLE <dataset_schema_name>_group WITH NOLOGIN; -- Role for both schemas

-- Make the role for access to both schemas inherit the other two roles
GRANT <dataset_schema_name>_data_group TO <dataset_schema_name>_group;
GRANT <dataset_schema_name>_results_group TO <dataset_schema_name>_group;

-- Grant access to the schema itself
GRANT USAGE ON SCHEMA <dataset_schema_name> TO <dataset_schema_name>_data_group;
GRANT USAGE ON SCHEMA <dataset_schema_name>_results TO <dataset_schema_name>_results_group;

-- Grant read access to all current and future tables in the CDM data schema to the data access role 
GRANT SELECT ON ALL TABLES IN SCHEMA <dataset_schema_name> TO <dataset_schema_name>_data_group;
ALTER DEFAULT PRIVILEGES IN SCHEMA <dataset_schema_name> GRANT SELECT ON TABLES TO <dataset_schema_name>_data_group;

-- Grant read access to all current and future tables in the results schema to the results access role 
GRANT SELECT ON ALL TABLES IN SCHEMA <dataset_schema_name>_results TO <dataset_schema_name>_results_group;
ALTER DEFAULT PRIVILEGES IN SCHEMA <dataset_schema_name>_results GRANT SELECT ON TABLES TO <dataset_schema_name>_results_group;

-- Make the role for access to all datasets inherit the newly added one
GRANT <dataset_schema_name>_group TO all_datasets;