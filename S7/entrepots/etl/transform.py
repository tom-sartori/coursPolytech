from pyspark.sql import DataFrame


def rename_cols(df: DataFrame, mapping_dict: dict) -> DataFrame:
    """
    Rename all the columns
    :param df: input dataframe
    :param mapping_dict: dict of columns names
    :return: ouput dataframe
    """
    for key in mapping_dict.keys():
        df = df.withColumnRenamed(key, mapping_dict.get(key))
    return df  # get specific cols df


def specific_cols(df: DataFrame, specific_cols: list):
    """
    :param df: input dataframe
    :param specific_cols: list of columns names
    :return: ouput dataframe
    """
    return df.select(specific_cols)  # Join two dataframes


def join_df(left_df: DataFrame, right_df: DataFrame, left_column: str, right_column: str, join_type: str) -> DataFrame:
    """
    :param right_column:
    :param left_column:
    :param left_df: input dataframe
    :param right_df: input dataframe
    :param join_type: Join type
    :return: ouput dataframe
    """
    return left_df.join(right_df, left_df[left_column] == right_df[right_column], join_type)


def where_df(df: DataFrame, filter_condition: str) -> DataFrame:
    return df.where(filter_condition)


def filter_df(df: DataFrame, filter_condition: str) -> DataFrame:
    return df.filter(filter_condition)
