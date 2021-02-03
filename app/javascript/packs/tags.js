$(document).on("turbolinks:load", function() {
  if ($('.selectize')){
      $('.selectize').selectize({
          sortField: 'text'
      });
  }

  $(".selectize-tags").selectize({
    create: function(input, callback) {
      $.post('/tags.json', { tag: { name: input } })
        .done(function(response){
          console.log(response)
          callback({value: response.id, text: response.name });
        })
    }
  });
});