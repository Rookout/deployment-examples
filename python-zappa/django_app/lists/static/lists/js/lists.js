$(document).ready(function() {
  $(':checkbox').on('click', changeTodoStatus);
});

function changeTodoStatus() {
  putNewStatus(this.getAttribute('data-todo-id'), $(this).is(':checked'));
}

function csrfSafeMethod(method) {
  // these HTTP methods do not require CSRF protection
  return (/^(GET|HEAD|OPTIONS|TRACE)$/.test(method));
}

// function from the django docs
function getCookie(name) {
  var cookieValue = null;
  if (document.cookie && document.cookie != '') {
    var cookies = document.cookie.split(';');
    for (var i = 0; i < cookies.length; i++) {
      var cookie = jQuery.trim(cookies[i]);
      // Does this cookie string begin with the name we want?
      if (cookie.substring(0, name.length + 1) == (name + '=')) {
        cookieValue = decodeURIComponent(
          cookie.substring(name.length + 1)
        );
        break;
      }
    }
  }
  return cookieValue;
}

function putNewStatus(todoID, isFinished) {
  // setup ajax to csrf token
  var csrftoken = getCookie('csrftoken');
  $.ajaxSetup({
    beforeSend: function(xhr, settings) {
      if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
        xhr.setRequestHeader("X-CSRFToken", csrftoken);
      }
    }
  });
  // send put request using the data of the get for the same id
  var todoURL = '/api/todos/' + todoID + '/'
  $.getJSON(todoURL, function(data) {
    data.is_finished = isFinished;
    if (isFinished) {
      data.finished_at = moment().toISOString();
    } else {
      data.finished_at = null;
    }
    $.ajax({
      url: todoURL,
      type: 'PUT',
      contentType: 'application/json',
      data: JSON.stringify(data),
      success: function() {
        location.reload();
      }
    });
  });
}
