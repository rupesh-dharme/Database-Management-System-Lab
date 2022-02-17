show dbs
use assignment09
db

db.places.insertOne({
student:"Rupesh",
city:"Akot"
})

db.places.insertMany([
{
student:"Vimal",
city:"Nashik"
},
{
student:"Dheeraj",
city:"Pune"
},
{
student:"Gayatri",
city:"Mumbai"
}
])

db.places.find({student:"Rupesh"}).pretty()
db.places.find({city:"Mumbai"}).pretty()

db.places.update({
student:"Dheeraj"
},
{
$set:{city:"Bangaluru"}
})

db.places.find().pretty()

db.places.remove({
student:"Gayatri"
})

db.places.find().pretty()

show collections
