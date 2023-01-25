import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="local-cart"
export default class extends Controller {
  connect() {
    sessionStorage.setItem('productID', "")
  }

  addProduct() {
    // this.#changeItem('productID', document.getElementsByClassName("modal")[0].id)
  }

  hideModal() {
    let modal = document.getElementsByClassName("modal")[0];
    modal.style.display = "none";
  }

  #changeItem(item, element) {

    let temp = sessionStorage.getItem(item)
    
    if (temp == ""){
      temp = element
    }
    else{
      temp += "," + element
    }

    sessionStorage.setItem(item, temp)
  }
}
