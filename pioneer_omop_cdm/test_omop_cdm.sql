

COPY cdm5.person (person_id, gender_concept_id, year_of_birth, month_of_birth, day_of_birth, birth_datetime, death_datetime, race_concept_id, ethnicity_concept_id, location_id, provider_id, care_site_id, person_source_value, gender_source_value, gender_source_concept_id, race_source_value, race_source_concept_id, ethnicity_source_value, ethnicity_source_concept_id) FROM stdin;
1	8507	1938	\N	\N	\N	\N	0	0	\N	\N	\N	\N	\N	0	\N	0	\N	0
2	8507	1939	\N	\N	\N	\N	0	0	\N	\N	\N	\N	\N	0	\N	0	\N	0
3	8507	1939	\N	\N	\N	\N	0	0	\N	\N	\N	\N	\N	0	\N	0	\N	0
4	8507	1936	\N	\N	\N	\N	0	0	\N	\N	\N	\N	\N	0	\N	0	\N	0
5	8507	1933	\N	\N	\N	\N	0	0	\N	\N	\N	\N	\N	0	\N	0	\N	0
6	8507	1925	\N	\N	\N	\N	0	0	\N	\N	\N	\N	\N	0	\N	0	\N	0
7	8507	1933	\N	\N	\N	\N	0	0	\N	\N	\N	\N	\N	0	\N	0	\N	0
8	8507	1938	\N	\N	\N	\N	0	0	\N	\N	\N	\N	\N	0	\N	0	\N	0
9	8507	1940	\N	\N	\N	\N	0	0	\N	\N	\N	\N	\N	0	\N	0	\N	0
10	8507	1934	\N	\N	\N	\N	0	0	\N	\N	\N	\N	\N	0	\N	0	\N	0
\.


--
-- Data for Name: location; Type: TABLE DATA; Schema: cdm5; Owner: admin
--

COPY cdm5.location (location_id, address_1, address_2, city, state, zip, county, location_source_value, latitude, longitude) FROM stdin;
1	\N	\N	Rotterdam	\N	\N	Netherlands	\N	\N	\N
\.
