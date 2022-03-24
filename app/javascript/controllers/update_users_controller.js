import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "deleteButton", "scholar", "arrow"]

  updateArrowToggle() {

    this.formTarget.classList.toggle("d-none");
    this.deleteButtonTarget.classList.toggle("d-none");

    const arrowElement = this.arrowTarget

    if (arrowElement.classList.contains("arrow-up")) {

      arrowElement.classList.remove("arrow-up");
      arrowElement.classList.add("arrow-down");
      arrowElement.src = "https://static.thenounproject.com/png/517806-200.png";

    } else {

      arrowElement.classList.remove("arrow-down");
      arrowElement.classList.add("arrow-up");
      arrowElement.src = "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.clipartbest.com%2Fcliparts%2Face%2FXMb%2FaceXMbaEi.png&f=1&nofb=1";

    }

  }

  updateScholarName(event) {

    event.preventDefault()
    const url = this.formTarget.action
    console.log(url)

    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.scholarTarget.outerHTML = data
      })

  }

}
