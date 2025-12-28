import psycopg2
import pandas as pd
import matplotlib.pyplot as plt


def connect_to_db():
    print("=== Database connection ===")
    host = input("Host: ")
    port = input("Port (default 5432): ") or "5432"
    dbname = input("Database name: ")
    user = input("User: ")
    password = input("Password: ")

    try:
        conn = psycopg2.connect(
            host=host,
            port=port,
            dbname=dbname,
            user=user,
            password=password,
            sslmode="require"   # Cloud SQL
        )
        print("✅ Connected successfully\n")
        return conn
    except Exception as e:
        print("❌ Connection failed:")
        print(e)
        return None


def run_query_loop(conn):
    print("=== SQL Query Mode ===")
    print("Enter SQL queries.")
    print("Type 'exit' to quit.\n")

    while True:
        sql = input("SQL> ")

        if sql.lower() == "exit":
            break

        try:
            df = pd.read_sql(sql, conn)

            if df.empty:
                print("Query executed successfully, no data returned.\n")
                continue

            print(df.head(), "\n")

            visualize(df)

        except Exception as e:
            print("❌ Query failed:")
            print(e, "\n")


def visualize(df):
    """
    Very simple automatic visualization:
    - If there are 2 columns and one is numeric → bar chart
    - Otherwise → no visualization
    """
    numeric_cols = df.select_dtypes(include="number").columns

    if len(df.columns) == 2 and len(numeric_cols) == 1:
        x = df.columns[0]
        y = numeric_cols[0]

        plt.figure(figsize=(8, 5))
        plt.bar(df[x].astype(str), df[y])
        plt.xlabel(x)
        plt.ylabel(y)
        plt.title(f"{y} by {x}")
        plt.xticks(rotation=45)
        plt.tight_layout()
        plt.show()
    else:
        print("ℹ️ Data returned, but no automatic visualization applied.\n")


def main():
    conn = None
    while conn is None:
        conn = connect_to_db()

    run_query_loop(conn)
    conn.close()
    print("Connection closed. Bye!")


if __name__ == "__main__":
    main()
