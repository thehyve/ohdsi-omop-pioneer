# Overview

Following conversions have been done:

| Data source | Date of last conversion | Vocabulary version used | # of concept mappings | # to non-standard concepts | # to PIONEER vocabulary |
|:------------|:------------------------|:------------------------|:----------------------------|:------------------------|:------------------------|
| ERSPC       |                         |                         |                             |                         |                         |
| PRIAS       |                         |                         |                             |                         |                         |
|             |                         |                         |                             |                         |                         |

# Overview of custom concepts

| Domain      | Count |
|:------------|------:|
| Visit       |    41 |
| Condition   |     1 |
| Measurement |   ... |
| Observation |   ... |

# Overview of mappings

| Source Domain | Target Domain |    |
|:--------------|:--------------|:---|
|               |               |    |

# Searching the mappings
 - interface to search through the custom vocabulary.
 - do not show invalid concepts
 
# Mapping priority
For a given source term, try to map to a concept_id in the following order:
 1. Standard concept
 2. Non-standard concept present in Athena (note: as this deviates from OMOP conventions, document this use of non-standard concepts)
 3. Create custom PIONEER concept (stored here)
