# OclTools
Rails engine containing useful stuff for OCL rails applications.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "ocl_tools", git: "git@github.com:oxfordtogether/ocl_tools.git"
```

Run the following to add the yarn package:
```bash
yarn add git@github.com:oxfordtogether/ocl_tools.git
```

And then execute:
```bash
bundle install
```

Then add this line to the ApplicationController to ensure helpers from the engine are available:
```
helper OclTools::ComponentsHelper
```

In order to use pagination component, you need to install `pagy` in your app:
1. Add `pagy` gem
2. Add `config/initializers/pagy.rb` (see dummy app for example)
3. Add `include Pagy::Backend` in `application_controller.rb`

## Using the engine

### Using a view component:
```
<%= render OclTools::SimpleComponent.new %>
or
<%= simple() %>
```

## Run the dummy app

Install [nodemon](https://www.npmjs.com/package/nodemon). Nodemon is a command line tool that watches for file changes then runs a predefined command. We use it to re-build the distribution files on changes to javascript in the engine.
```
yarn global add nodemon
```

```
# in the ocl_tools directory
yarn run debug
```

A dummy app can be found in `test/dummy` with ocl_tools installed. Start this app by running the following commands in two separate console windows.
```
# in the test/dummy directory
rails s
bin/webpack-dev-server
```

```
rails db:migrate
```

In theory, changes to the engine should cause the dummy app to reload.

## TO DO

* Search / autocomplete
