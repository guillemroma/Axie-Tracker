import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["arrow", "updateForm"]

  updateArrowToggle() {

    this.updateFormTarget.classList.toggle("d-none");

    const arrowElement = this.arrowTarget

    if (arrowElement.classList.contains("arrow-up")) {

      arrowElement.classList.remove("arrow-up");
      arrowElement.classList.add("arrow-down");
      arrowElement.src = "https://cdn0.iconfinder.com/data/icons/ecommerce-121/24/drop-down_up-512.png";

    } else {

      arrowElement.classList.remove("arrow-down");
      arrowElement.classList.add("arrow-up");
      arrowElement.src = "https://cdn0.iconfinder.com/data/icons/ecommerce-121/24/drop-down_down-512.png";

    }

  }

}
