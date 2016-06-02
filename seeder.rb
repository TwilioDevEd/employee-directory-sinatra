require_relative 'employee'

class Seeder
  def self.seed()
    Employee.destroy

    Employee.create(
      name: "Spider-Man",
      image_url: "http://i.annihil.us/u/prod/marvel/i/mg/3/50/526548a343e4b.jpg",
      email: "Spider-Man@heroes.example.com",
      phone_number: "+14155559610"
    )

    Employee.create(
      name: "Iron Man",
      image_url: "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55.jpg",
      email: "IronMan@heroes.example.com",
      phone_number: "+14155559368"
    )

    Employee.create(
      name: "Wolverine",
      image_url: "http://i.annihil.us/u/prod/marvel/i/mg/2/60/537bcaef0f6cf.jpg",
      email: "Wolverine@heroes.example.com",
      phone_number: "+14155559718"
    )

  end
end
