-- v2.7.4
-- http://atlas-demo.ohdsi.org/WebAPI/ddl/results?dialect=postgresql&schema=results_schema&vocabSchema=vocab_schema&tempSchema=temp_schema&initConceptHierarchy=true
-- Note: due to login, it is not possible to generate this directly from the pioneer-atlas WebAPI url


-- Set search path to the correct schema if running this script independently
-- SET search_path TO <dataset_results_schema>;


CREATE TABLE IF NOT EXISTS cohort
(COHORT_DEFINITION_ID int NOT NULL,
 SUBJECT_ID bigint NOT NULL,
 cohort_start_date date NOT NULL,
 cohort_end_date date NOT NULL
);


CREATE TABLE IF NOT EXISTS cohort_features
(cohort_definition_id bigint,
 covariate_id bigint,
 sum_value bigint,
 average_value NUMERIC
);


CREATE TABLE IF NOT EXISTS cohort_features_analysis_ref
(cohort_definition_id bigint,
 analysis_id int,
 analysis_name varchar(1000),
    domain_id varchar(100),
    start_day int,
    end_day int,
    is_binary char,
    missing_means_zero char
    );


CREATE TABLE IF NOT EXISTS cohort_features_dist
(cohort_definition_id bigint,
 covariate_id bigint,
 count_value NUMERIC,
 min_value NUMERIC,
 max_value NUMERIC,
 average_value NUMERIC,
 standard_deviation NUMERIC,
 median_value NUMERIC,
 p10_value NUMERIC,
 p25_value NUMERIC,
 p75_value NUMERIC,
 p90_value NUMERIC
);


CREATE TABLE IF NOT EXISTS cohort_features_ref
(cohort_definition_id bigint,
 covariate_id bigint,
 covariate_name varchar(1000),
    analysis_id int,
    concept_id int
    );


CREATE TABLE IF NOT EXISTS cohort_inclusion (cohort_definition_id int NOT NULL,
                                                              rule_sequence int NOT NULL,
                                                              name varchar(255) NULL,
    description varchar(1000) NULL
    );


CREATE TABLE IF NOT EXISTS cohort_inclusion_result (cohort_definition_id int NOT NULL,
                                                                     mode_id int NOT NULL,
                                                                     inclusion_rule_mask bigint NOT NULL,
                                                                     person_count bigint NOT NULL
);


CREATE TABLE IF NOT EXISTS cohort_inclusion_stats (cohort_definition_id int NOT NULL,
                                                                    rule_sequence int NOT NULL,
                                                                    mode_id int NOT NULL,
                                                                    person_count bigint NOT NULL,
                                                                    gain_count bigint NOT NULL,
                                                                    person_total bigint NOT NULL
);


CREATE TABLE IF NOT EXISTS cohort_summary_stats (cohort_definition_id int NOT NULL,
                                                                  mode_id int NOT NULL,
                                                                  base_count bigint NOT NULL,
                                                                  final_count bigint NOT NULL
);


CREATE TABLE IF NOT EXISTS cohort_censor_stats (cohort_definition_id int NOT NULL,
                                                                 lost_count BIGINT NOT NULL
);


CREATE TABLE IF NOT EXISTS feas_study_inclusion_stats (study_id int NOT NULL,
                                                                        rule_sequence int NOT NULL,
                                                                        name varchar(255) NOT NULL,
    person_count bigint NOT NULL,
    gain_count bigint NOT NULL,
    person_total bigint NOT NULL
    );


CREATE TABLE IF NOT EXISTS feas_study_index_stats (study_id int NOT NULL,
                                                                    person_count bigint NOT NULL,
                                                                    match_count bigint NOT NULL
);


CREATE TABLE IF NOT EXISTS feas_study_result (study_id int NOT NULL,
                                                               inclusion_rule_mask bigint NOT NULL,
                                                               person_count bigint NOT NULL
);


CREATE TABLE IF NOT EXISTS heracles_analysis
(analysis_id int,
 analysis_name varchar(255),
    stratum_1_name varchar(255),
    stratum_2_name varchar(255),
    stratum_3_name varchar(255),
    stratum_4_name varchar(255),
    stratum_5_name varchar(255),
    analysis_type varchar(255)
    );


CREATE TABLE IF NOT EXISTS HERACLES_HEEL_results
(cohort_definition_id int,
 analysis_id INT,
 HERACLES_HEEL_warning VARCHAR(255)
    );


CREATE TABLE IF NOT EXISTS heracles_results
(cohort_definition_id int,
 analysis_id int,
 stratum_1 varchar(255),
    stratum_2 varchar(255),
    stratum_3 varchar(255),
    stratum_4 varchar(255),
    stratum_5 varchar(255),
    count_value bigint,
    last_update_time TIMESTAMP DEFAULT CURRENT_DATE
    );


CREATE TABLE IF NOT EXISTS heracles_results_dist
(cohort_definition_id int,
 analysis_id int,
 stratum_1 varchar(255),
    stratum_2 varchar(255),
    stratum_3 varchar(255),
    stratum_4 varchar(255),
    stratum_5 varchar(255),
    count_value bigint,
    min_value NUMERIC,
    max_value NUMERIC,
    avg_value NUMERIC,
    stdev_value NUMERIC,
    median_value NUMERIC,
    p10_value NUMERIC,
    p25_value NUMERIC,
    p75_value NUMERIC,
    p90_value NUMERIC,
    last_update_time TIMESTAMP DEFAULT CURRENT_DATE
    );


CREATE TABLE IF NOT EXISTS ir_analysis_dist  (analysis_id int NOT NULL,
                                                               target_id int NOT NULL,
                                                               outcome_id int NOT NULL,
                                                               strata_sequence int NULL,
                                                               dist_type int NOT NULL,
                                                               total bigint NOT NULL,
                                                               avg_value NUMERIC NOT NULL,
                                                               std_dev NUMERIC NOT NULL,
                                                               min_value int NOT NULL,
                                                               p10_value int NOT NULL,
                                                               p25_value int NOT NULL,
                                                               median_value int NOT NULL,
                                                               p75_value int NOT NULL,
                                                               p90_value int NOT NULL,
                                                               max_value int NULL
);


CREATE TABLE IF NOT EXISTS ir_analysis_result (analysis_id int NOT NULL,
                                                                target_id int NOT NULL,
                                                                outcome_id int NOT NULL,
                                                                strata_mask bigint NOT NULL,
                                                                person_count bigint NOT NULL,
                                                                time_at_risk bigint NOT NULL,
                                                                cases bigint NOT NULL
);


CREATE TABLE IF NOT EXISTS ir_analysis_strata_stats (analysis_id int NOT NULL,
                                                                      target_id int NOT NULL,
                                                                      outcome_id int NOT NULL,
                                                                      strata_sequence int NOT NULL,
                                                                      person_count bigint NOT NULL,
                                                                      time_at_risk bigint NOT NULL,
                                                                      cases bigint NOT NULL
);


CREATE TABLE IF NOT EXISTS ir_strata (analysis_id int NOT NULL,
                                                       strata_sequence int NOT NULL,
                                                       name varchar(255) NULL,
    description varchar(1000) NULL
    );


CREATE TABLE IF NOT EXISTS heracles_periods
(period_id int,
 period_order int,
 period_name varchar(255),
    period_type varchar(50),
    period_start_date date,
    period_end_date date
    );

CREATE TABLE IF NOT EXISTS cc_results
(type VARCHAR(255) NOT NULL,
    fa_type VARCHAR(255) NOT NULL,
    cc_generation_id BIGINT NOT NULL,
    analysis_id INTEGER,
    analysis_name VARCHAR(1000),
    covariate_id BIGINT,
    covariate_name VARCHAR(1000),
    strata_id BIGINT,
    strata_name VARCHAR(1000),
    time_window VARCHAR(255),
    concept_id INTEGER NOT NULL,
    count_value BIGINT,
    avg_value DOUBLE PRECISION,
    stdev_value DOUBLE PRECISION,
    min_value DOUBLE PRECISION,
    p10_value DOUBLE PRECISION,
    p25_value DOUBLE PRECISION,
    median_value DOUBLE PRECISION,
    p75_value DOUBLE PRECISION,
    p90_value DOUBLE PRECISION,
    max_value DOUBLE PRECISION,
    cohort_definition_id BIGINT
    );

CREATE TABLE IF NOT EXISTS pathway_analysis_codes
(pathway_analysis_generation_id BIGINT NOT NULL,
 code BIGINT NOT NULL,
 name VARCHAR(2000) NOT NULL,
    is_combo int NOT NULL
    );

CREATE TABLE IF NOT EXISTS pathway_analysis_events
(pathway_analysis_generation_id BIGINT NOT NULL,
 target_cohort_id INTEGER NOT NULL,
 combo_id BIGINT NOT NULL,
 subject_id BIGINT NOT NULL,
 ordinal INTEGER,
 cohort_start_date TIMESTAMP NOT NULL,
 cohort_end_date TIMESTAMP NOT NULL
);


CREATE TABLE IF NOT EXISTS pathway_analysis_paths
(pathway_analysis_generation_id BIGINT NOT NULL,
 target_cohort_id INTEGER NOT NULL,
 step_1 BIGINT,
 step_2 BIGINT,
 step_3 BIGINT,
 step_4 BIGINT,
 step_5 BIGINT,
 step_6 BIGINT,
 step_7 BIGINT,
 step_8 BIGINT,
 step_9 BIGINT,
 step_10 BIGINT,
 count_value BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS pathway_analysis_stats
(pathway_analysis_generation_id BIGINT NOT NULL,
 target_cohort_id INTEGER NOT NULL,
 target_cohort_count BIGINT NOT NULL,
 pathways_count BIGINT NOT NULL
);

-- init heracles_analysis

TRUNCATE TABLE heracles_analysis;

insert into heracles_analysis
(analysis_id,analysis_name,stratum_1_name,stratum_2_name,stratum_3_name,stratum_4_name,stratum_5_name,analysis_type)
select    0 as analysis_id,
          CAST('Source name' as VARCHAR(255)) as analysis_name,
          CAST(NULL AS VARCHAR(255)) as stratum_1_name,
          CAST(NULL AS VARCHAR(255)) as stratum_2_name,
          CAST(NULL AS VARCHAR(255)) as stratum_3_name,
          CAST(NULL AS VARCHAR(255)) as stratum_4_name,
          CAST(NULL AS VARCHAR(255)) as stratum_5_name,
          CAST('PERSON' as VARCHAR(255)) as analysis_type
union all
select    1 as analysis_id,
          CAST('Number of persons' as VARCHAR(255)) as analysis_name,
          CAST(NULL AS VARCHAR(255)) as stratum_1_name,
          CAST(NULL AS VARCHAR(255)) as stratum_2_name,
          CAST(NULL AS VARCHAR(255)) as stratum_3_name,
          CAST(NULL AS VARCHAR(255)) as stratum_4_name,
          CAST(NULL AS VARCHAR(255)) as stratum_5_name,
          CAST('PERSON' as VARCHAR(255)) as analysis_type
union all
select    2 as analysis_id,
          CAST('Number of persons by gender' as VARCHAR(255)) as analysis_name,
          CAST('gender_concept_id' as VARCHAR(255)) as stratum_1_name,
          CAST(NULL AS VARCHAR(255)) as stratum_2_name,
          CAST(NULL AS VARCHAR(255)) as stratum_3_name,
          CAST(NULL AS VARCHAR(255)) as stratum_4_name,
          CAST(NULL AS VARCHAR(255)) as stratum_5_name,
          CAST('PERSON' as VARCHAR(255)) as analysis_type
union all
select    3 as analysis_id,
          CAST('Number of persons by year of birth' as VARCHAR(255)) as analysis_name,
          CAST('year_of_birth' as VARCHAR(255)) as stratum_1_name,
          CAST(NULL AS VARCHAR(255)) as stratum_2_name,
          CAST(NULL AS VARCHAR(255)) as stratum_3_name,
          CAST(NULL AS VARCHAR(255)) as stratum_4_name,
          CAST(NULL AS VARCHAR(255)) as stratum_5_name,
          CAST('PERSON' as VARCHAR(255)) as analysis_type
union all
select    4 as analysis_id,
          CAST('Number of persons by race' as VARCHAR(255)) as analysis_name,
          CAST('race_concept_id' as VARCHAR(255)) as stratum_1_name,
          CAST(NULL AS VARCHAR(255)) as stratum_2_name,
          CAST(NULL AS VARCHAR(255)) as stratum_3_name,
          CAST(NULL AS VARCHAR(255)) as stratum_4_name,
          CAST(NULL AS VARCHAR(255)) as stratum_5_name,
          CAST('PERSON' as VARCHAR(255)) as analysis_type
union all
select    5 as analysis_id,
          CAST('Number of persons by ethnicity' as VARCHAR(255)) as analysis_name,
          CAST('ethnicity_concept_id' as VARCHAR(255)) as stratum_1_name,
          CAST(NULL AS VARCHAR(255)) as stratum_2_name,
          CAST(NULL AS VARCHAR(255)) as stratum_3_name,
          CAST(NULL AS VARCHAR(255)) as stratum_4_name,
          CAST(NULL AS VARCHAR(255)) as stratum_5_name,
          CAST('PERSON' as VARCHAR(255)) as analysis_type
union all
select    7 as analysis_id,
          CAST('Number of persons with invalid provider_id' as VARCHAR(255)) as analysis_name,
          CAST(NULL AS VARCHAR(255)) as stratum_1_name,
          CAST(NULL AS VARCHAR(255)) as stratum_2_name,
          CAST(NULL AS VARCHAR(255)) as stratum_3_name,
          CAST(NULL AS VARCHAR(255)) as stratum_4_name,
          CAST(NULL AS VARCHAR(255)) as stratum_5_name,
          CAST('PERSON' as VARCHAR(255)) as analysis_type
union all
select    8 as analysis_id,
          CAST('Number of persons with invalid location_id' as VARCHAR(255)) as analysis_name,
          CAST(NULL AS VARCHAR(255)) as stratum_1_name,
          CAST(NULL AS VARCHAR(255)) as stratum_2_name,
          CAST(NULL AS VARCHAR(255)) as stratum_3_name,
          CAST(NULL AS VARCHAR(255)) as stratum_4_name,
          CAST(NULL AS VARCHAR(255)) as stratum_5_name,
          CAST('PERSON' as VARCHAR(255)) as analysis_type
union all
select    9 as analysis_id,
          CAST('Number of persons with invalid care_site_id' as VARCHAR(255)) as analysis_name,
          CAST(NULL AS VARCHAR(255)) as stratum_1_name,
          CAST(NULL AS VARCHAR(255)) as stratum_2_name,
          CAST(NULL AS VARCHAR(255)) as stratum_3_name,
          CAST(NULL AS VARCHAR(255)) as stratum_4_name,
          CAST(NULL AS VARCHAR(255)) as stratum_5_name,
          CAST('PERSON' as VARCHAR(255)) as analysis_type
union all
select  101 as analysis_id,
        CAST('Number of persons by age, with age at first observation period' as VARCHAR(255)) as analysis_name,
        CAST('age' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  102 as analysis_id,
        CAST('Number of persons by gender by age, with age at first observation period' as VARCHAR(255)) as analysis_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('age' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  103 as analysis_id,
        CAST('Distribution of age at first observation period' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  104 as analysis_id,
        CAST('Distribution of age at first observation period by gender' as VARCHAR(255)) as analysis_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  105 as analysis_id,
        CAST('Length of observation (days) of first observation period' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  106 as analysis_id,
        CAST('Length of observation (days) of first observation period by gender' as VARCHAR(255)) as analysis_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  107 as analysis_id,
        CAST('Length of observation (days) of first observation period by age decile' as VARCHAR(255)) as analysis_name,
        CAST('age decile' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  108 as analysis_id,
        CAST('Number of persons by length of first observation period, in 30d increments' as VARCHAR(255)) as analysis_name,
        CAST('Observation period length 30d increments' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  109 as analysis_id,
        CAST('Number of persons with continuous observation in each year' as VARCHAR(255)) as analysis_name,
        CAST('calendar year' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  110 as analysis_id,
        CAST('Number of persons with continuous observation in each month' as VARCHAR(255)) as analysis_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  111 as analysis_id,
        CAST('Number of persons by observation period start month' as VARCHAR(255)) as analysis_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  112 as analysis_id,
        CAST('Number of persons by observation period end month' as VARCHAR(255)) as analysis_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  113 as analysis_id,
        CAST('Number of persons by number of observation periods' as VARCHAR(255)) as analysis_name,
        CAST('number of observation periods' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  114 as analysis_id,
        CAST('Number of persons with observation period before year-of-birth' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  115 as analysis_id,
        CAST('Number of persons with observation period end < observation period start' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  116 as analysis_id,
        CAST('Number of persons with at least one day of observation in each year by gender and age decile' as VARCHAR(255)) as analysis_name,
        CAST('calendar year' as VARCHAR(255)) as stratum_1_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_2_name,
        CAST('age decile' as VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  117 as analysis_id,
        CAST('Number of persons with at least one day of observation in each month' as VARCHAR(255)) as analysis_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  200 as analysis_id,
        CAST('Number of persons with at least one visit occurrence, by visit_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('visit_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('VISITS' as VARCHAR(255)) as analysis_type
union all
select  201 as analysis_id,
        CAST('Number of visit occurrence records, by visit_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('visit_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('VISITS' as VARCHAR(255)) as analysis_type
union all
select  202 as analysis_id,
        CAST('Number of persons by visit occurrence start month, by visit_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('visit_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('VISITS' as VARCHAR(255)) as analysis_type
union all
select  203 as analysis_id,
        CAST('Number of distinct visit occurrence concepts per person' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('VISITS' as VARCHAR(255)) as analysis_type
union all
select  204 as analysis_id,
        CAST('Number of persons with at least one visit occurrence, by visit_concept_id by calendar year by gender by age decile' as VARCHAR(255)) as analysis_name,
        CAST('visit_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('calendar year' as VARCHAR(255)) as stratum_2_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_3_name,
        CAST('age decile' as VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('VISITS' as VARCHAR(255)) as analysis_type
union all
select  206 as analysis_id,
        CAST('Distribution of age by visit_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('visit_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('VISITS' as VARCHAR(255)) as analysis_type
union all
select  207 as analysis_id,
        CAST('Number of visit records with invalid person_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('VISITS' as VARCHAR(255)) as analysis_type
union all
select  208 as analysis_id,
        CAST('Number of visit records outside valid observation period' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('VISITS' as VARCHAR(255)) as analysis_type
union all
select  209 as analysis_id,
        CAST('Number of visit records with end date < start date' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('VISITS' as VARCHAR(255)) as analysis_type
union all
select  210 as analysis_id,
        CAST('Number of visit records with invalid care_site_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('VISITS' as VARCHAR(255)) as analysis_type
union all
select  211 as analysis_id,
        CAST('Distribution of length of stay by visit_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('visit_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('VISITS' as VARCHAR(255)) as analysis_type
union all
select  220 as analysis_id,
        CAST('Number of visit occurrence records by visit occurrence start month' as VARCHAR(255)) as analysis_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('VISITS' as VARCHAR(255)) as analysis_type
union all
select  400 as analysis_id,
        CAST('Number of persons with at least one condition occurrence, by condition_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('CONDITION' as VARCHAR(255)) as analysis_type
union all
select  401 as analysis_id,
        CAST('Number of condition occurrence records, by condition_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('CONDITION' as VARCHAR(255)) as analysis_type
union all
select  402 as analysis_id,
        CAST('Number of persons by condition occurrence start month, by condition_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('CONDITION' as VARCHAR(255)) as analysis_type
union all
select  403 as analysis_id,
        CAST('Number of distinct condition occurrence concepts per person' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('CONDITION' as VARCHAR(255)) as analysis_type
union all
select  404 as analysis_id,
        CAST('Number of persons with at least one condition occurrence, by condition_concept_id by calendar year by gender by age decile' as VARCHAR(255)) as analysis_name,
        CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('calendar year' as VARCHAR(255)) as stratum_2_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_3_name,
        CAST('age decile' as VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('CONDITION' as VARCHAR(255)) as analysis_type
union all
select  405 as analysis_id,
        CAST('Number of condition occurrence records, by condition_concept_id by condition_type_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('condition_type_concept_id' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('CONDITION' as VARCHAR(255)) as analysis_type
union all
select  406 as analysis_id,
        CAST('Distribution of age by condition_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('CONDITION' as VARCHAR(255)) as analysis_type
union all
select  409 as analysis_id,
        CAST('Number of condition occurrence records with invalid person_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('CONDITION' as VARCHAR(255)) as analysis_type
union all
select  410 as analysis_id,
        CAST('Number of condition occurrence records outside valid observation period' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('CONDITION' as VARCHAR(255)) as analysis_type
union all
select  411 as analysis_id,
        CAST('Number of condition occurrence records with end date < start date' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('CONDITION' as VARCHAR(255)) as analysis_type
union all
select  412 as analysis_id,
        CAST('Number of condition occurrence records with invalid provider_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('CONDITION' as VARCHAR(255)) as analysis_type
union all
select  413 as analysis_id,
        CAST('Number of condition occurrence records with invalid visit_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('CONDITION' as VARCHAR(255)) as analysis_type
union all
select  420 as analysis_id,
        CAST('Number of condition occurrence records by condition occurrence start month' as VARCHAR(255)) as analysis_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('CONDITION' as VARCHAR(255)) as analysis_type
union all
select  500 as analysis_id,
        CAST('Number of persons with death, by cause_of_death_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('cause_of_death_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DEATH' as VARCHAR(255)) as analysis_type
union all
select  501 as analysis_id,
        CAST('Number of records of death, by cause_of_death_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('cause_of_death_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DEATH' as VARCHAR(255)) as analysis_type
union all
select  502 as analysis_id,
        CAST('Number of persons by death month' as VARCHAR(255)) as analysis_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DEATH' as VARCHAR(255)) as analysis_type
union all
select  504 as analysis_id,
        CAST('Number of persons with a death, by calendar year by gender by age decile' as VARCHAR(255)) as analysis_name,
        CAST('calendar year' as VARCHAR(255)) as stratum_1_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_2_name,
        CAST('age decile' as VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DEATH' as VARCHAR(255)) as analysis_type
union all
select  505 as analysis_id,
        CAST('Number of death records, by death_type_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('death_type_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DEATH' as VARCHAR(255)) as analysis_type
union all
select  506 as analysis_id,
        CAST('Distribution of age at death by gender' as VARCHAR(255)) as analysis_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DEATH' as VARCHAR(255)) as analysis_type
union all
select  509 as analysis_id,
        CAST('Number of death records with invalid person_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DEATH' as VARCHAR(255)) as analysis_type
union all
select  510 as analysis_id,
        CAST('Number of death records outside valid observation period' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DEATH' as VARCHAR(255)) as analysis_type
union all
select  511 as analysis_id,
        CAST('Distribution of time from death to last condition' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DEATH' as VARCHAR(255)) as analysis_type
union all
select  512 as analysis_id,
        CAST('Distribution of time from death to last drug' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DEATH' as VARCHAR(255)) as analysis_type
union all
select  513 as analysis_id,
        CAST('Distribution of time from death to last visit' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DEATH' as VARCHAR(255)) as analysis_type
union all
select  514 as analysis_id,
        CAST('Distribution of time from death to last procedure' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DEATH' as VARCHAR(255)) as analysis_type
union all
select  515 as analysis_id,
        CAST('Distribution of time from death to last observation' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DEATH' as VARCHAR(255)) as analysis_type
union all
select  600 as analysis_id,
        CAST('Number of persons with at least one procedure occurrence, by procedure_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('procedure_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('PROCEDURE' as VARCHAR(255)) as analysis_type
union all
select  601 as analysis_id,
        CAST('Number of procedure occurrence records, by procedure_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('procedure_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('PROCEDURE' as VARCHAR(255)) as analysis_type
union all
select  602 as analysis_id,
        CAST('Number of persons by procedure occurrence start month, by procedure_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('procedure_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('PROCEDURE' as VARCHAR(255)) as analysis_type
union all
select  603 as analysis_id,
        CAST('Number of distinct procedure occurrence concepts per person' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('PROCEDURE' as VARCHAR(255)) as analysis_type
union all
select  604 as analysis_id,
        CAST('Number of persons with at least one procedure occurrence, by procedure_concept_id by calendar year by gender by age decile' as VARCHAR(255)) as analysis_name,
        CAST('procedure_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('calendar year' as VARCHAR(255)) as stratum_2_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_3_name,
        CAST('age decile' as VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('PROCEDURE' as VARCHAR(255)) as analysis_type
union all
select  605 as analysis_id,
        CAST('Number of procedure occurrence records, by procedure_concept_id by procedure_type_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('procedure_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('procedure_type_concept_id' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('PROCEDURE' as VARCHAR(255)) as analysis_type
union all
select  606 as analysis_id,
        CAST('Distribution of age by procedure_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('procedure_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('PROCEDURE' as VARCHAR(255)) as analysis_type
union all
select  609 as analysis_id,
        CAST('Number of procedure occurrence records with invalid person_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('PROCEDURE' as VARCHAR(255)) as analysis_type
union all
select  610 as analysis_id,
        CAST('Number of procedure occurrence records outside valid observation period' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('PROCEDURE' as VARCHAR(255)) as analysis_type
union all
select  612 as analysis_id,
        CAST('Number of procedure occurrence records with invalid provider_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('PROCEDURE' as VARCHAR(255)) as analysis_type
union all
select  613 as analysis_id,
        CAST('Number of procedure occurrence records with invalid visit_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('PROCEDURE' as VARCHAR(255)) as analysis_type
union all
select  620 as analysis_id,
        CAST('Number of procedure occurrence records  by procedure occurrence start month' as VARCHAR(255)) as analysis_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('PROCEDURE' as VARCHAR(255)) as analysis_type
union all
select  700 as analysis_id,
        CAST('Number of persons with at least one drug exposure, by drug_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  701 as analysis_id,
        CAST('Number of drug exposure records, by drug_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  702 as analysis_id,
        CAST('Number of persons by drug exposure start month, by drug_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  703 as analysis_id,
        CAST('Number of distinct drug exposure concepts per person' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  704 as analysis_id,
        CAST('Number of persons with at least one drug exposure, by drug_concept_id by calendar year by gender by age decile' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('calendar year' as VARCHAR(255)) as stratum_2_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_3_name,
        CAST('age decile' as VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  705 as analysis_id,
        CAST('Number of drug exposure records, by drug_concept_id by drug_type_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('drug_type_concept_id' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  706 as analysis_id,
        CAST('Distribution of age by drug_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  709 as analysis_id,
        CAST('Number of drug exposure records with invalid person_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  710 as analysis_id,
        CAST('Number of drug exposure records outside valid observation period' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  711 as analysis_id,
        CAST('Number of drug exposure records with end date < start date' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  712 as analysis_id,
        CAST('Number of drug exposure records with invalid provider_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  713 as analysis_id,
        CAST('Number of drug exposure records with invalid visit_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  715 as analysis_id,
        CAST('Distribution of days_supply by drug_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  716 as analysis_id,
        CAST('Distribution of refills by drug_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  717 as analysis_id,
        CAST('Distribution of quantity by drug_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  720 as analysis_id,
        CAST('Number of drug exposure records  by drug exposure start month' as VARCHAR(255)) as analysis_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG' as VARCHAR(255)) as analysis_type
union all
select  800 as analysis_id,
        CAST('Number of persons with at least one observation occurrence, by observation_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('observation_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  801 as analysis_id,
        CAST('Number of observation occurrence records, by observation_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('observation_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  802 as analysis_id,
        CAST('Number of persons by observation occurrence start month, by observation_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('observation_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  803 as analysis_id,
        CAST('Number of distinct observation occurrence concepts per person' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  804 as analysis_id,
        CAST('Number of persons with at least one observation occurrence, by observation_concept_id by calendar year by gender by age decile' as VARCHAR(255)) as analysis_name,
        CAST('observation_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('calendar year' as VARCHAR(255)) as stratum_2_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_3_name,
        CAST('age decile' as VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  805 as analysis_id,
        CAST('Number of observation occurrence records, by observation_concept_id by observation_type_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('observation_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('observation_type_concept_id' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  806 as analysis_id,
        CAST('Distribution of age by observation_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('observation_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  807 as analysis_id,
        CAST('Number of observation occurrence records, by observation_concept_id and unit_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('observation_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('unit_concept_id' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  809 as analysis_id,
        CAST('Number of observation records with invalid person_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  810 as analysis_id,
        CAST('Number of observation records outside valid observation period' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  812 as analysis_id,
        CAST('Number of observation records with invalid provider_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  813 as analysis_id,
        CAST('Number of observation records with invalid visit_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  814 as analysis_id,
        CAST('Number of observation records with no value (numeric, string, or concept)' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  815 as analysis_id,
        CAST('Distribution of numeric values, by observation_concept_id and unit_concept_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  816 as analysis_id,
        CAST('Distribution of low range, by observation_concept_id and unit_concept_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  817 as analysis_id,
        CAST('Distribution of high range, by observation_concept_id and unit_concept_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  818 as analysis_id,
        CAST('Number of observation records below/within/above normal range, by observation_concept_id and unit_concept_id' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  820 as analysis_id,
        CAST('Number of observation records  by observation start month' as VARCHAR(255)) as analysis_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('OBSERVATION' as VARCHAR(255)) as analysis_type
union all
select  900 as analysis_id,
        CAST('Number of persons with at least one drug era, by drug_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG_ERA' as VARCHAR(255)) as analysis_type
union all
select  901 as analysis_id,
        CAST('Number of drug era records, by drug_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG_ERA' as VARCHAR(255)) as analysis_type
union all
select  902 as analysis_id,
        CAST('Number of persons by drug era start month, by drug_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG_ERA' as VARCHAR(255)) as analysis_type
union all
select  903 as analysis_id,
        CAST('Number of distinct drug era concepts per person' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG_ERA' as VARCHAR(255)) as analysis_type
union all
select  904 as analysis_id,
        CAST('Number of persons with at least one drug era, by drug_concept_id by calendar year by gender by age decile' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('calendar year' as VARCHAR(255)) as stratum_2_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_3_name,
        CAST('age decile' as VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG_ERA' as VARCHAR(255)) as analysis_type
union all
select  906 as analysis_id,
        CAST('Distribution of age by drug_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST('gender_concept_id' as VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG_ERA' as VARCHAR(255)) as analysis_type
union all
select  907 as analysis_id,
        CAST('Distribution of drug era length, by drug_concept_id' as VARCHAR(255)) as analysis_name,
        CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG_ERA' as VARCHAR(255)) as analysis_type
union all
select  908 as analysis_id,
        CAST('Number of drug eras without valid person' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG_ERA' as VARCHAR(255)) as analysis_type
union all
select  909 as analysis_id,
        CAST('Number of drug eras outside valid observation period' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG_ERA' as VARCHAR(255)) as analysis_type
union all
select  910 as analysis_id,
        CAST('Number of drug eras with end date < start date' as VARCHAR(255)) as analysis_name,
        CAST(NULL AS VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG_ERA' as VARCHAR(255)) as analysis_type
union all
select  920 as analysis_id,
        CAST('Number of drug era records  by drug era start month' as VARCHAR(255)) as analysis_name,
        CAST('calendar month' as VARCHAR(255)) as stratum_1_name,
        CAST(NULL AS VARCHAR(255)) as stratum_2_name,
        CAST(NULL AS VARCHAR(255)) as stratum_3_name,
        CAST(NULL AS VARCHAR(255)) as stratum_4_name,
        CAST(NULL AS VARCHAR(255)) as stratum_5_name,
        CAST('DRUG_ERA' as VARCHAR(255)) as analysis_type
union all
select 1000 as analysis_id,
       CAST('Number of persons with at least one condition era, by condition_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('CONDITION_ERA' as VARCHAR(255)) as analysis_type
union all
select 1001 as analysis_id,
       CAST('Number of condition era records, by condition_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('CONDITION_ERA' as VARCHAR(255)) as analysis_type
union all
select 1002 as analysis_id,
       CAST('Number of persons by condition era start month, by condition_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('calendar month' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('CONDITION_ERA' as VARCHAR(255)) as analysis_type
union all
select 1003 as analysis_id,
       CAST('Number of distinct condition era concepts per person' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('CONDITION_ERA' as VARCHAR(255)) as analysis_type
union all
select 1004 as analysis_id,
       CAST('Number of persons with at least one condition era, by condition_concept_id by calendar year by gender by age decile' as VARCHAR(255)) as analysis_name,
       CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('calendar year' as VARCHAR(255)) as stratum_2_name,
       CAST('gender_concept_id' as VARCHAR(255)) as stratum_3_name,
       CAST('age decile' as VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('CONDITION_ERA' as VARCHAR(255)) as analysis_type
union all
select 1006 as analysis_id,
       CAST('Distribution of age by condition_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('gender_concept_id' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('CONDITION_ERA' as VARCHAR(255)) as analysis_type
union all
select 1007 as analysis_id,
       CAST('Distribution of condition era length, by condition_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('CONDITION_ERA' as VARCHAR(255)) as analysis_type
union all
select 1008 as analysis_id,
       CAST('Number of condition eras without valid person' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('CONDITION_ERA' as VARCHAR(255)) as analysis_type
union all
select 1009 as analysis_id,
       CAST('Number of condition eras outside valid observation period' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('CONDITION_ERA' as VARCHAR(255)) as analysis_type
union all
select 1010 as analysis_id,
       CAST('Number of condition eras with end date < start date' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('CONDITION_ERA' as VARCHAR(255)) as analysis_type
union all
select 1020 as analysis_id,
       CAST('Number of condition era records by condition era start month' as VARCHAR(255)) as analysis_name,
       CAST('calendar month' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('CONDITION_ERA' as VARCHAR(255)) as analysis_type
union all
select 1100 as analysis_id,
       CAST('Number of persons by location 3-digit zip' as VARCHAR(255)) as analysis_name,
       CAST('3-digit zip' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('LOCATION' as VARCHAR(255)) as analysis_type
union all
select 1101 as analysis_id,
       CAST('Number of persons by location state' as VARCHAR(255)) as analysis_name,
       CAST('state' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('LOCATION' as VARCHAR(255)) as analysis_type
union all
select 1200 as analysis_id,
       CAST('Number of persons by place of service' as VARCHAR(255)) as analysis_name,
       CAST('place_of_service_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('CARE_SITE' as VARCHAR(255)) as analysis_type
union all
select 1201 as analysis_id,
       CAST('Number of visits by place of service' as VARCHAR(255)) as analysis_name,
       CAST('place_of_service_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('CARE_SITE' as VARCHAR(255)) as analysis_type
union all
select 1300 as analysis_id,
       CAST('Number of persons with at least one measurement occurrence, by measurement_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('measurement_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1301 as analysis_id,
       CAST('Number of measurement occurrence records, by measurement_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('measurement_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1302 as analysis_id,
       CAST('Number of persons by measurement occurrence start month, by measurement_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('measurement_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('calendar month' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1303 as analysis_id,
       CAST('Number of distinct measurement occurrence concepts per person' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1304 as analysis_id,
       CAST('Number of persons with at least one measurement occurrence, by measurement_concept_id by calendar year by gender by age decile' as VARCHAR(255)) as analysis_name,
       CAST('measurement_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('calendar year' as VARCHAR(255)) as stratum_2_name,
       CAST('gender_concept_id' as VARCHAR(255)) as stratum_3_name,
       CAST('age decile' as VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1305 as analysis_id,
       CAST('Number of measurement occurrence records, by measurement_concept_id by measurement_type_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('measurement_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('measurement_type_concept_id' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1306 as analysis_id,
       CAST('Distribution of age by measurement_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('measurement_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('gender_concept_id' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1307 as analysis_id,
       CAST('Number of measurement occurrence records, by measurement_concept_id and unit_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('measurement_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('unit_concept_id' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1309 as analysis_id,
       CAST('Number of measurement records with invalid person_id' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1310 as analysis_id,
       CAST('Number of measurement records outside valid measurement period' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1312 as analysis_id,
       CAST('Number of measurement records with invalid provider_id' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1313 as analysis_id,
       CAST('Number of measurement records with invalid visit_id' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1314 as analysis_id,
       CAST('Number of measurement records with no value (numeric, string, or concept)' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1315 as analysis_id,
       CAST('Distribution of numeric values, by measurement_concept_id and unit_concept_id' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1316 as analysis_id,
       CAST('Distribution of low range, by measurement_concept_id and unit_concept_id' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1317 as analysis_id,
       CAST('Distribution of high range, by measurement_concept_id and unit_concept_id' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1318 as analysis_id,
       CAST('Number of measurement records below/within/above normal range, by measurement_concept_id and unit_concept_id' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1320 as analysis_id,
       CAST('Number of measurement records  by measurement start month' as VARCHAR(255)) as analysis_name,
       CAST('calendar month' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('MEASUREMENT' as VARCHAR(255)) as analysis_type
union all
select 1700 as analysis_id,
       CAST('Number of records by cohort_definition_id' as VARCHAR(255)) as analysis_name,
       CAST('cohort_definition_id' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT' as VARCHAR(255)) as analysis_type
union all
select 1701 as analysis_id,
       CAST('Number of records with cohort end date < cohort start date' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT' as VARCHAR(255)) as analysis_type
union all
select 1800 as analysis_id,
       CAST('Number of persons by age, with age at cohort start' as VARCHAR(255)) as analysis_name,
       CAST('age' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1801 as analysis_id,
       CAST('Distribution of age at cohort start' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1802 as analysis_id,
       CAST('Distribution of age at cohort start by gender' as VARCHAR(255)) as analysis_name,
       CAST('gender_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1803 as analysis_id,
       CAST('Distribution of age at cohort start by cohort start year' as VARCHAR(255)) as analysis_name,
       CAST('calendar year' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1804 as analysis_id,
       CAST('Number of persons by duration from cohort start to cohort end, in 30d increments' as VARCHAR(255)) as analysis_name,
       CAST('Cohort period length 30d increments' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1805 as analysis_id,
       CAST('Number of persons by duration from observation start to cohort start, in 30d increments' as VARCHAR(255)) as analysis_name,
       CAST('Baseline period length 30d increments' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1806 as analysis_id,
       CAST('Number of persons by duration from cohort start to observation end, in 30d increments' as VARCHAR(255)) as analysis_name,
       CAST('Follow-up period length 30d increments' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1807 as analysis_id,
       CAST('Number of persons by duration from cohort end to observation end, in 30d increments' as VARCHAR(255)) as analysis_name,
       CAST('Post-cohort period length 30d increments' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1808 as analysis_id,
       CAST('Distribution of duration (days) from cohort start to cohort end' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1809 as analysis_id,
       CAST('Distribution of duration (days) from cohort start to cohort end, by gender' as VARCHAR(255)) as analysis_name,
       CAST('gender_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1810 as analysis_id,
       CAST('Distribution of duration (days) from cohort start to cohort end, by age decile' as VARCHAR(255)) as analysis_name,
       CAST('age decile' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1811 as analysis_id,
       CAST('Distribution of duration (days) from observation start to cohort start' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1812 as analysis_id,
       CAST('Distribution of duration (days) from cohort start to observation end' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1813 as analysis_id,
       CAST('Distribution of duration (days) from cohort end to observation end' as VARCHAR(255)) as analysis_name,
       CAST(NULL AS VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1814 as analysis_id,
       CAST('Number of persons by cohort start year by gender by age decile' as VARCHAR(255)) as analysis_name,
       CAST('calendar year' as VARCHAR(255)) as stratum_1_name,
       CAST('gender_concept_id' as VARCHAR(255)) as stratum_2_name,
       CAST('age decile' as VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1815 as analysis_id,
       CAST('Number of persons by cohort start month' as VARCHAR(255)) as analysis_name,
       CAST('calendar month' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1816 as analysis_id,
       CAST('Number of persons by number of cohort periods' as VARCHAR(255)) as analysis_name,
       CAST('number of cohort periods' as VARCHAR(255)) as stratum_1_name,
       CAST(NULL AS VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1820 as analysis_id,
       CAST('Number of persons by duration from cohort start to first occurrence of condition occurrence, by condition_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('time-to-event 30d increments' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1821 as analysis_id,
       CAST('Number of events by duration from cohort start to all occurrences of condition occurrence, by condition_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('time-to-event 30d increments' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1830 as analysis_id,
       CAST('Number of persons by duration from cohort start to first occurrence of procedure occurrence, by procedure_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('procedure_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('time-to-event 30d increments' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1831 as analysis_id,
       CAST('Number of events by duration from cohort start to all occurrences of procedure occurrence, by procedure_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('procedure_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('time-to-event 30d increments' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1840 as analysis_id,
       CAST('Number of persons by duration from cohort start to first occurrence of drug exposure, by drug_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('time-to-event 30d increments' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1841 as analysis_id,
       CAST('Number of events by duration from cohort start to all occurrences of drug exposure, by drug_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('time-to-event 30d increments' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1850 as analysis_id,
       CAST('Number of persons by duration from cohort start to first occurrence of observation, by observation_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('observation_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('time-to-event 30d increments' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1851 as analysis_id,
       CAST('Number of events by duration from cohort start to all occurrences of observation, by observation_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('observation_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('time-to-event 30d increments' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1860 as analysis_id,
       CAST('Number of persons by duration from cohort start to first occurrence of condition era, by condition_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('time-to-event 30d increments' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1861 as analysis_id,
       CAST('Number of events by duration from cohort start to all occurrences of condition era, by condition_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('condition_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('time-to-event 30d increments' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1870 as analysis_id,
       CAST('Number of persons by duration from cohort start to first occurrence of drug era, by drug_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('time-to-event 30d increments' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 1871 as analysis_id,
       CAST('Number of events by duration from cohort start to all occurrences of drug era, by drug_concept_id' as VARCHAR(255)) as analysis_name,
       CAST('drug_concept_id' as VARCHAR(255)) as stratum_1_name,
       CAST('time-to-event 30d increments' as VARCHAR(255)) as stratum_2_name,
       CAST(NULL AS VARCHAR(255)) as stratum_3_name,
       CAST(NULL AS VARCHAR(255)) as stratum_4_name,
       CAST(NULL AS VARCHAR(255)) as stratum_5_name,
       CAST('COHORT_SPECIFIC_ANALYSES' as VARCHAR(255)) as analysis_type
union all
select 4000 as analysis_id,
       CAST('Distribution of observation period days by period_id in the 365 days prior to first cohort_start_date' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4001 as analysis_id,
       CAST('Number of subjects with visits by period_id, by visit_concept_id, by visit_type_concept_id in the 365d prior to first cohort start date' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4002 as analysis_id,
       CAST('Distribution of number of visit occurrence records per subject by period_id, by visit_concept_id, by visit_type_concept_id in 365d prior to cohort start date' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4003 as analysis_id,
       CAST('Distribution of number of visit dates per subject by period_id, by visit_concept_id, by visit_type_concept_id in 365d prior to first cohort start date' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4003 as analysis_id,
       CAST('Distribution of number of visit dates per subject by period_id, by visit_concept_id, by visit_type_concept_id in 365d prior to first cohort start date' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4004 as analysis_id,
       CAST('Distribution of number of care_site+visit dates per subject by period_id, by visit_concept_id, by visit_type_concept_id in 365d prior to first cohort start date' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4005 as analysis_id,
       CAST('Distribution of length of stay for inpatient visits per subject by period_id, by visit_concept_id, by visit_type_concept_id in the 365 days prior to first cohort_start_date' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4006 as analysis_id,
       CAST('Distribution of observation period days per subject, by period_id during cohort period' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4007 as analysis_id,
       CAST('Number of subjects with visits by period_id, by visit_concept_id, by visit_type_concept_id during the cohort period' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4008 as analysis_id,
       CAST('Distribution of number of visit occurrence records per subject by period_id, by visit_concept_id, by visit_type_concept_id during the cohort period' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4009 as analysis_id,
       CAST('Distribution of number of visit dates per subject by period_id, by visit_concept_id, by visit_type_concept_id during the cohort period' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4010 as analysis_id,
       CAST('Distribution of number of care_site+visit dates per subject by period_id, by visit_concept_id, by visit_type_concept_id during the cohort period' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4011 as analysis_id,
       CAST('Distribution of length of stay for inpatient visits per subject by period_id, by visit_concept_id, by visit_type_concept_id during cohort period' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4012 as analysis_id,
       CAST('Number of subjects with Drug Exposure by period_id, by drug_concept_id, by drug_type_concept_id in the 365d prior to first cohort start date' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4013 as analysis_id,
       CAST('Distribution of number of Drug Exposure records per subject, by period_id, by drug_concept_id in 365d prior to first cohort start date' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4014 as analysis_id,
       CAST('Distribution of greater than 0 drug day supply per subject by period_id, by drug_concept_id in the 365d prior to first cohort start date' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4015 as analysis_id,
       CAST('Distribution of greater than 0 drug quantity per subject by period_id, by drug_concept_id in the 365d prior to first cohort start date' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4016 as analysis_id,
       CAST('Number of subjects with Drug Exposure by period_id, by drug_concept_id, by drug_type_concept_id during the cohort period' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4017 as analysis_id,
       CAST('Distribution of number of Drug Exposure records per subject, by period_id, by drug_concept_id during the cohort period' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4018 as analysis_id,
       CAST('Distribution of greater than 0 drug day supply per subject by period_id, by drug_concept_id during the cohort period' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4019 as analysis_id,
       CAST('Distribution of greater than 0 drug quantity per subject by period_id, by drug_concept_id during the cohort period' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4020 as analysis_id,
       CAST('Distribution of greater than 0 US$ cost per subject by period_id, by visit_concept_id, by visit_type_concept_id, by cost_concept_id, by cost_type_concept_id in the 365d prior to first cohort start date' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4021 as analysis_id,
       CAST('Distribution of greater than 0 US$ cost per subject by period_id, by visit_concept_id, by visit_type_concept_id, by cost_concept_id, by cost_type_concept_id during the cohort period' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4022 as analysis_id,
       CAST('Distribution of greater than 0 US$ cost per subject by period_id, by drug_concept_id, by drug_type_concept_id, by cost_concept_id, by cost_type_concept_id in the 365d prior to first cohort start date' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
union all
select 4023 as analysis_id,
       CAST('Distribution of greater than 0 US$ cost per subject by period_id, by drug_concept_id, by drug_type_concept_id, by cost_concept_id, by cost_type_concept_id, by cost_type_concept_id during the cohort period' as VARCHAR(255)) as analysis_name,
       NULL as stratum_1_name,
       NULL as stratum_2_name,
       NULL as stratum_3_name,
       NULL as stratum_4_name,
       NULL as stratum_5_name,
       CAST('HEALTHCARE_UTILIZATION' as VARCHAR(255)) as analysis_type
;


CREATE TEMP TABLE digits

AS
SELECT
    digits.n
FROM
    (
        select 0 as n union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9
    ) digits;

ANALYZE digits
;


CREATE TEMP TABLE generate_dates

AS
SELECT
        y1.n + (10*y10.n) + (100*y100.n) + (1000*y1000.n) AS d_years,
        mths.n as d_months

FROM
    digits y1,
    digits y10,
    (select 0 n union all select 1 union all select 9) y100,
    (select 1 n union all select 2) y1000,
    (select 1 n union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9 union all select 10 union all select 11 union all select 12) mths
where y1.n + (10*y10.n) + (100*y100.n) + (1000*y1000.n) >= 1900 and y1.n + (10*y10.n) + (100*y100.n) + (1000*y1000.n) < 2100
;

ANALYZE generate_dates
;


CREATE TEMP TABLE yearly_dates

AS
SELECT
    TO_DATE(TO_CHAR(d_years,'0000')||'-'||TO_CHAR(d_months,'00')||'-'||TO_CHAR(01,'00'), 'YYYY-MM-DD') as generated_date

FROM
    generate_dates
where d_months = 1
;

ANALYZE yearly_dates
;


CREATE TEMP TABLE monthly_dates

AS
SELECT
    TO_DATE(TO_CHAR(d_years,'0000')||'-'||TO_CHAR(d_months,'00')||'-'||TO_CHAR(01,'00'), 'YYYY-MM-DD') as generated_date

FROM
    generate_dates
;

ANALYZE monthly_dates
;


CREATE TEMP TABLE weekly_dates

AS
SELECT
    (TO_DATE(TO_CHAR(1900,'0000')||'-'||TO_CHAR(1,'00')||'-'||TO_CHAR(7,'00'), 'YYYY-MM-DD') + (7 * seq.rn)*INTERVAL'1 day') as generated_date -- first sunday in 1900

FROM
    (
        select  d1.n + (10 * d10.n) + (100 * d100.n) + (1000 * d1000.n) as rn
        from digits d1, digits d10, digits d100, digits d1000
    ) seq;

ANALYZE weekly_dates
;


CREATE TEMP TABLE quarterly_dates

AS
SELECT
    TO_DATE(TO_CHAR(d_years,'0000')||'-'||TO_CHAR(d_months,'00')||'-'||TO_CHAR(1,'00'), 'YYYY-MM-DD') as generated_date

FROM
    generate_dates
where d_months in (1,4,7,10)
;

ANALYZE quarterly_dates
;


-- monthly dates
CREATE TEMP TABLE temp_period

AS
SELECT
    *

FROM
    (
        select CAST('Monthly' AS VARCHAR(255)) as period_name
                , 1 as period_order
                , CAST( 'mm' AS VARCHAR(50)) as period_type
                , md.generated_date as period_start_date
                , (md.generated_date + 1*INTERVAL'1 month') as period_end_date
        from monthly_dates md

        UNION ALL
        select CAST('Weekly' AS VARCHAR(255)) as period_name
                , 2 as period_order
                , CAST('ww' AS VARCHAR(50)) as period_type
                , wd.generated_date as period_start_date
                , (wd.generated_date + 7*INTERVAL'1 day') as period_end_date
        from weekly_dates wd
        where wd.generated_date >= TO_DATE(TO_CHAR(1900,'0000')||'-'||TO_CHAR(1,'00')||'-'||TO_CHAR(1,'00'), 'YYYY-MM-DD') and wd.generated_date < TO_DATE(TO_CHAR(2100,'0000')||'-'||TO_CHAR(1,'00')||'-'||TO_CHAR(1,'00'), 'YYYY-MM-DD')

        UNION ALL
        select CAST('Quarterly' AS VARCHAR(255)) as period_name
                , 3 as period_order
                , CAST('qq' AS VARCHAR(50)) as period_type
                , qd.generated_date as period_start_date
                , (qd.generated_date + 3*INTERVAL'1 month') as period_end_date
        from quarterly_dates qd

        UNION ALL
        select CAST('Yearly' AS VARCHAR(255)) as period_name
                , 4 as period_order
                , CAST('yy' AS VARCHAR(50)) as period_type
                , yd.generated_date as period_start_date
                , (yd.generated_date + 1*INTERVAL'1 year') as period_end_date
        from yearly_dates yd

-- ADD UNION ALLs for additional period definitions
    ) monthlyDates;

ANALYZE temp_period
;


INSERT INTO heracles_periods (period_id, period_name, period_order, period_type, period_start_date, period_end_date)
select CAST(row_number() over (order by period_order, period_start_date) AS INT) as period_id
        , period_name, period_order, period_type, period_start_date, period_end_date
from temp_period;


truncate table digits;

drop table digits;


truncate table generate_dates;

drop table generate_dates;


truncate table yearly_dates;

drop table yearly_dates;


truncate table quarterly_dates;

drop table quarterly_dates;


truncate table monthly_dates;

drop table monthly_dates;


truncate table weekly_dates;

drop table weekly_dates;


TRUNCATE TABLE temp_period;

DROP TABLE temp_period;



CREATE INDEX HRD_IDX_COHORT_DEF_ID ON HERACLES_RESULTS_DIST (cohort_definition_id);

CREATE INDEX HRD_IDX_COHORT_ID_ANALYSIS_ID ON HERACLES_RESULTS_DIST (cohort_definition_id, analysis_id);

CREATE INDEX HRD_IDX_COHORT_DEF_ID_DT ON HERACLES_RESULTS_DIST (cohort_definition_id, last_update_time);

CREATE INDEX HRD_IDX_COHORT_ID_FIRST_RES ON HERACLES_RESULTS_DIST (cohort_definition_id, analysis_id, count_value, stratum_1);

CREATE INDEX HR_IDX_COHORT_DEF_ID ON HERACLES_RESULTS (cohort_definition_id);

CREATE INDEX HR_IDX_COHORT_ID_ANALYSIS_ID ON HERACLES_RESULTS (cohort_definition_id, analysis_id);

CREATE INDEX HR_IDX_COHORT_ANALYSIS_CONCEPT ON HERACLES_RESULTS (cohort_definition_id, analysis_id) WHERE stratum_2 <> '';

CREATE INDEX HR_IDX_COHORT_DEF_ID_DT ON HERACLES_RESULTS (cohort_definition_id, last_update_time);

CREATE INDEX HR_IDX_COHORT_ID_FIRST_RES ON HERACLES_RESULTS (cohort_definition_id, analysis_id, count_value, stratum_1);

CREATE INDEX HH_IDX_COHORT_ID_ANALYSIS_ID ON HERACLES_HEEL_RESULTS (cohort_definition_id, analysis_id);


CREATE INDEX idx_heracles_periods_startdate ON heracles_periods (period_start_date);

CREATE INDEX idx_heracles_periods_end_date ON heracles_periods (period_end_date);

CREATE INDEX idx_pathway_events_combo_id ON pathway_analysis_events (combo_id);