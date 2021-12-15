import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['display']

  addDigit(e) {
    if (this.displayTarget.innerText === '0') {
      this.displayTarget.innerText = ''
    }
    this.displayTarget.innerText += e.target.innerText
  }

  clear() {
    this.displayTarget.innerText = '0'
  }
}
