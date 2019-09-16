$(function() {
  listenForSongsClick()
  listenForNewSongFormClick()
});

function listenForSongsClick() {
  $('button#songs-data').one('click', function(event) {
    event.preventDefault()
    getSongs()
  })
}


function getSongs() {
  $.ajax({
    url: `http://localhost:3000/users/${userId}/songs`,
    method: 'get',
    dataType: 'json',
    success: function(data) {
      console.log("the data is: ", data)
      data.map(song => {
        const newSong = new Song(song)
        const newSongsHtml = newSong.songsHTML()
        document.getElementById('ajax-songs').innerHTML += newSongsHtml
        getSongOnClick()
      })
    }
  })
}

function getSongOnClick() {
  $("button.song-data").one('click', function(event) {
    let id = $(this).attr('data-id')
    event.preventDefault()
    console.log('click registered')
    fetch(`/users/${userId}/songs/${id}.json`)
      .then(res => res.json())
      .then(song => {
        const newSong = new Song(song)
        const newSongHtml = newSong.songHTML()
        document.getElementById(`song-${id}-details`).innerHTML += newSongHtml
      })
  })
}

function listenForNewSongFormClick() {
  $('button#ajax-new-song').on('click', function(event) {
    event.preventDefault()
    $.ajax({
      url: `http://localhost:3000/users/${userId}/songs/new`,
      method: 'get',
      dataType: 'html',
    }).success(function(response) {
      document.getElementById("new-song-form-div").innerHTML += response
      postSong()
    })
  })

}


function postSong() {
  $("form").submit(function(e) {
    e.preventDefault();
    $.ajax({
      type: "POST",
      url: `http://localhost:3000/users/${userId}/songs`,
      data: $(this).serialize(),
      dataType: "json",
      success: document.getElementById("new-song-form-div").innerHTML = 'Song Added!'
    })
  })

}



class Song {
  constructor(song) {
    this.id = song.id
    this.title = song.title
    this.artist = song.artist
    this.genre = song.genre
    this.album = song.lyrics
    this.lyrics = song.lyrics
    this.instruments = song.instruments
    this.elements = song.elements
  }





}

Song.prototype.songsHTML = function() {
  return (`
     <div class="song" data-id= "${this.id}">
          <p>${this.title} (${this.artist})</p>
        <div id= "song-${this.id}-details"> </div>
        <button data-id= "${this.id}" class='song-data'> See more </button>
      </div>
    `

  )
}

Song.prototype.songHTML = function() {
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
			<p>Album: ${this.album}</p>
      <p>Genre: ${this.genre}</p>
      <p>Lyrics: ${this.lyrics}</p>
      <p>Instruments: ${songInstruments}</p>
      <p>Elements: ${songElements}</p>
	`)
}