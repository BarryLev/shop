import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="local-cart"
export default class extends Controller {
  connect() {
    localStorage.setItem('productID', "")
  }

  addProduct() {
    let id = "0"
    this.#changeItem('productID', id)
    //console.log(temp.split(','))
  }

  #changeItem(item, element) {

    let temp = localStorage.getItem(item)
    
    if (temp.length == element){
      temp = element
    }
    else{
      temp += "," + element
    }

    localStorage.setItem(item, temp)
  }
}
