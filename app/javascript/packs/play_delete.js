jQuery(document).ready(function(){
      var id = window.location.href.split("/").slice(-1)[0];
      jQuery('.rematch').click(function(){
        jQuery.ajax({
          url: id,
          type: 'DELETE',
          data: {id: id},
          dataType: 'json',
          async: false,
          success: function(msg){
            alert(msg);
          }
        });
      });
    });
