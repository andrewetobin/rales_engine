### Summary
This project is a Rails API app that provides JSON information related to an Ecommerce marketplace site and responds to different queries and requests. The responses include relevant information about the request, including records and other business intelligence operations.

The Rales Engine project is part of the back end engineering curriculum at the Turing School for Software and Design. Information related to this project can be found here: http://backend.turing.io/module3/projects/rails_engine

### Setup and Installation
To get this project on your own machine:

1. Clone down the project, or fork it into a repository of your own.
  * ``` git clone git@github.com:andrewetobin/rales_engine.git```
2. Once the project has been cloned into your folder, navigate to that folder and run
  * `bundle install`
  * `bundle update`
3. Once the gems have finished updating, you can create the Postgres database and tables by running
  * `rake db:{create,migrate}`
4. Then seed the database with the CSV data:
  * `rake import:all`
5. Once the database has been seeded, you can run our RSpec test suite by running
  * `rspec`
6. To start and interact with the server on your local machine, run
  * `rails s`
7. Now you can interact with the app at localhost:3000.
