var areaMap;
$(document).ready(new function() {
  $.get('/front/addresses/supportshipments.json', function(result) {
    areaMap = result.datas;
  });

  $('#add_address').click(function() {
    // $('#add01 form input[type=text]').each(function(i,e) { $(e).val(''); });
    // $('#add01 form select').each(function(i,e) { $(e).val(''); });
    // $('#add01 div.messages .close').click();
  });

  $('#add01 form').bind('ajax:success', function(evt, data, status, xhr){
    if (data.isSuccessful) {
      $('#add01 div.messages').html('<div class="alert alert-success"><a class="close" data-dismiss="alert" href="#">x</a>' + data.message + '</div>');
      document.location.reload();
    }
    else {
      $('#add01 div.messages').html('<div class="alert alert-error"><a class="close" data-dismiss="alert" href="#">x</a>' + data.message + '</div>');
    }
  })

  $('a[data-address-id]').bind('ajax:success', function(evt, data, status, xhr){
    var target = $(evt.currentTarget);
    if (data.isSuccessful) {
      target.parents('div.modal').modal('hide');
      target.parents('form').remove();
      $('#messages').html('<div class="alert alert-success"><a class="close" data-dismiss="alert" href="#">x</a>' + data.message + '</div>');
    }
    else
    {
      target.parents('div.modal').modal('hide');
      $('#messages').html('<div class="alert alert-error"><a class="close" data-dismiss="alert" href="#">x</a>' + data.message + '</div>');
    }
  });
});
