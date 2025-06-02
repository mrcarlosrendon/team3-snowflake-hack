
import streamlit as st
import pandas as pd
import snowflake.connector
import pydeck as pdk

from snowflake.snowpark.functions import *
from snowflake.snowpark.types import *
from snowflake.snowpark.context import get_active_session
session = get_active_session()

# Radius picker
radius = st.slider("Select marker radius", min_value=100, max_value=2000, value=500, step=50)

# Add checkboxes for each layer
show_nursing = st.checkbox("Show Nursing Homes", value=True, key='nursing')
show_hospital = st.checkbox("Show Hospitals", value=True, key='hospital')
show_dialysis = st.checkbox("Show Dialysis Centers", value=True, key='dialysis')


nursing_data = session.sql(""" 
SELECT LATITUDE, LONGITUDE, NAME
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
SELECT LATITUDE, LONGITUDE, NAME, OWNER, TYPE, BEDS, HELIPAD, TTL_STAFF, POPULATION
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

# Tooltip to show the NAME
tooltip = {
    "html": """
    <b>Name:</b> {NAME} <br>
    {% if OWNER %}
        <b>Owner:</b> {OWNER} <br>
        <b>Beds:</b> {BEDS} <br>
        <b>Type:</b> {TYPE} <br>
        <b>Helipad:</b> {HELIPAD} <br>
        <b>Total Staff:</b> {TTL_STAFF} <br>
        <b>Population:</b> {POPULATION}
    {% elif STATUS %}
        <b>Status:</b> {STATUS} <br>
        <b>Address:</b> {ADDRESS} <br>
        <i>Dialysis Center</i>
    {% else %}
        <i>Nursing Home</i>
    {% endif %}
    """,
    "style": {"backgroundColor": "steelblue", "color": "white"}
}

# Collect selected layers
layers = []
if show_nursing:
    layers.append(nursing_layer)
if show_hospital:
    layers.append(hospital_layer)
if show_dialysis:
    layers.append(dialysis_layer)


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
