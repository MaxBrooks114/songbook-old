$(function () {
	listenForInstrumentsClick()
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
		url: 'http://localhost:3000/users/1/instruments',
		method: 'get',
		dataType: 'json',
		success: function (data) {
			console.log("the data is: ", data)
			data.map(instrument => {
				const newInstrument = new Instrument(instrument)
				const newInstrumentHtml = newInstrument.instrumentHTML()
				document.getElementById('ajax-instruments').innerHTML += newInstrumentHtml
			})
		}
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
		this.elements = obj.elements
		this.songs = obj.songs
    this.display_name = obj.display_name
	}

	static newInstrumentForm() {
		return (`
		<strong>New instrument comment form</strong>
			<form>
				<input id='instrument-title' type='text' name='title'></input><br>
				<input type='text' name='content'></input><br>
				<input type='submit' />
			</form>
		`)
	}
}

Instrument.prototype.instrumentHTML = function () {
	let instrumentSongs = this.songs.map(song => {
		return (`
			<p>${song.title}</p>
		`)
	}).join('')
  let instrumentElements = this.elements.map(element => {
    return (`
      <p>${element.full_name}</p>
    `)
  }).join('')
	return (`
		<div class='instrument'>
			<p>${this.display_name}) Songs: ${instrumentSongs} Elements: ${instrumentElements} <p>

		</div>
	`)
}
