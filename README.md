

Roomer
======

Roomer is a multitenant framework for Rails using PostgreSQL

Multitenant Data Strategy
-------------------------

While there are several strategies for multi-tenancy, Roomer uses PostgreSQL's schemas (namespaces) to achieve its goal. You can use Roomer if your application has the below characteristics:

* Each Tenant's data has be to be private to the Tenant.
* No (or minimal) requirement to run cross-tenant queries.

Each Tenant's data is stored in separate schema and shared data is stored in a "global" schema accessible to all the Tenants.

PostgreSQL "Schemas"
--------------------
A database in PostgreSQL contains one or more named schemas, which in turn contain tables. Schemas also contain other kinds of named objects, including data types, functions, and operators. The same object name can be used in different schemas without conflict; for example, both schema1 and myschema may contain tables named mytable. Unlike databases, schemas are not rigidly separated: a user may access objects in any of the schemas in the database he is connected to, if he has privileges to do so.

More information at http://www.postgresql.org/docs/8.2/static/ddl-schemas.html

Usage
=====

Installation
------------

Roomer currently in pre-release and only supports Rails 3. In your Gemfile insert the below and run "bundle install"

    gem 'roomer', :git => "git://github.com/gosuri/roomer.git"

After you install Roomer and add it to your Gemfile, you need to run the generator. Roomer will use default values "tenant" for Tenant scoped models and "global" for shared models. If you'd like to override the defaults use the optional parameters

    rails generate roomer:install

The generator will install an initializer under config/initializers/roomer.rb which describes ALL Roomer’s configuration options and you MUST take a look at it.

Setup
-----

After you've done the necessary config changes to the initializer, run the setup:

    rails generate roomer:setup 

*Running Migrations*

_*Shared*_

The setup will generate migrations under db/migrate/[shared_shema_name], by default it should be db/migrate/global. You need to run the shared migrations to setup the tenant tables

    rake roomer:shared:migrate

_*Tenanted*_

This will run migrations under db/migrate. If you set the "config.use_tenanted_migrations_directory" parameter to true, it should run the migrations under db/migrate/[tenant_table_name]/*

    rake roomer:tenanted:migrate


Models
------

To enable Roomer on your models, simply call the roomer method and specify the type in your Model Class definition:

    class Orders < ActiveRecord::Base
      roomer :tenanted
    end

Roomer supports types of scoped models

* :shared   - Shared by all tenants
* :tenanted - Scoped to a tenant

Roomer also provides generators, if you have the Model defined already, it will append to it. For Example:

    rails generate roomer:model user name:string email:string

Optionally, you can specify --shared flag to generate a shared model

    rails generate roomer:model organizations name:string desc:string --shared

Routes
------

To enable roomer scoped routes, surround your regular routes under roomer_on(tenants_model_name)

    roomer_on(:tenants) do
      resources :orders
    end


Contributors
============

https://github.com/gosuri/roomer/contributors

Build Status
============
* STABLE    - [![Build Status](http://travis-ci.org/gosuri/roomer.png?branch=master)](http://travis-ci.org/gosuri/roomer?branch=master)
* UNSTABLE  - [![Build Status](http://travis-ci.org/gosuri/roomer.png?branch=develop)](http://travis-ci.org/gosuri/roomer?branch=develop)

