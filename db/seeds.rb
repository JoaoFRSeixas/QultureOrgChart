require 'faker'

# Limpa dados antigos
Employee.destroy_all
Company.destroy_all

# Cria empresas
3.times do
  company = Company.create!(name: Faker::Company.unique.name)

  # Cria gestores
  managers = []
  2.times do
    managers << company.employees.create!(
      name: Faker::Name.unique.name,
      email: Faker::Internet.unique.email,
      picture: nil
    )
  end

  # Cria colaboradores e associa gestores
  5.times do
    manager = managers.sample
    company.employees.create!(
      name: Faker::Name.unique.name,
      email: Faker::Internet.unique.email,
      picture: nil,
      manager: manager
    )
  end

  # Cria um colaborador sem gestor
  company.employees.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    picture: nil
  )
end

puts "Seed completed!"
