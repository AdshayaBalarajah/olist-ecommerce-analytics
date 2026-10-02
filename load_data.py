import pandas as pd, glob, os
from sqlalchemy import create_engine

engine = create_engine("postgresql+psycopg2://postgres:YOUR_PASSWORD@localhost:5432/olist")

for f in glob.glob("data/*.csv"):
    name = os.path.basename(f).replace("olist_", "").replace("_dataset", "").replace(".csv", "")
    pd.read_csv(f).to_sql(name, engine, if_exists="replace", index=False)
    print("loaded", name)