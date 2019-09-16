$(function() {
  listenForElementsClick()
  listenForNewElementFormClick()
});

function listenForElementsClick() {
  $('button#elements-data').one('click', function(event) {
    event.preventDefault()
    getElements()
  })
}

function getElements() {
  $.ajax({
    url: `http://localhost:3000/users/${userId}/elements`,
    method: 'get',
    dataType: 'json',
    success: function(data) {
      console.log("the data is: ", data)
      data.map(element => {
        const newElement = new Element(element)
        const newElementsHtml = newElement.elementsHTML()
        document.getElementById('ajax-elements').innerHTML += newElementsHtml
      })
    }
  })
}

function listenForNewElementFormClick() {
  $('button#ajax-new-element').on('click', function(event) {
    event.preventDefault()
    let newElementForm = Element.newElementForm()
    // $('div#new-element-form-div')
    document.querySelector('div#new-element-form-div').innerHTML = newElementForm
  })
}

class Element {
  constructor(element) {
    this.id = element.id
    this.e_name = element.e_name
    this.tempo = element.tempo
    this.key = element.key
    this.lyrics = element.lyrics
    this.learned = element.learned
    this.full_name = element.full_name
    this.songs = element.songs
    this.instruments = element.instruments
  }


}

Element.prototype.elementsHTML = function() {
  return (`
    <div class="element" data-id= "${this.id}">
      <p>${this.full_name}</p>
      <div id= element-${this.id}-details> </div>
      <button data-id= "${this.id}" class='element-data'> See more </button>
    </div>
    `)
}