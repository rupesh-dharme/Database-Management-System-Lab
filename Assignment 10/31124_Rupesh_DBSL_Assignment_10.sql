show dbs
use assignment10
db

db.places.insertMany([
{
student:"Rupesh",
city:"Akot"
},
{
student:"Dheeraj",
city:"Pune"
},
{
student:"Rohan",
city:"Pune"
},
{
student:"Nikhil",
city:"Mumbai"
}
])

db.places.find().pretty()

db.places.aggregate([
{$group:{
_id:"$city",
count:{$sum:1}
}
}
])

db.places.createIndex({
key:1
})

db.places.aggregate([
{$match:{}},
{$group:{_id:"$student"}},
{$sort:{_id:1}}
])

db.places.aggregate([
{$match:{}},
{$group:{_id:"$student"}},
{$sort:{_id:-1}}
])