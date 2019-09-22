$(function() {
  listenForElementsClick()
  getNewElementFormOnClick()

});

function listenForElementsClick() {
  $('button#elements-data').on('click', function(event) {
    event.preventDefault()
    getElements()
  })
}

function clearContainer() {
  var children = document.getElementById('container').childNodes;
  children.forEach(function(node) {
    node.innerHTML = ''
  });
}

function getElements() {
  $.ajax({
    url: `http://localhost:3000/users/${userId}/elements`,
    method: 'get',
    dataType: 'json',
    success: function(data) {
      if (data.length > 0) {
        clearContainer()
        document.getElementById('ajax-elements').innerHTML = ""
        console.log("the data is: ", data)
        data.map(element => {
          const newElement = new Element(element)
          const newElementsHtml = newElement.elementsHTML()
          document.getElementById('ajax-elements').innerHTML += newElementsHtml

        })
        getElementOnClick()
        getEditElementFormOnClick()
        deleteElement()
      } else {
        clearContainer()
        document.getElementById('ajax-elements').innerHTML = "You have no elements! please add one."
      }
    }
  })
}



function getElementOnClick() {
  $("button.element-data").on('click', function(event) {
    let id = $(this).attr('data-id')
    event.preventDefault()
    console.log('click registered')
    fetch(`/users/${userId}/elements/${id}.json`)
      .then(res => res.json())
      .then(element => {
        const newElement = new Element(element)
        const newElementHtml = newElement.elementHTML()
        document.getElementById(`element-${id}-details`).innerHTML = newElementHtml

      })
  })
}

function getNewElementFormOnClick() {
  $('button#ajax-new-element').on('click', function(event) {
    let id = $(this).attr('data-id')
    event.preventDefault()
    $.ajax({
      url: `http://localhost:3000/users/${userId}/elements/new`,
      method: 'get',
      dataType: 'html',
      statusCode: {
        500: function() {
          alert("you need to have at least one song and one instrument added before you add an element ")
        }
      },
      success: function(response) {
        clearContainer()
        document.getElementById("new-element-form-div").innerHTML += response
        postElement()
      }
    })
  })

}

function getEditElementFormOnClick() {
  $('button#element-edit').one('click', function(event) {
    let id = $(this).attr('data-id')
    event.preventDefault()
    $.ajax({
      url: `http://localhost:3000/elements/${id}/edit`,
      method: 'get',
      dataType: 'html',
      success: (function(response) {
        clearContainer()
        document.getElementById("edit-element-form").innerHTML += response
        patchElement(id)
      })
    })
  })

}

function patchElement(id) {
  $(`form#edit_element_${id}`).submit(function(e) {
    e.preventDefault();
    let formData = new FormData(document.getElementById(`edit_element_${id}`));
    $.ajax({
      type: "Patch",
      url: `http://localhost:3000/elements/${id}`,
      data: formData,
      contentType: false,
      processData: false,
      success: document.getElementById("edit-element-form").innerHTML = 'Element Changed!'
    })

  })

}


function postElement() {
  $("form#new_element").submit(function(e) {
    e.preventDefault();
    let formData = new FormData(document.getElementById("new_element"));
    $.ajax({
      type: "POST",
      url: `http://localhost:3000/users/${userId}/elements`,
      data: formData,
      contentType: false,
      processData: false,
      success: document.getElementById("new-element-form-div").innerHTML = 'Element Added!'
    })

  })
}

function deleteElement() {
  $('button#element-delete').on('click', function(e) {
    let id = $(this).attr('data-id')
    e.preventDefault();
    $.ajax({
      type: "DELETE",
      url: `http://localhost:3000/elements/${id}`,
      success: document.querySelector(`.element[data-id="${id}"]`).innerHTML = 'Element Deleted!'
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
    this.sheet_music = element.sheet_music
    this.recording = element.recording
  }


}

Element.prototype.elementsHTML = function() {
  return (`
    <div class="element" data-id= "${this.id}">
      <p>${this.full_name}</p>
      <div id= element-${this.id}-details> </div>
      <button data-id= "${this.id}" class='element-data'> See more </button>
			<button data-id="${this.id}" id="element-edit"> Edit </button>
			<button data-id="${this.id}" id="element-delete"> Delete </button>
			<div id="edit-element-form"> </div>

    </div>
    `)
}

Element.prototype.elementHTML = function() {
  return (`
		<p> Tempo: ${this.tempo} </p>
		<p> key: ${this.key} </p>
		<p> Learned: ${this.learned} </p>
    <script> if (this.sheet_music !== null){
    <img src="${this.sheet_music}"/>}</script>
    <script> if (this.recording !== null){
    <audio controls="controls" src = ${this.recording}></audio>}</script>
		<p> Lyrics: ${this.lyrics} </p>
		`)
}