import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import "channels";

import debounced from "debounced";
debounced.initialize();

import "css/application.css";

Rails.start();
Turbolinks.start();
Turbolinks.setProgressBarDelay(200)

import "controllers"
