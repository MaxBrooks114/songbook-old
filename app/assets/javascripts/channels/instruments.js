$(function() {
  listenForInstrumentsClick()
  getNewInstrumentFormOnClick()
});

function listenForInstrumentsClick() {
  $('button#instruments-data').one('click', function(event) {
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
      console.log("the data is: ", data)
      data.map(instrument => {
        const newInstrument = new Instrument(instrument)
        const newInstrumentsHtml = newInstrument.instrumentsHTML()
        document.getElementById('ajax-instruments').innerHTML += newInstrumentsHtml
        getInstrumentOnClick()
      })
    }
  })

}




function getInstrumentOnClick() {
  $("button.instrument-data").one('click', function(event) {
    let id = $(this).attr('data-id')
    event.preventDefault()
    console.log('click registered')
    fetch(`/users/${userId}/instruments/${id}.json`)
      .then(res => res.json())
      .then(instrument => {
        const newInstrument = new Instrument(instrument)
        const newInstrumentHtml = newInstrument.instrumentHTML()
        document.getElementById(`instrument-${id}-details`).innerHTML += newInstrumentHtml
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


function postInstrument() {
  $("form#new_instrument").submit(function(e) {
    e.preventDefault();
    $.ajax({
      type: "POST",
      url: `http://localhost:3000/users/${userId}/instruments`,
      data: $(this).serialize(),
      dataType: "json",
      success: document.getElementById("new-instrument-form-div").innerHTML = 'Instrument Added!'
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
  }



}

Instrument.prototype.instrumentsHTML = function() {
  return (`
    <div class="instrument" data-id= "${this.id}">
      <p>${this.display_name}</p>
      <div id= instrument-${this.id}-details> </div>
      <button data-id= "${this.id}" class='instrument-data'> See more </button>
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
  return (`

			<p> Range: ${this.range}</p>
      <p> Family: ${this.family}</p>
      <ul> Songs: ${instrumentSongs}</ul>
      <ul> Elements: ${instrumentElements} </ul>

	`)
}