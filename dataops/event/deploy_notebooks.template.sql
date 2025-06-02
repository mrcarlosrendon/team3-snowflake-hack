use role {{ env.EVENT_ATTENDEE_ROLE }};
create schema if not exists {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }};

CREATE STAGE IF NOT EXISTS {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK01 DIRECTORY = (ENABLE = TRUE) ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');
CREATE STAGE IF NOT EXISTS {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK02 DIRECTORY = (ENABLE = TRUE) ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');
CREATE STAGE IF NOT EXISTS {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK03 DIRECTORY = (ENABLE = TRUE) ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');
CREATE STAGE IF NOT EXISTS {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK04 DIRECTORY = (ENABLE = TRUE) ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');
CREATE STAGE IF NOT EXISTS {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK05 DIRECTORY = (ENABLE = TRUE) ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');

PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/notebooks/Analyse_Location_Data/Analyse_Location_Data.ipynb @{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK01 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/notebooks/Analyse_Location_Data/environment.yml @{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK01 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/notebooks/Slopey_Roofs/Slopey_Roofs.ipynb @{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK02 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/notebooks/Slopey_Roofs/environment.yml @{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK02 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/notebooks/location_data_from_api/LOCATION_DATA_FROM_API.ipynb @{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK03 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/notebooks/location_data_from_api/environment.yml @{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK03 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/notebooks/cold_weather_notebook/viewing_data_in_notebook.ipynb @{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK04 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/notebooks/cold_weather_notebook/environment.yml @{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK04 auto_compress = false overwrite = true;

PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/notebooks/hackathon_notebook_example/HURRICANE_DEMO_ANALYSIS.ipynb @{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK05 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/notebooks/hackathon_notebook_example/environment.yml @{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK05 auto_compress = false overwrite = true;

CREATE OR REPLACE NOTEBOOK {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.ANALYSE_LOCATION_DATA
FROM '@{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK01'
MAIN_FILE = 'Analyse_Location_Data.ipynb'
QUERY_WAREHOUSE = '{{ env.EVENT_WAREHOUSE }}';

ALTER NOTEBOOK {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.ANALYSE_LOCATION_DATA ADD LIVE VERSION FROM LAST;


CREATE OR REPLACE NOTEBOOK {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.SOLAR_POWER_USECASE
FROM '@{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK02'
MAIN_FILE = 'Slopey_Roofs.ipynb'
QUERY_WAREHOUSE = '{{ env.EVENT_WAREHOUSE }}';

ALTER NOTEBOOK {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.SOLAR_POWER_USECASE ADD LIVE VERSION FROM LAST;

CREATE OR REPLACE NOTEBOOK {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.LOCATION_DATA_FROM_API
FROM '@{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK03'
MAIN_FILE = 'LOCATION_DATA_FROM_API.ipynb'
QUERY_WAREHOUSE = '{{ env.EVENT_WAREHOUSE }}';

ALTER NOTEBOOK {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.LOCATION_DATA_FROM_API ADD LIVE VERSION FROM LAST;

CREATE OR REPLACE NOTEBOOK {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.COLD_WEATHER_PAYMENT_ANALYSIS
FROM '@{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK04'
MAIN_FILE = 'viewing_data_in_notebook.ipynb'
QUERY_WAREHOUSE = '{{ env.EVENT_WAREHOUSE }}';

ALTER NOTEBOOK {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.COLD_WEATHER_PAYMENT_ANALYSIS ADD LIVE VERSION FROM LAST;


CREATE OR REPLACE NOTEBOOK {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.HURRICANE_IDA_HACKATHON_EXAMPLE
FROM '@{{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.NOTEBOOK05'
MAIN_FILE = 'HURRICANE_DEMO_ANALYSIS.ipynb'
QUERY_WAREHOUSE = '{{ env.EVENT_WAREHOUSE }}';

ALTER NOTEBOOK {{ env.DATAOPS_DATABASE }}.{{ env.NOTEBOOKS_SCHEMA }}.HURRICANE_IDA_HACKATHON_EXAMPLE ADD LIVE VERSION FROM LAST;