#marcus=User.create(name:"Marcus",height_cm:177,gender:"M" )
#w1=Weight.create( user_id:1, weight_kg:103)
#e1 =Exercise.create(detail:'yoga',exercise_date:'20190507',exercise_type_id:1,user_id:1)
#m1 =Meal.create(detail:'fish and chips',meal_date:"20190507",meal_type_id:1,user_id:1)

Meal.find(1)
MealDetail.create(detail:m1.detail, calories:670, meal_id:1)
ExerciseDetail.create(detail:ex1.detail, calories:330, exercise_id:1)

# Test users
user1=User.find(1)
w1=Weight.find(1)
ex1=Exercise.find(1)
m1=Meal.find(1)
ext1=ExerciseType.find(1)
mt1=MealType.find(1)

exd1=ExerciseDetail.find(1)

md1=MealDetail.find(1)
