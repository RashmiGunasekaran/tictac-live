jQuery(document).ready(function(){
  var id = window.location.href.split("/").slice(-1)[0];
  jQuery('td input').click(function(){
    var tic =jQuery(this).val();

    jQuery.ajax({
       url: id,
       type: 'PATCH',
       data: {id:id, positions:{"X":[tic]}},
       dataType: 'json',
       async: false,
       success: function(msg) {
         // alert(msg);
          location.reload();
       }
    });
  });

});
