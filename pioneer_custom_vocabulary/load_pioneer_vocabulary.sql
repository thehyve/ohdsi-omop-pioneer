/*********************************************************************************
# Copyright 2020 The Hyve.
#
# Load the PIONEER custom vocabulary into an existing vocabulary instance.
# Existing 2B concepts are first deleted and the concepts newly inserted.
********************************************************************************/

SET search_path TO vocab;

DELETE FROM vocabulary WHERE vocabulary_id = 'PIONEER';
DELETE FROM concept WHERE concept_id >= 2000000000;

COPY vocabulary FROM 'vocabulary.csv' WITH DELIMITER ',' CSV HEADER QUOTE E'\b' ;

COPY concept FROM 'pioneer_concepts.csv' WITH DELIMITER ',' CSV HEADER QUOTE E'\b' ;

