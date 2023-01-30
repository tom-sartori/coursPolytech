# Imported required libraries and modules
from pyspark.sql import SparkSession
from constant import COL_2019, SPEC_COLS, spark_inst

from extract import extract
from transform import *
from load import load

# Initiating and Calling SparkSession

if __name__ == '__main__':
    SPARK = spark_inst()

    #### Extract ####

    # Extracting CITY and COUNTRY data from MYSQL
    # city_df = extract(SPARK, "JDBC", "city")
    # country_df = extract(SPARK, "JDBC", "country")
    # Extracting COUNTRYLANGUAGE data from FileSystem
    # country_language_df = extract(SPARK, "CSV", "filesystem/countrylanguage.csv")
    parcoursup_2019 = extract(SPARK, "CSV", "data/fr-esr-parcoursup-2019.csv")
    nbEtudiantsBoursiers_2019 = extract(SPARK, "CSV", "data/fr-en-boursiers-par-departement.csv")

    #### Transformation ####

    # Filter
    parcoursup_2019 = where_df(parcoursup_2019, parcoursup_2019.region_etab_aff == "Occitanie")
    parcoursup_2019 = filter_df(parcoursup_2019, parcoursup_2019.acc_internat.isNull())

    # Join
    parcoursup_2019 = join_df(parcoursup_2019, nbEtudiantsBoursiers_2019, "dep", "numero_departement", "left")

    # GroupBy
    # parcoursup_2019 = parcoursup_2019.groupBy("fil_lib_voe_acc").count()

    # Get specific cols
    parcoursup_2019 = specific_cols(parcoursup_2019, SPEC_COLS)

    # Rename Columns
    parcoursup_2019 = rename_cols(parcoursup_2019, COL_2019)

    #### Load Data ####

    # MySQL
    # load("JDBC", country_city_language_df, "CountryCityLanguage")
    # FileSystem
    load("CSV", parcoursup_2019, "output/parcoursup_2019.csv")
