import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import "channels";
import ocl_tools from 'ocl_tools'

console.log('hi', ocl_tools.say_hello())

import "css/application.css";

Rails.start();
Turbolinks.start();
Turbolinks.setProgressBarDelay(200)

import "controllers"
