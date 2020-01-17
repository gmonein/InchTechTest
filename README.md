Intro
=====

We are building a Ruby on Rails app that will update our database to match the data our clients provide in CSV format on a daily basis.

The objective is to code the CSV import and handle some specific update rules.

Lets consider that the app manages 2 models (all their attributes are strings): 
- **Person** with the following attributes : `reference`, `email`, `home_phone_number`, `mobile_phone_number`, `firstname`, `lastname`, `address`
- **Building** with the following attributes : `reference`, `address`, `zip_code`, `city`, `country`, `manager_name`

###### Do not use third party gems in your solution

Step 0
======

#### ✔️ Create a new Ruby on Rails project and create the models.

```bash
rails new inch
cd inch
rails g model Person reference:string email:string home_phone_number:string mobile_phone_number:string firstname:string lastname:string address:string
rails g model Building reference:string address:string zip_code:string city:string country:string manager_name:string
```

Step 1
======

#### ✔️ Implement the import feature that takes a given csv file and creates/updates (no need to handle deletions) the records of the corresponding table to match the data in the csv.

###### Example csv files are provided below to help you understand the input format; you'll have to create more when writing your tests.
###### Note: In the example files, there are only 2 lines per csv, but in reality there can be millions of records to import each day (do not neglect performance).

Step 2
======

Some attributes have to respect specific rules regarding the update of their value :
- The considered attributes should be overwritten by the csv import **only if** the value provided in the csv has never been a value of that field.
- In parallel to updates made by the csv imports, the users of our application can also update the records on a provided user interface (no need to develop that interface). A manual update should always succeed.

The attributes that must respect these rules are the following (all the other attributes must match the csv):
- for the Person model : `email`, `home_phone_number`, `mobile_phone_number` and `address`
- for the Building model : `manager_name`

#### ✔️ Make the necessary changes to your code to handle these rules.

Evaluation
==========

We will closely watch the following criteria for the evaluation:
- The readability of the code (how easily we can understand what you did)
- The flexibility of the code (how easy it would be to extend the features)
- The global performance of the import (we don't need a rocket, but not a turtle either. We will not evaluate the performance of the CSV parsing lib, use the default ruby CSV parsing lib)
- The testing of your code (use RSpec or any other testing framework that you're used to)