show dbs

use assignment11

db

db.students.insertMany([
{
name:'Rupesh',
marks:97,
Grade:'A+'
},
{
name:'Tanuj',
marks:83,
Grade:'A'
},
{
name:'Rajan',
marks:75,
Grade:'B'
},
{
name:'Rupesh',
marks:92,
Grade:'A+'
},
{
name:'Dheeraj',
marks:95,
Grade:'A+'
},
{
name:'Rohan',
marks:98,
Grade:'A+'
}
])

db.students.find().pretty()

db.students.mapReduce(
function(){
emit(this.name,this.marks);},
function(key, value){
return Array.sum(value)},
{
query:{Grade:'A+'},
out:'totalMarks'
}
)

db.totalMarks.find().pretty()