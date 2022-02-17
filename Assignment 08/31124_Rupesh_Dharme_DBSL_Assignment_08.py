import mysql.connector

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="assignment08"
)

cursor = db.cursor()

while True:
    option = int(input(
        "What to perform?\n1. Create (Insert)\n2. Read   (Select)\n3. Update (Update)\n4. Delete (Delete)\n5. Exit\n"))
    if option == 5:
        break
    if option == 1:
        roll = input("Enter Roll no: ")
        name = input("Enter name: ")
        cursor.execute(f"Insert into Student values ('{name}',{roll})")
        db.commit()
        print("inserted!")
    if option == 2:
        cursor.execute("select * from Student")
        print("Roll_No\tName")
        for record in cursor.fetchall():
            roll, name = record
            print(f"{roll}\t{name}")
        print("read!")
    if option == 3:
        roll = input("Enter Roll no: ")
        name = input("Enter name: ")
        cursor.execute(
            f"update Student set Name='{name}' where Roll_No={roll}")
        db.commit()
        print("updated!")
    if option == 4:
        roll = input("Enter Roll no: ")
        cursor.execute(f"delete from Student where Roll_No={roll}")
        db.commit()
        print("deleted!")

db.close()
