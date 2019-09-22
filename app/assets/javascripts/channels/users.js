$(function() {
  getStatsOnClick()
});

function getStatsOnClick() {
  $('button#stats-data').on('click', function(event) {
    event.preventDefault()
    $.ajax({
      url: `http://localhost:3000/users/${userId}/stats`,
      method: 'get',
      dataType: 'html',
    }).success(function(response) {
      clearContainer()
      document.getElementById("ajax-stats").innerHTML = response
    })
  })

}