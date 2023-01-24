import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal-window"
export default class extends Controller {
  connect() {

  }

  showModal(event) {
    let modal = document.getElementsByClassName("modal")[0];
    modal.id = event.originalTarget.id.slice(3);
    modal.style.display = "block";
    console.log(event);
  }
}
