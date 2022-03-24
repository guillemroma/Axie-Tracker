import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["content", "icon"]

  toggleContent() {

    this.contentTarget.classList.toggle("d-none");

    const iconElement = this.iconTarget

    if (iconElement.classList.contains("plus")) {

      iconElement.classList.remove("plus");
      iconElement.classList.add("minus");
      iconElement.src = "https://iconsplace.com/wp-content/uploads/_icons/ffffff/256/png/minus-2-icon-18-256.png";

    } else {

      iconElement.classList.remove("minus");
      iconElement.classList.add("plus");
      iconElement.src = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.iconsdb.com%2Ficons%2Fpreview%2Fwhite%2Fplus-xxl.png&f=1&nofb=1";

    }

  }

}
