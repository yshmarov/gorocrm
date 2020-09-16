#rails db:drop db:create db:migrate db:seed
User.create!(email: 'admin@example.com', password: 'admin@example.com', password_confirmation: 'admin@example.com')
Tenant.create!(name: "Microsoft")
Member.create!(tenant: Tenant.first, user: User.first, admin: true)
#Member.first.update!(admin: true)
