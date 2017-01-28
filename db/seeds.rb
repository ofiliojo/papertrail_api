for i in 0..10
  User.create(full_name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Name.name)
end

for i in 0..100
  Expense.create(amount: rand(0.01...999999999999999.99), description: Faker::ChuckNorris.fact, user_id: rand(1...10))
end
