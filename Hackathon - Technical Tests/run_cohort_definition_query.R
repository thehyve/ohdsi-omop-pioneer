if (!require(DatabaseConnector)) {
  install.packages("DatabaseConnector")
  library(DatabaseConnector)
}

# User parameters ------------------------------------------------
# Database Connection Details. #TODO: replace
database_type <- 'postgresql'
server <- 'localhost/ohdsi'
port <- 5432
user <- '' # This user has to have write priviliges in the target_schema
password <- ''

# Database Schema Details #TODO: replace
vocabulary_schema <- 'vocab'
cdm_schema <- 'cdm'
target_schema <- 'results'
target_cohort_id <- 999
target_cohort_table <- 'cohort'

# Connect to database and run queries -----------------------------
# Create connection
connectionDetails <- createConnectionDetails(dbms=database_type,
                                             server=server,
                                             user=user,
                                             password=password,
                                             port=port
                                             )

# Load the cohort definition query
# https://pioneer-atlas.thehyve.net/index.html#/cohortdefinition/15
sql <- SqlRender::readSql('cohort_definition.sql')
sql <- SqlRender::render(sql, 
                         vocabulary_database_schema=vocabulary_schema,
                         cdm_database_schema=cdm_schema,
                         target_database_schema=target_schema,
                         target_cohort_id=target_cohort_id,
                         target_cohort_table=target_cohort_table)

sql <- SqlRender::translate(sql, targetDialect = connectionDetails$dbms)

# Run cohort
connection <- connect(connectionDetails)
DatabaseConnector::executeSql(connection, sql, progressBar = TRUE)

# View results
cohortResult <- DatabaseConnector::querySql(connection, sprintf("SELECT * FROM %s.%s WHERE cohort_definition_id=%s", target_schema, target_cohort_table, target_cohort_id))
print(nrow(cohortResult))
View(cohortResult)


