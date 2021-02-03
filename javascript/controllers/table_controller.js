import { Controller } from "stimulus";

export default class extends Controller {
  rowClick(e) {
    Turbolinks.visit(this.data.get("url"));
  }
}
