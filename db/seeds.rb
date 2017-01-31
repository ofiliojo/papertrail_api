for i in 0..10
  User.create(full_name: Faker::Name.name, email: Faker::Internet.email, password: 'password')
end

for i in 0..100
  Expense.create(amount: rand(0.01...1000.00), description: Faker::ChuckNorris.fact, user_id: rand(1...10))
end
