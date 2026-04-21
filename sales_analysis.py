import pandas as pd

# CSV file load
df = pd.read_csv('sales_data.csv')

print(df.head())  # Display the first few rows of the DataFrame

# STEP 2: Column names clean
df.columns = df.columns.str.strip().str.lower().str.replace(" ", "_")

print (df.columns)  # Display the cleaned column names

# STEP 3: Date fix 

# Date convert (auto detect)
df['order_date'] = pd.to_datetime(df['order_date'], dayfirst=True, errors='coerce')

# Month column
df['month'] = df['order_date'].dt.month_name()

print(df[['order_date','month']].head())

# STEP 4: Region-wise Sales

region_sales = df.groupby('region')['sales'].sum().sort_values(ascending=False)

print(region_sales)

# STEP 5: Monthly Sales

monthly_sales = df.groupby('month')['sales'].sum()

print(monthly_sales)

# STEP 6: Top 5 Products

top_products = df.groupby('product_name')['sales'].sum().sort_values(ascending=False).head(5)

print(top_products)

# STEP 7: Visualization

import matplotlib.pyplot as plt

# Region chart
region_sales.plot(kind='bar')
plt.title("Region-wise Sales")
plt.show()