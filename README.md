# OclTools

Rails engine containing useful stuff for OCL rails applications.

## Making changes to the engine

(Also see Using the Engine section)

Add new elements to the dummy app so that other people can have a look.

If you change any javascript, run `yarn run build` to re-bundle the js.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "ocl_tools", git: "https://github.com/oxfordtogether/ocl_tools.git"
```

Run the following to add the yarn package:

```bash
yarn add oxfordtogether/ocl_tools.git
```

And then execute:

```bash
bundle install
```

Then add this line to the ApplicationController to ensure helpers from the engine are available:

```
helper OclTools::ComponentsHelper
helper OclTools::FormHelper
default_form_builder OclTools::TailwindFormBuilder
```

In order to use pagination component, you need to install `pagy` in your app:

1. Add `pagy` gem
2. Add `config/initializers/pagy.rb` (see dummy app for example)
3. Add `include Pagy::Backend` in `application_controller.rb`

Add the following to `javascript/controllers/index.js`. This loads the controllers from ocl_tools into the stimulus instance in your app.

```
import ocl_tools from 'ocl_tools'

const application = Application.start()
const context = require.context('controllers', true, /_controller\.js$/)

const ocl_tools_controllers = Object.keys(ocl_tools.controllers).map((label) => (
  {'identifier': label, 'controllerConstructor': ocl_tools.controllers[label] }
))

const context_list = definitionsFromContext(context).concat(ocl_tools_controllers)

application.load(context_list)
StimulusReflex.initialize(application, { consumer })
```

## Developing against a local version

If you want to be able to make changes to ocl tools alongside another application, you can link
to a local version.

For the ruby parts, you just need to link to the local copy in your `Gemfile` and changes
will immediately be picked up by the main app:

```
gem "ocl_tools", path: "../ocl_tools"
```

For the javascript parts, you'll need to use yarn link and set up a process to build the `dist`
folder on changes:

```
# in ocl_tools
yarn link
yarn run debug

# in your app
yarn link ocl_tools
```

## Using the Engine

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

- Search / autocomplete
- Notes on how to get stimulus working
