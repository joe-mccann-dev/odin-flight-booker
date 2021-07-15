# RavenReservations 

This project is an exercise in building advanced forms completed as part of [The Odin Project](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/building-advanced-forms). It is a flight-booker app in which hypothetical passengers can search for one way flights to or from airports selected from a dropdown. After viewing available flights, they can then select a flight to book and enter their information. This is done via nested forms, which requires whitelisting the nested attributes.

### Active Record Associations

- many to many relationships
- `has_many, through:` relationships
- generate db migrations with proper foreign keys
- utilize `accepts_nested_attributes_for`

### Active Record Queries
- connect dropdown select params to queries
- use `includes` method to eager load records where appropriate
- use `joins` to join two tables together when necessary
- implement a `search` feature to search for Bookings by confirmation number or email

### Testing

- RSpec and Capybara
- Model, and Feature specs
- use FactoryBot for fixtures

#### Notable Gems used
- capybara
- bullet
- guard
- shoulda-matchers
- factory_bot_rails
- faker
- simplecov
