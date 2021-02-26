# Trz

## How to run
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`
  * Run test `mix phx.test`


Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Endpoints

* Create survivors ( post /api/survivors )
  
  {
    "name": Faker.Person.name,
    "age": 20,
    'gender": "Feminino",
    "latitude": "34.543666",
    "longitude": "11.445465",
    "fiji_water": 5,
    "campbell_soup": 6,
    "first_aid_pouch": 2,
    "ak47": 3
  }
  

 * Update a survivor last location ( put /api/last_location/:id )
  
  {"last_location": {"latitude": "11.44", "longitude": "22.55"}}
  

 * Flag marked survivor as infected ( put /api/flag/:id )
  
  { "snitch_id": 1}
  

 * Reports ( get api/reports )

 * Trade ( post /api/trade )
  
  Not yet

  github:

  https://github.com/angelorange
