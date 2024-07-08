from PIL import Image
import pandas as pd


def display_df(df_path, **kwargs):
    return pd.read_csv(df_path, **kwargs).head()


def display_image(image_path, scale=1):
    img = Image.open(image_path)
    new_size = (int(img.width * scale), int(img.height * scale))
    return img.resize(new_size)

