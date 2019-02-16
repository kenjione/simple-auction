# frozen_string_literal: true

User.destroy_all

user1 = User.create(email: 'tony@example.com', password: 'qweasdzxc', balance: 10000)
user2 = User.create(email: 'dave@example.com', password: 'qweasdzxc', balance: 15000)
user3 = User.create(email: 'harold@example.com', password: 'qweasdzxc', balance: 20000)

user1.products.create(name: 'Product #1', price: 100.00, state: 'published', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ')
user1.products.create(name: 'Product #2', price: 250.00, state: 'published', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ')
user1.products.create(name: 'Product #3', price: 450.00, state: 'published', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ')
user2.products.create(name: 'Product #4', price: 620.00, state: 'published', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ')
user2.products.create(name: 'Product #5', price: 50.00, state: 'published', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ')
