$(function() {
  listenForInstrumentsClick()
  getNewInstrumentFormOnClick()
});

function listenForInstrumentsClick() {
  $('button#instruments-data').on('click', function(event) {
    event.preventDefault()
    getInstruments()
  })
}



function getInstruments() {
  $.ajax({
    url: `http://localhost:3000/users/${userId}/instruments`,
    method: 'get',
    dataType: 'json',
    success: function(data) {
      if (data.length > 0) {
        console.log("the data is: ", data)
        document.getElementById('ajax-instruments').innerHTML = ""
        data.map(instrument => {
          const newInstrument = new Instrument(instrument)
          const newInstrumentsHtml = newInstrument.instrumentsHTML();
          document.getElementById('ajax-instruments').innerHTML += newInstrumentsHtml
        })
        getInstrumentOnClick()
        getEditInstrumentFormOnClick()
        deleteInstrument()
      } else {
        document.getElementById('ajax-instruments').innerHTML = "You have no instruments please add one!"
      }

    }
  })

}




function getInstrumentOnClick() {
  $("button.instrument-data").on('click', function(event) {
    let id = $(this).attr('data-id')
    event.preventDefault()
    console.log('click registered')
    fetch(`/users/${userId}/instruments/${id}.json`)
      .then(res => res.json())
      .then(instrument => {
        const newInstrument = new Instrument(instrument)
        const newInstrumentHtml = newInstrument.instrumentHTML()
        document.getElementById(`instrument-${id}-details`).innerHTML = newInstrumentHtml
      })
  })
}





function getNewInstrumentFormOnClick() {
  $('button#ajax-new-instrument').on('click', function(event) {
    event.preventDefault()
    $.ajax({
      url: `http://localhost:3000/users/${userId}/instruments/new`,
      method: 'get',
      dataType: 'html',
    }).success(function(response) {
      document.getElementById("new-instrument-form-div").innerHTML += response
      postInstrument()
    })
  })

}

function getEditInstrumentFormOnClick(id) {
  $("button#instrument-edit").one('click', function(event) {
    let id = $(this).attr('data-id')
    event.preventDefault()
    $.ajax({
      url: `http://localhost:3000/users/${userId}/instruments/${id}/edit`,
      method: 'get',
      dataType: 'html',
    }).success(function(response) {
      document.getElementById("edit-instrument-form").innerHTML += response
      patchInstrument(id)
    })
  })

}




function postInstrument() {
  $("form#new_instrument").submit(function(e) {
    e.preventDefault();
    let formData = new FormData(document.getElementById("new_instrument"));
    $.ajax({
      type: "POST",
      url: `http://localhost:3000/users/${userId}/instruments`,
      data: formData,
      contentType: false,
      processData: false,
      success: document.getElementById("new-instrument-form-div").innerHTML = 'Instrument Added!'
    })

  })

}

function patchInstrument(id) {
  $(`form#edit_instrument_${id}`).submit(function(e) {
    e.preventDefault();
    $.ajax({
      type: "Patch",
      url: `http://localhost:3000/users/${userId}/instruments/${id}`,
      data: $(this).serialize(),
      dataType: "json",
      success: document.getElementById("edit-instrument-form").innerHTML = 'Instrument Changed!'
    })
  })

}

function deleteInstrument() {
  $('button#instrument-delete').on('click', function(e) {
    let id = $(this).attr('data-id')
    e.preventDefault();
    $.ajax({
      type: "DELETE",
      url: `http://localhost:3000/users/${userId}/instruments/${id}`,
      success: document.querySelector(`.instrument[data-id="${id}"]`).innerHTML = 'Instrument Deleted!'
    })
  })

}

class Instrument {
  constructor(instrument) {
    this.id = instrument.id
    this.i_name = instrument.i_name
    this.make = instrument.make
    this.model = instrument.model
    this.range = instrument.range
    this.family = instrument.family
    this.elements = instrument.elements
    this.songs = instrument.songs
    this.display_name = instrument.display_name
    this.picture = instrument.picture
  }



}

Instrument.prototype.instrumentsHTML = function() {
  return (`
    <div class="instrument" data-id= "${this.id}">
      <p>${this.display_name}</p>
      <div id= instrument-${this.id}-details> </div>
      <button data-id= "${this.id}" class='instrument-data'> See more </button>
      <button data-id="${this.id}" id="instrument-edit"> Edit </button>
			<button data-id="${this.id}" id="instrument-delete"> Delete </button>
      <div id="edit-instrument-form"> </div>
    </div>
    `)
}



Instrument.prototype.instrumentHTML = function() {
  let instrumentSongs = this.songs.map(song => {
    return (`
			<li>${song.title}</li>
		`)
  }).join('')
  let instrumentElements = this.elements.map(element => {
    return (`
      <li>${element.full_name}</li>
    `)
  }).join('')
  if (this.picture !== null) {
    return (`

			<p> Range: ${this.range}</p>
      <p> Family: ${this.family}</p>
      <img src= "${this.picture}" />
      <ul> Songs: ${instrumentSongs}</ul>
      <ul> Elements: ${instrumentElements} </ul>


	`)
  } else {
    return (`

      <p> Range: ${this.range}</p>
      <p> Family: ${this.family}</p>
      <ul> Songs: ${instrumentSongs}</ul>
      <ul> Elements: ${instrumentElements} </ul>


  `)
  }
}