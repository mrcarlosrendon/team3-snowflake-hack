
import streamlit as st
import pandas as pd
import snowflake.connector
import pydeck as pdk
import h3

from snowflake.snowpark.functions import *
from snowflake.snowpark.types import *
from snowflake.snowpark.context import get_active_session
session = get_active_session()


st.title("Emergency Resource Finder")

# Radius picker
radius = st.slider("Select marker radius", min_value=100, max_value=2000, value=500, step=50)

# Add checkboxes for each layer
show_nursing = st.checkbox("Show Nursing Homes", value=True, key='nursing')
show_hospital = st.checkbox("Show Hospitals", value=True, key='hospital')
show_dialysis = st.checkbox("Show Dialysis Centers", value=True, key='dialysis')
show_shelter = st.checkbox("Show Shelters", value=True, key='shelters')
show_vuln = st.checkbox("Show Vulnerability", value=True, key='vuln')


nursing_data = session.sql(""" 
SELECT LATITUDE, LONGITUDE, NAME, ADDRESS, BEDS AS CAPACITY
FROM DATAOPS_EVENT_PROD.HACKATHON_DATASETS.NURSING_HOMES
WHERE STATE IN ('LA') 
""").to_pandas()

# Define the Pydeck layer with tooltips
nursing_layer = pdk.Layer(
    "ScatterplotLayer",
    nursing_data,
    get_position='[LONGITUDE, LATITUDE]',
    get_color='[0, 30, 200, 160]',
    get_radius=radius,
    pickable=True,
)

hospital_data = session.sql(""" 
SELECT LATITUDE, LONGITUDE, NAME, OWNER, TYPE, BEDS as CAPACITY, HELIPAD, TTL_STAFF, POPULATION
FROM DATAOPS_EVENT_PROD.HACKATHON_DATASETS.HOSPITAL_LOCATIONS
WHERE STATE = 'LA'
""").to_pandas()

# Define the Pydeck layer with tooltips
hospital_layer = pdk.Layer(
    "ScatterplotLayer",
    hospital_data,
    get_position='[LONGITUDE, LATITUDE]',
    get_color='[200, 0, 0, 160]',
    get_radius=radius,
    pickable=True,
)


dialysis_data =  session.sql(""" 
SELECT X as LONGITUDE, Y AS LATITUDE, NAME, STATUS, ADDRESS
FROM DATAOPS_EVENT_PROD.HACKATHON_DATASETS.DIALYSIS_CENTERS
WHERE STATE = 'LA'
""").to_pandas()

# Define the Pydeck layer with tooltips
dialysis_layer = pdk.Layer(
    "ScatterplotLayer",
    dialysis_data,
    get_position='[LONGITUDE, LATITUDE]',
    get_color='[200, 200, 0, 160]',
    get_radius=radius,
    pickable=True,
)


shelter_data = session.sql(""" 
SELECT LATITUDE, LONGITUDE, SHELTER_NAME, ORG_ORGANIZATION_NAME, ADDRESS_1 AS ADDRESS, FACILITY_USAGE_CODE, EVACUATION_CAPACITY as CAPACITY, POST_IMPACT_CAPACITY, SHELTER_STATUS_CODE
FROM DATAOPS_EVENT_PROD.HACKATHON_DATASETS.NATIONAL_SHELTER_FACILITIES
WHERE STATE = 'LA'
""").to_pandas()

# Define the Pydeck layer with tooltips
shelter_layer = pdk.Layer(
    "ScatterplotLayer",
    shelter_data,
    get_position='[LONGITUDE, LATITUDE]',
    get_color='[0, 200, 0, 160]',
    get_radius=radius,
    pickable=True,
)

# Tooltip to show the NAME
tooltip = {
    "html": """
    <b>Name:</b> {NAME} <br>
    <b>Address:</b> {ADDRESS} <br>
    <b>CAPACITY:</b> {CAPACITY} <br>
    """,
    "style": {"backgroundColor": "steelblue", "color": "white"}
}



h3_cells = session.sql(""" 
SELECT
  t.M_HU,
  h3_cell.value::INTEGER AS H3_CELL_ID
FROM
  DATAOPS_EVENT_PROD.HACKATHON_DATASETS.SOCIAL_VULNERABILITY_INDEX t,
  LATERAL FLATTEN(input => H3_POLYGON_TO_CELLS(t.GEO, 8)) h3_cell
WHERE t.STATE = 'Louisiana'
""").to_pandas()

# Get polygon boundaries for each H3 cell
polygons = []
for cell in h3_cells:
    boundary = h3.h3_to_geo_boundary(cell, geo_json=True)
    polygons.append({
        "polygon": [list(coord) for coord in boundary],
        "h3_cell": cell
    })

# Create a pydeck layer
vuln_layer = pdk.Layer(
    "PolygonLayer",
    polygons,
    get_polygon="polygon",
    get_fill_color="[200, 30, 0, 40]",
    pickable=True,
    auto_highlight=True
)

# Collect selected layers
layers = []
if show_nursing:
    layers.append(nursing_layer)
if show_hospital:
    layers.append(hospital_layer)
if show_dialysis:
    layers.append(dialysis_layer)
if show_shelter:
    layers.append(shelter_layer)
if show_vuln:
    layers.append(vuln_layer)


st.pydeck_chart(
    pdk.Deck(
        layers=layers,
        initial_view_state=pdk.ViewState(
            latitude=nursing_data["LATITUDE"].mean(),
            longitude=nursing_data["LONGITUDE"].mean(),
            zoom=6,
            pitch=0,
        ),
        tooltip=tooltip,
    )
)
