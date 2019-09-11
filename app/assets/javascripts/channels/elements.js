$(function () {
	listenForElementsClick()
	listenForNewElementFormClick()
});

function listenForElementsClick() {
	$('button#elements-data').one('click', function (event) {
		event.preventDefault()
		getElements()
	})
}

function getElements() {
	$.ajax({
		url: 'http://localhost:3000/users/1/elements',
		method: 'get',
		dataType: 'json',
		success: function (data) {
			console.log("the data is: ", data)
			data.map(element => {
				const newElement = new Element(element)
				const newElementHtml = newElement.elementHTML()
				document.getElementById('ajax-elements').innerHTML += newElementHtml
			})
		}
	})
}

function listenForNewElementFormClick() {
	$('button#ajax-new-element').on('click', function (event) {
		event.preventDefault()
		let newElementForm = Element.newElementForm()
		// $('div#new-element-form-div')
		document.querySelector('div#new-element-form-div').innerHTML = newElementForm
	})
}

class Element {
	constructor(obj) {
		this.id = obj.id
		this.e_name = obj.e_name
    this.tempo = obj.tempo
    this.key = obj.key
		this.lyrics= obj.lyrics
		this.learned = obj.learned
    this.full_name = obj.full_name
    this.songs = obj.songs
    this.instruments = obj.instruments
	}

	static newElementForm() {
		return (`
		<strong>New element comment form</strong>
			<form>
				<input id='element-title' type='text' name='title'></input><br>
				<input type='text' name='content'></input><br>
				<input type='submit' />
			</form>
		`)
	}
}

Element.prototype.elementHTML = function () {
	return (`
		<div class='element'>
			<p>${this.full_name} <p>

		</div>
	`)
}
