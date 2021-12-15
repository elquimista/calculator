import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['display']

  addDigit(e) {
    if (
      this._isDigit(e.target.innerText) &&
      this.displayTarget.value === '0'
    ) {
      this.displayTarget.value = ''
    }
    this.displayTarget.value += e.target.innerText
  }

  clear() {
    this.displayTarget.value = '0'
  }

  _isDigit(char) {
    return char >= '0' && char <= '9'
  }
}
