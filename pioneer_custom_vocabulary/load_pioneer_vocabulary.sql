/*********************************************************************************
# Copyright 2021 The Hyve.
#
# Load the PIONEER custom vocabulary into an existing vocabulary instance.
# Existing 2B concepts are first deleted and the concepts newly inserted.
********************************************************************************/

SET search_path TO vocab;

-- If needed, remove any existing custom vocabulary.
-- DELETE FROM vocabulary WHERE vocabulary_id = 'PIONEER';
-- DELETE FROM concept_class WHERE concept_class_concept_id = 0;
-- DELETE FROM concept WHERE concept_id >= 2000000000;

COPY vocabulary FROM 'pioneer_vocabulary.csv' WITH DELIMITER ',' CSV HEADER QUOTE E'\b' ;

COPY concept_class FROM 'pioneer_concept_class.csv' WITH DELIMITER ',' CSV HEADER QUOTE E'\b' ;

COPY concept FROM 'pioneer_concepts.csv' WITH DELIMITER ',' CSV HEADER QUOTE E'\b' ;

