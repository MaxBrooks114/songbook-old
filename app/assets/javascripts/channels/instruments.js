$(function () {
	listenForInstrumentsClick()
  listenForInstrumentClick()
	listenForNewInstrumentFormClick()
});

function listenForInstrumentsClick() {
	$('button#instruments-data').one('click', function (event) {
		event.preventDefault()
		getInstruments()
	})
}


function getInstruments() {
	$.ajax({
		url: `http://localhost:3000/users/${userId}/instruments`,
		method: 'get',
		dataType: 'json',
		success: function (data) {
			console.log("the data is: ", data)
			data.map(instrument => {
				const newInstrument = new Instrument(instrument)
				const newInstrumentsHtml = newInstrument.instrumentsHTML()
				document.getElementById('ajax-instruments').innerHTML += newInstrumentsHtml
        listenForInstrumentClick()
        })
      }
	})

}



function listenForInstrumentClick() {
	$("button.instrument-data").one('click', function (event) {
    debugger
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





function listenForNewInstrumentFormClick() {
	$('button#ajax-new-instrument').on('click', function (event) {
		event.preventDefault()
		let newInstrumentForm = Instrument.newInstrumentForm()
		// $('div#new-instrument-form-div')
		document.querySelector('div#new-instrument-form-div').innerHTML = newInstrumentForm
	})
}

class Instrument {
	constructor(obj) {
		this.id = obj.id
		this.i_name = obj.i_name
    this.make = obj.make
    this.model = obj.model
    this.range = obj.range
    this.family = obj.family
		this.elements = obj.elements
		this.songs = obj.songs
    this.display_name = obj.display_name
	}

	static newInstrumentForm() {
		return (`
		<strong>New instrument form</strong>
			<form action = "/users/${userId}/instruments" method= "post">
        <input type='text' name='instrument-i_name' placeholder="Instrument"></input><br>
        <input type='text' name='instrument-make' placeholder="Make"></input><br>
        <input type='text' name='instrument-make' placeholder="Model"></input><br>
				<p> Family: <select id='instrument-family' name='instrument-family' placeholder="family">
            <option value="Brass">Brass</option>
            <option value="String">String</option>
            <option value="Woodwind">Woodwind</option>
            <option value="Percussion">Percussion</option>
            <option value="Other">Other</option>
        </select></p>
        <p> Range: <select id='instrument-range' name='instrument-i_name' placeholder="range">
            <option value ="Soprano">Soprano</option>
            <option value="Alto">Alto</option>
            <option value="Tenor">Tenor</option>
            <option value="Baritone">Baritone</option>
            <option value= "N/A">NA</option>
        </select></p>
				<input type='submit' />
			</form>
		`)
	}
}
Instrument.prototype.instrumentsHTML = function () {
  return (`
    <div class="instrument" data-id= "${this.id}">
      <p>${this.display_name}</p>
      <div id= instrument-${this.id}-details> </div>
      <button data-id= "${this.id}" class='instrument-data'> See more </button>
    </div>
    `)
  }



Instrument.prototype.instrumentHTML = function () {
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
