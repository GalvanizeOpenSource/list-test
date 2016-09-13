todo_list = TodoList.create(
  title: SecureRandom.hex,
  description: SecureRandom.hex(50)
)

todo_items = []

5.times do |n|
  todo_items << todo_list.todo_items.create(
    due_by: DateTime.current + (rand(n)).minutes,
    content: SecureRandom.hex(50)
  )

  todo_items << todo_list.todo_items.create(
    content: SecureRandom.hex(50)
  )
end

puts "#{todo_items.size} todo items created"
