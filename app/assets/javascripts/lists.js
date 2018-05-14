function listFormSubmit(){
  $("input.toggle").on("change", function(){
    $(this).parents("form").trigger("submit")
  })
}

function destroyListener(){
  $("ul.todo-list").on("click", "input.destroy.index", function(event){
    event.preventDefault()
    var $form = $(this).parent("form");
    var action = $form.attr("Action");
    var params = $form.serialize();
    $.ajax({
      url: action,
      data: params,
      method: "DELETE",
      dataType: "json"
    })
    .done(function(json){
      $("li.list_" + json.id).remove();
    })
    .fail(function(response){
      console.log("broke it?", response.statusText)
    })
  })
}

$(function(){
  listFormSubmit();
  destroyListener();
  console.log("ready")
});
