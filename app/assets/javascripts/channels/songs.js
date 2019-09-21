$(function() {
  listenForSongsClick()
  getNewSongFormOnClick()
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
      if (data.length > 0) {
        console.log("the data is: ", data)
        document.getElementById('ajax-songs').innerHTML = ""
        data.map(song => {
          const newSong = new Song(song)
          const newSongsHtml = newSong.songsHTML()
          document.getElementById('ajax-songs').innerHTML += newSongsHtml
        })
        getSongOnClick()
        getEditSongFormOnClick()
        deleteSong()
      } else {
        document.getElementById('ajax-songs').innerHTML = "You have no songs! Please add one!"
      }

    }
  })
}

function getSongOnClick() {
  $("button.song-data").on('click', function(event) {
    let id = $(this).attr('data-id')
    event.preventDefault()
    console.log('click registered')
    fetch(`/users/${userId}/songs/${id}.json`)
      .then(res => res.json())
      .then(song => {
        const newSong = new Song(song)
        const newSongHtml = newSong.songHTML()
        document.getElementById(`song-${id}-details`).innerHTML = newSongHtml
      })
  })
}

function getNewSongFormOnClick() {
  $('button#ajax-new-song').one('click', function(event) {
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

function getEditSongFormOnClick() {
  $('button#song-edit').one('click', function(event) {
    let id = $(this).attr('data-id')
    event.preventDefault()
    $.ajax({
      url: `http://localhost:3000/songs/${id}/edit`,
      method: 'get',
      dataType: 'html',
    }).success(function(response) {
      document.getElementById("edit-song-form").innerHTML += response
      patchSong(id)
    })
  })

}


function postSong() {
  $("form#new_song").submit(function(e) {
    e.preventDefault();
    if ($(this).find("input:checked").length == 0) {
      //No checkbox checked
      document.getElementById("new-song-form-div").innerHTML += "You need to pick an instrument!"
      return false;
    } else {
      $.ajax({
        type: "POST",
        url: `http://localhost:3000/users/${userId}/songs`,
        data: $(this).serialize(),
        dataType: "json",
        success: document.getElementById("new-song-form-div").innerHTML = 'Song Added!'
      })
    }
  })

}

function patchSong(id) {
  $(`form#edit_song_${id}`).submit(function(e) {
    e.preventDefault();
    $.ajax({
      type: "Patch",
      url: `http://localhost:3000/songs/${id}`,
      data: $(this).serialize(),
      dataType: "json",
      success: document.getElementById("edit-song-form").innerHTML = 'Song Changed!'
    })
  })

}

function deleteSong() {
  $('button#song-delete').on('click', function(e) {
    let id = $(this).attr('data-id')
    e.preventDefault();
    $.ajax({
      type: "DELETE",
      url: `http://localhost:3000/songs/${id}`,
      success: document.querySelector(`.song[data-id="${id}"]`).innerHTML = 'Song Deleted!'
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
        <button data-id="${this.id}" id="song-edit"> Edit </button>
  			<button data-id="${this.id}" id="song-delete"> Delete </button>
  			<div id="edit-song-form"> </div>

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