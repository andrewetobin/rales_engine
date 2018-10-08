### Summary
This project is a Rails API app that provides JSON information related to an Ecommerce marketplace site and responds to different queries and requests. The responses include relevant information about the request, including records and other business intelligence operations.

The Rales Engine project is part of the back end engineering curriculum at the Turing School for Software and Design. Information related to this project can be found here: http://backend.turing.io/module3/projects/rails_engine

### Gems used:
* Active_Model_Serializers
* Factory-Bot
* Pry
* Rspec-Rails
* SimpleCov
* Shoulda-Matchers


### API Endpoints:

There are 6 main resources used in this application:
* Merchants
* Customers
* Items
* Invoices
* Invoice_items
* Transactions

For each of these 6 resources, there are endpoints for showing all records or a single record:
* GET `/api/v1/(resource_name)`
* GET `/api/v1/(resource_name)/:id`

In addition, there are a few related endpoints as well:
* GET `/api/v1/(resource_name)/:id/(related_resource_name)`

The related resources are:
* Merchants: Items, Invoices
* Invoices: Transactions, Invoice_items, Items, Customer, Merchant
* Invoice_items: Invoices, Items
* Items: Invoice_items, Merchants
* Transactions: Invoices
* Customers: Invoices, Transactions

There are also a number of Business Intelligence endpoints:
* GET `/api/v1/merchants/most_revenue?quantity=x`
* GET `/api/v1/merchants/most_items?quantity=x`
* GET `/api/v1/merchants/revenue?date=x`
* GET `/api/v1/merchants/:id/revenue`
* GET `/api/v1/merchants/:id/revenue?date=x`
* GET `/api/v1/merchants/:id/favorite_customer`
* GET `/api/v1/items/most_revenue?quantity=x`
* GET `/api/v1/items/most_items?quantity=x`
* GET `/api/v1/customers/:id/favorite_merchant`

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
