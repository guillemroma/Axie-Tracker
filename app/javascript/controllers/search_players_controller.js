import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["input", "searchForm", "ranking"]

  update() {
    const url = `${this.searchFormTarget.action}?query=${this.inputTarget.value}`
    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        console.log(data)
        this.rankingTarget.outerHTML = data
      })
  }

}
