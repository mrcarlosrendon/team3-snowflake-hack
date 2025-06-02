use role {{ env.EVENT_ATTENDEE_ROLE }};
create schema if not exists {{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }};

CREATE STAGE IF NOT EXISTS {{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT1 DIRECTORY = (ENABLE = TRUE) ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');
CREATE STAGE IF NOT EXISTS {{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT2 DIRECTORY = (ENABLE = TRUE) ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');
CREATE STAGE IF NOT EXISTS {{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT3 DIRECTORY = (ENABLE = TRUE) ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');
CREATE STAGE IF NOT EXISTS {{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT4 DIRECTORY = (ENABLE = TRUE) ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');
CREATE STAGE IF NOT EXISTS {{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT5 DIRECTORY = (ENABLE = TRUE) ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');

------put streamlit files in stages
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/road_network/towns_with_roads.py @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT1 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/road_network/environment.yml @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT1 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/road_network/config.toml @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT1/.streamlit auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/logos/snowflake_logo_color_rgb.svg @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT1/ auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/homepage/docs/stylesheets/extra.css @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT1/ auto_compress = false overwrite = true;

-------put streamlit 2 in stage
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/Slopey_Roofs/slopey_roofs.py @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT2 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/Slopey_Roofs/environment.yml @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT2 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/Slopey_Roofs/config.toml @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT2/.streamlit auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/logos/snowflake_logo_color_rgb.svg @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT2/ auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/homepage/docs/stylesheets/extra.css @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT2/ auto_compress = false overwrite = true;

-------put streamlit 3 in stage
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/cold_weather_payments/Home.py @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT3 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/cold_weather_payments/pages/1_postcode_details.py @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT3/pages auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/cold_weather_payments/pages/2_view_scenarios.py @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT3/pages auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/cold_weather_payments/pages/3_scenario_comparisons.py @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT3/pages auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/cold_weather_payments/pages/4_people_entitled.py @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT3/pages auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/cold_weather_payments/environment.yml @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT3 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/cold_weather_payments/config.toml @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT3/.streamlit auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/logos/snowflake_logo_color_rgb.svg @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT3/ auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/homepage/docs/stylesheets/extra.css @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT3/ auto_compress = false overwrite = true;

-------put streamlit 4 in stage
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/flood_zones/flood_zone.py @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT4 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/flood_zones/environment.yml @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT4 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/flood_zones/config.toml @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT4/.streamlit auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/logos/snowflake_logo_color_rgb.svg @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT4/ auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/homepage/docs/stylesheets/extra.css @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT4/ auto_compress = false overwrite = true;

------PUT streamlit 5 in stage
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/hackathon_data_explorer/app.py @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT5 auto_compress = false overwrite = true;
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/streamlit/hackathon_data_explorer/environment.yml @{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT4 auto_compress = false overwrite = true;

-----CREATE STREAMLITS

CREATE OR REPLACE STREAMLIT {{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.ROAD_NETWORK
ROOT_LOCATION = '@{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT1'
MAIN_FILE = 'towns_with_roads.py'
QUERY_WAREHOUSE = '{{ env.EVENT_WAREHOUSE }}'
COMMENT = '{"origin":"sf_sit", "name":"TOWNS_WITH_ROADS", "version":{"major":1, "minor":0}, "attributes":{"is_quickstart":0, "source":"streamlit"}}';

CREATE OR REPLACE STREAMLIT {{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.SOLAR_ENERGY_INSIGHTS
ROOT_LOCATION = '@{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT2'
MAIN_FILE = 'slopey_roofs.py'
QUERY_WAREHOUSE = '{{ env.EVENT_WAREHOUSE }}'
COMMENT = '{"origin":"sf_sit", "name":"SLOPEY_ROOFS", "version":{"major":1, "minor":0}, "attributes":{"is_quickstart":0, "source":"streamlit"}}';

CREATE OR REPLACE STREAMLIT {{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.COLD_WEATHER_PAYMENTS
ROOT_LOCATION = '@{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT3'
MAIN_FILE = 'Home.py'
QUERY_WAREHOUSE = '{{ env.EVENT_WAREHOUSE }}'
COMMENT = '{"origin":"sf_sit", "name":"SLOPEY_ROOFS", "version":{"major":1, "minor":0}, "attributes":{"is_quickstart":0, "source":"streamlit"}}';


CREATE OR REPLACE STREAMLIT {{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.FLOOD_ZONES
ROOT_LOCATION = '@{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT4'
MAIN_FILE = 'flood_zone.py'
QUERY_WAREHOUSE = '{{ env.EVENT_WAREHOUSE }}'
COMMENT = '{"origin":"sf_sit", "name":"SLOPEY_ROOFS", "version":{"major":1, "minor":0}, "attributes":{"is_quickstart":0, "source":"streamlit"}}';


CREATE OR REPLACE STREAMLIT {{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.HACKATHON_DATA_EXPLORER
ROOT_LOCATION = '@{{ env.DATAOPS_DATABASE }}.{{ env.STREAMLIT_SCHEMA }}.STREAMLIT5'
MAIN_FILE = 'app.py'
QUERY_WAREHOUSE = '{{ env.EVENT_WAREHOUSE }}'
COMMENT = '{"origin":"sf_sit", "name":"HACKATHON_DATA_EXPLORER", "version":{"major":1, "minor":0}, "attributes":{"is_quickstart":0, "source":"streamlit"}}';