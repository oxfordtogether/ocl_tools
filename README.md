# OclTools
Rails engine containing useful stuff for OCL rails applications.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "ocl_tools", git: "git@github.com:oxfordtogether/ocl_tools.git"
```

And then execute:
```bash
bundle install
```

Then add this line to the ApplicationController to ensure helpers from the engine are available:
```
helper OclTools::Engine.helpers
```
