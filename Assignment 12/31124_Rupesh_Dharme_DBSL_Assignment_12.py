# Rupesh Dharme
# TE 01
# 31124
# Assignment 12
# DBSL

from pymongo import MongoClient

class Connect:
    def __init__(self):
        self.client = MongoClient("mongodb://localhost:27017/?readPreference=primary&appname=MongoDB%20Compass&directConnection=true&ssl=false")
        self.db = self.client['assignment12']
        self.collection= self.db['states']

    def create(self):
        state = input("Enter State: ")
        capital = input("Enter capital: ")
        new_post = {
            "state": state,
            "capital": capital,
        }
        self.collection.insert_one(new_post)

    def read(self):
        response = self.collection.find()
        for record in response:
            print(record)

    def update(self):
        state = input("Enter State: ")
        capital = input("Enter capital: ")
        prev_record = {'state': state}
        new_record = {
            "state": state,
            "capital":capital,
        }
        response = self.collection.update_one(prev_record, {'$set': new_record})

    def delete(self):
        state = input("Enter State: ")
        record = {'state': state}
        response = self.collection.delete_one(record)

if __name__ == '__main__':
    connection = Connect()
    while True:
        option=int(input("What to perform?\n1. Create (Insert)\n2. Read   (Select)\n3. Update (Update)\n4. Delete (Delete)\n5. Exit\n"))
        if option==1:
            connection.create()
            print("Document created")
        elif option==2:
            connection.read()
            print("Data read")
        elif option==3:
            connection.update()
            print("Document updated")
        elif option==4:
            connection.delete()
            print("Document deleted")
        else:
            print("Thank you")
            break
    connection.client.close()
