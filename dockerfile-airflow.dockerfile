# ----------------------------
# AIRFLOW CUSTOM IMAGE
# ----------------------------

# Use the official Apache Airflow image as the base
# This already contains:
# - Airflow installed
# - Python
# - Common system dependencies
FROM apache/airflow:2.9.3


# ----------------------------
# USER CONTEXT
# ----------------------------

# Switch to the "airflow" user instead of root
# Airflow images are designed to run as a non-root user
# This improves security and avoids permission issues
USER airflow


# ----------------------------
# INSTALL DBT
# ----------------------------

# Install dbt using pip inside the Airflow image
# - dbt-core: core dbt functionality
# - dbt-snowflake: Snowflake adapter (replace with dbt-postgres if needed)
#
# --no-cache-dir:
#   - keeps the image size smaller
#   - avoids storing pip cache inside the container
RUN pip install --no-cache-dir \
    dbt-core \
    dbt-snowflake
