$(function () {
	listenForSongsClick()
	listenForNewSongFormClick()
});

function listenForSongsClick() {
	$('button#songs-data').one('click', function (event) {
		event.preventDefault()
		getSongs()
	})
}

function getSongs() {
	$.ajax({
		url: 'http://localhost:3000/users/1/songs',
		method: 'get',
		dataType: 'json',
		success: function (data) {
			console.log("the data is: ", data)
			data.map(song => {
				const newSong = new Song(song)
				const newSongHtml = newSong.songHTML()
				document.getElementById('ajax-songs').innerHTML += newSongHtml
			})
		}
	})
}

function listenForNewSongFormClick() {
	$('button#ajax-new-song').on('click', function (event) {
		event.preventDefault()
		let newSongForm = Song.newSongForm()
		// $('div#new-song-form-div')
		document.querySelector('div#new-song-form-div').innerHTML = newSongForm
	})
}

class Song {
	constructor(obj) {
		this.id = obj.id
		this.title= obj.title
    this.artist = obj.artist
    this.genre = obj.genre
    this.album= obj.lyrics
    this.lyrics = obj.lyrics
		this.elements = obj.elements
		this.instruments = obj.instruments
	}

	static newSongForm() {
		return (`
		<strong>New song comment form</strong>
			<form>
				<input id='song-title' type='text' name='title'></input><br>
				<input type='text' name='content'></input><br>
				<input type='submit' />
			</form>
		`)
	}
}

Song.prototype.songHTML = function () {
	let songInstruments = this.instruments.map(instrument => {
		return (`
			<p>${instrument.display_name}</p>
		`)
	}).join('')
  let songElements = this.elements.map(element => {
    return (`
      <p>${element.full_name}</p>
    `)
  }).join('')
	return (`
		<div class='song'>
			<p>${this.title} Instruments: ${songInstruments} Elements: ${songElements} <p>

		</div>
	`)
}
