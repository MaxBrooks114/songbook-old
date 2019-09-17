$(function() {
  listenForElementsClick()
  getNewElementFormOnClick()
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
        getElementOnClick()
      })
    }
  })
}

function getElementOnClick() {
  $("button.element-data").one('click', function(event) {
    let id = $(this).attr('data-id')
    event.preventDefault()
    console.log('click registered')
    fetch(`/users/${userId}/elements/${id}.json`)
      .then(res => res.json())
      .then(element => {
        const newElement = new Element(element)
        const newElementHtml = newElement.elementHTML()
        document.getElementById(`element-${id}-details`).innerHTML += newElementHtml
      })
  })
}

function getNewElementFormOnClick() {
  $('button#ajax-new-element').on('click', function(event) {
    event.preventDefault()
    $.ajax({
      url: `http://localhost:3000/users/${userId}/elements/new`,
      method: 'get',
      dataType: 'html',
    }).success(function(response) {
      document.getElementById("new-element-form-div").innerHTML += response
      // postElement()
    })
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

Element.prototype.elementHTML = function() {
  return (`
		<p> Tempo: ${this.tempo} </p>
		<p> key: ${this.key} </p>
		<p> Learned: ${this.learned} </p>
		<p> Lyrics: ${this.lyrics} </p>
		`)
}