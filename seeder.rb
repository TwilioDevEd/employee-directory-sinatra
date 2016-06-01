require_relative 'employee'

class Seeder
  def self.seed()
    result = Employee.create({
      name: "Spider-Man",
      image_url: "http://i.annihil.us/u/prod/marvel/i/mg/3/50/526548a343e4b.jpg",
      email: "Spider-Man@heroes.example.com",
      phone_number: "+14155559610"
    })

    raise 'problem' unless result.saved?
  end
end
