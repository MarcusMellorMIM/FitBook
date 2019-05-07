marcus=User.create(name:"Marcus",height_cm:177,gender:"M" )

w1=Weight.create( user_id:1, weight_kg:103)
e1 =Exercise.create(detail:'yoga',exercise_date:'20190507',exercise_type_id:1,user_id:1)

m1 =Meal.create(detail:'fish and chips',meal_date:"20190507",meal_type_id:1,user_id:1)
