import psycopg2
import pandas as pd
import matplotlib.pyplot as plt


# Host: 34.32.97.154
# passwort postgres: Ai];>{o,Tl/XJ4I[
# database name: postgres
# user: postgres

# Unterstützt nicht das Einlesen mehrerer Fragen

# Konfigurationsdaten für die Session
def connect_to_db():
    print("=== Database connection ===")
    host = input("Host: ")
    port = input("Port (default 5432): ") or "5432"
    dbname = input("Database name: ")
    user = input("User: ")
    password = input("Password: ")

# Verbindung aufbauen
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

# run_query_loop - Programmschleife
# Query Eingabe und Abschicken und Empfangen
def run_query_loop(conn):
    print("=== SQL Query Mode ===")
    print("Enter SQL queries.")
    print("  :file path/to/query.sql")
    print("Type 'exit' to quit.\n")

    while True:
        # Query input - raus mit exit
        sql_input = input("SQL> ")

        if sql_input.lower() == "exit":
            break

        # Load SQL from file
        if sql_input.startswith(":file"):
            _, path = sql_input.split(maxsplit=1)
            sql = read_sql_file(path)
            if sql is None:
                continue
        else:
            sql = sql_input

        try:
            # Query an Cloud SQL Instanz ueber conn mit pd (pandas)
            # pandas dataframe: df
            df = pd.read_sql(sql, conn)

            if df.empty:
                print("Query executed successfully, no data returned.\n")
                continue

            print(df.head(), "\n")
            visualize(df)

        except Exception as e:
            print("❌ Query failed:")
            print(e, "\n")

# visualize Funktion
def visualize(df):
    print("=== Visualization ===")

    # Show columns with indices and dtypes
    for i, col in enumerate(df.columns):
        print(f"{i}: {col} ({df[col].dtype})")

    choice = input("\nVisualize data? (y/n): ").lower()
    if choice != "y":
        print()
        return

    print("\nChart types:")
    print("1: Bar chart")
    print("2: Line chart")
    print("3: Pie chart")
    print("4: Table")

    chart_type = input("Select chart type (1/2/3/4): ")

    custom_title = input("Custom title (press Enter to keep default): ").strip()

    if chart_type == "4":
        plot_table(df, custom_title)
        return

    x_idx = input("Select X column (number): ")
    y_idx = input("Select Y column (number): ")

    try:
        x_col = df.columns[int(x_idx)]
        y_col = df.columns[int(y_idx)]
    except (ValueError, IndexError):
        print("❌ Invalid column selection\n")
        return

    if chart_type == "3":
        plot_pie(df, x_col, y_col, custom_title)
    elif chart_type == "1":
        plot_bar(df, x_col, y_col, custom_title)
    elif chart_type == "2":
        plot_line(df, x_col, y_col, custom_title)
    else:
        print("❌ Invalid chart type\n")

def plot_table(df, title=None):
    rows, cols = df.shape

    # Dynamic figure size
    fig_width = min(12, max(6, cols * 1.5))
    fig_height = min(12, max(4, rows * 0.4))

    fig, ax = plt.subplots(figsize=(fig_width, fig_height))
    ax.axis("off")

    table = ax.table(
        cellText=df.values,
        colLabels=df.columns,
        loc="center",
        cellLoc="left"
    )

    table.auto_set_font_size(False)
    table.set_fontsize(10)
    table.scale(1, 1.4)

    if title:
        plt.title(title, pad=20)
    else:
        plt.title("Query Result", pad=20)

    plt.tight_layout()
    plt.show()


def plot_pie(df, label_col, value_col, title=None):
    if not pd.api.types.is_numeric_dtype(df[value_col]):
        print("❌ Pie chart requires numeric values\n")
        return

    plt.figure(figsize=(7, 7))
    plt.pie(
        df[value_col],
        labels=df[label_col].astype(str),
        autopct="%1.1f%%",
        startangle=90
    )

    if title:
        plt.title(title)
    else:
        plt.title(f"{value_col} distribution")

    plt.axis("equal")
    plt.tight_layout()
    plt.show()


def plot_bar(df, x_col, y_col, title=None):
    n = len(df)

    if n <= 10:
        fig_width = 8
        fig_height = 5
        horizontal = False
    else:
        fig_width = 10
        fig_height = max(6, n * 0.35)
        horizontal = True

    plt.figure(figsize=(fig_width, fig_height))

    if horizontal:
        plt.barh(df[x_col].astype(str), df[y_col])
        plt.ylabel(x_col)
        plt.xlabel(y_col)
    else:
        plt.bar(df[x_col].astype(str), df[y_col])
        plt.xlabel(x_col)
        plt.ylabel(y_col)
        plt.xticks(rotation=45)

    if title:
        plt.title(title)
    else:
        plt.title(f"{y_col} by {x_col}")

    plt.tight_layout()
    plt.show()



def plot_line(df, x_col, y_col, title=None):
    plt.figure(figsize=(8, 5))
    plt.plot(df[x_col], df[y_col])
    plt.xlabel(x_col)
    plt.ylabel(y_col)

    if title:
        plt.title(title)
    else:
        plt.title(f"{y_col} over {x_col}")

    plt.tight_layout()
    plt.show()


def read_sql_file(path):
    try:
        with open(path, "r", encoding="utf-8") as f:
            sql = f.read().strip()

        # Remove trailing semicolon (Postgres accepts it, pandas sometimes doesn't)
        if sql.endswith(";"):
            sql = sql[:-1]

        return sql

    except Exception as e:
        print("❌ Failed to read SQL file:")
        print(e)
        return None

def main():
    conn = None
    # versuch solange zu connecten wie geht
    while conn is None:
        conn = connect_to_db()

    # Mache SQL-Anfragen und visualize solange kein exit vom user
    run_query_loop(conn)
    conn.close()
    print("Connection closed. Bye!")

if __name__ == "__main__":
    main()

