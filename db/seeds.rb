#rails db:drop db:create db:migrate db:seed
User.create!(email: 'admin@example.com', password: 'admin@example.com', password_confirmation: 'admin@example.com')
Tenant.create!(name: "Microsoft")
Member.create!(tenant: Tenant.first, user: User.first, admin: true)
User.update_all confirmed_at: DateTime.now

#User.first.toggle(:superadmin) #will not work because superadmin is not a whitelisted param (good for security)
#User.first.update!(superadmin: true) #will not work because superadmin is not a whitelisted param (good for security)
#Member.first.update!(admin: true)
