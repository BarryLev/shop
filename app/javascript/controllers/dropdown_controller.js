import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {

  connect() {
    document.getElementById("dropdown-orders").style.display = "none"
    document.getElementById("dropdown-categories").style.display = "none"
  }

  toggle(event) {
    let dropdownId = "dropdown-" + event.originalTarget.id
    let dropdownDisplay = document.getElementById(dropdownId).style.display

    if (dropdownDisplay == "none") {
      document.getElementById(dropdownId).style.display = "block"
    }
    else if (dropdownDisplay == "block") {
      document.getElementById(dropdownId).style.display = "none"
    }
  }
}
