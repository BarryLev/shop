import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="local-cart"
export default class extends Controller {
  connect() {
    localStorage.setItem('productID', "")
  }

  addProduct() {
    let id = "0"
    let temp = localStorage.getItem('productID')
    
    if (temp.length == id){
      temp = id
    }
    else{
      temp += "," + id
    }

    localStorage.setItem('productID', temp)
    //console.log(temp.split(','))
  }
}
