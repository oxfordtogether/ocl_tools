import ApplicationController from "./application_controller";
// import { useClickOutside } from "stimulus-use";

export default class extends ApplicationController {
  static targets = [
    "query",
    "value",
    "dropdown",
    "params",
    "searchIcon",
    "searchingIcon",
  ];
  static values = { params: String };

  connect() {
    super.connect();
    useClickOutside(this);
  }

  search(event) {
    event.preventDefault();
    this.searchIconTarget.hidden = true;
    this.searchingIconTarget.hidden = false;
    this.stimulate(
      "AutocompleteReflex#perform",
      this.paramsValue,
      this.queryTarget.value
    );
  }

  select(event) {
    event.preventDefault();
    const id = event.currentTarget.getAttribute("data-value");
    this.valueTarget.value = id;
    this.dropdownTarget.hidden = true;
    this.queryTarget.value = event.currentTarget.getAttribute("data-display");
  }

  clickOutside() {
    // clears the value from the query box if the id isn't set
    // (assumes that if the id is set, then the corresponding name will be in the query box)
    if (!this.valueTarget.value) {
      this.queryTarget.value = "";
      if (this.hasDropdownTarget) {
        this.dropdownTarget.hidden = true;
      }
    }
  }
}
