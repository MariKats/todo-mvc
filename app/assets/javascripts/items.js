function Item(attributes) {
  this.description = attributes.description;
  this.id = attributes.id;
}

Item.prototype.renderLi = function() {
  return Item.template(this);
};

Item.prototype.$li = function() {
  return $("li#item_" + this.id);
};

Item.prototype.destroy = function() {
  this.$li().remove();
};

Item.success = function(json) {
  var item = new Item(json);
  var itemLi = item.renderLi();
  $("ul.todo-list").append(itemLi);
  $("input.new-todo").val("");
  location.reload();
};

Item.destroy = function(json) {
  var item = new Item(json);
  item.destroy();
};

Item.error = function(response) {
  console.log("Yu broke it?", response.statusText);
};

Item.formSubmit = function(event) {
  event.preventDefault();
  var $form = $(this);
  var action = $form.attr("Action");
  var params = $form.serialize();

  $.ajax({
    url: action,
    data: params,
    method: "POST",
    dataType: "json"
  })
    .success(Item.success)
    .error(Item.error);
};

Item.formSubmitListener = function() {
  $("form#new_item").on("submit", Item.formSubmit);
};

Item.destroyListener = function() {
  $("ul.todo-list").on("click", "input.destroy", function(event) {
    event.preventDefault();
    var $form = $(this).parent("form");
    var action = $form.attr("Action");
    var params = $form.serialize();
    $.ajax({
      url: action,
      data: params,
      method: "DELETE",
      dataType: "json"
    })
      .success(Item.destroy)
      .error(Item.error);
  });
};

Item.ready = function() {
  Item.templateSource = $("#item-template").html();
  Item.template = Handlebars.compile(Item.templateSource);
  Item.formSubmitListener();
  Item.destroyListener();
};

$(function() {
  Item.ready();
});
