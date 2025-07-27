# import the mysql python connector
import mysql.connector as connector

# connect to the database
connection = connector.connect(
    user="capstone",
    password="db-Capstone-Course8"
)

# get the cursor and use the database
cursor = connection.cursor()
cursor.execute("USE LittleLemonDB")

# list the database tables
show_tables_query = "SHOW tables"
cursor.execute(show_tables_query)
results = cursor.fetchall()
print(results)

# Execute the query for Task 3 and display the results
query1 = """SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS FullName, 
    c.Phone, 
    c.Email, 
    o.TotalCost AS 'Bill Paid' 
    FROM CustomerDetails AS c 
    LEFT JOIN Orders AS o 
    ON c.CustomerId = o.CustomerId 
    WHERE o.TotalCost > 60"""
cursor.execute(query1)
headings = cursor.column_names
print(headings)
results = cursor.fetchall()
for row in results:
    print(row)