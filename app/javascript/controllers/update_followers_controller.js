import { Controller } from "stimulus"



export default class extends Controller {
  static targets = ["card", "form"]

  updateFollowers(event) {

    event.preventDefault()
    const url = this.formTarget.action

    if (this.formTarget.classList.contains("add")) {
      fetch(url, {
        method: "POST",
        headers: {
          "Accept": "text/plain",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      }
    })
    .then(response => response.text())
    .then((data) => {
      this.cardTarget.outerHTML = data;
      this.cardTarget.querySelector('.favorite').classList.remove("add");
      this.cardTarget.querySelector('.form-favorites-input').value = "Unfollow"
    })

    } else {
    fetch(url, {
      method: "DELETE",
      headers: {
        "Accept": "text/plain",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      }
    })
    .then(response => response.text())
    .then((data) => {
      this.cardTarget.outerHTML = data;
      this.cardTarget.querySelector('.favorite').classList.add("add");
      this.cardTarget.querySelector('.form-favorites-input').value = "Follow"
    })
    }
  }
}
