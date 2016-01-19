class Animal
  attr_accessor :name, :gender, :admittance_date, :type, :breed
  attr_reader :id

  def initialize(attributes)
    @name = attributes[:name]
    @gender = attributes[:gender]
    @admittance_date = attributes[:admittance_date]
    @type = attributes[:type]
    @breed = attributes[:breed]
  end

  def save
    result = DB.exec("INSERT INTO animals (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(another_animal)
    self.name == another_animal.name
  end

  def self.all
    returned_animals = DB.exec("SELECT * FROM animals;")
    animals = []
    returned_animals.each do |animal|
      name = animal["name"]
      gender = animal["gender"]
      admittance_date = animal["admittance_date"]
      type = animal["type"]
      breed = animal["breed"]
      animals << Animal.new({name: name, gender: gender, admittance_date: admittance_date, type: type, breed: breed})
    end
    animals
  end
end
