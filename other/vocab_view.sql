-- Set search path to the correct schema if running this script independently
-- SET search_path TO <dataset_schema>;

CREATE OR REPLACE VIEW concept AS (SELECT * FROM vocab.concept);
CREATE OR REPLACE VIEW concept_relationship AS (SELECT * FROM vocab.concept_relationship);
CREATE OR REPLACE VIEW concept_ancestor AS (SELECT * FROM vocab.concept_ancestor);
CREATE OR REPLACE VIEW concept_synonym AS (SELECT * FROM vocab.concept_synonym);
CREATE OR REPLACE VIEW concept_class AS (SELECT * FROM vocab.concept_class);
CREATE OR REPLACE VIEW domain AS (SELECT * FROM vocab.domain);
CREATE OR REPLACE VIEW vocabulary AS (SELECT * FROM vocab.vocabulary);
CREATE OR REPLACE VIEW relationship AS (SELECT * FROM vocab.relationship);
CREATE OR REPLACE VIEW drug_strength AS (SELECT * FROM vocab.drug_strength);
CREATE OR REPLACE VIEW source_to_concept_map AS (SELECT * FROM vocab.source_to_concept_map);
