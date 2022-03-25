import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["option", "form"]

  replaceWinRate(event) {

    event.preventDefault()

    const win_rate = this.optionTarget.getAttribute("data-value")
    const url = this.formTarget.action

    console.log()
    console.log(win_rate)

    fetch(url, {
      method: "GET",
      headers: {
        "Accept": "text/plain",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        //this.scholarTarget.outerHTML = data
      })

  }

}
