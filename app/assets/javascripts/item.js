var dateAuto = function() {
  $("input#item_prototype_name").focusout(function() {
    if ($(this).val() != "" ) {
      term = $(this).val().trim();
      $.post("/autocomplete_date/"+ term, function(response) {
        console.log(response)
        $("input#item_expiration_date").val(response['date']);
      })
    }
  })
};

$(function(){
  console.log("loaded");
  $(document).on("click", "[id^='new_item_button']", function(e){
    e.preventDefault();
    console.log(this);
    var index = this.id.replace("new_item_button", "");
    console.log(index);
    $("#new_item_button" + index).hide();
    $("#new_item" + index).show();
    $("#cancel_new_item_button" + index).show();
    dateAuto();
  });

  $(document).on("click", "[id^='cancel_new_item_button']", function(e){
    e.preventDefault();
    var index = this.id.replace("cancel_new_item_button", "");
    $("#new_item_button" + index).show();
    $("#new_item" + index).hide();
    $("#cancel_new_item_button" + index).hide();
  });

  $(document).on("ajax:complete", "a.item-delete", function(event){
    var item = $(event.target);
    console.log(item);
    var row = item.closest("tr");
    row.remove();
  });

  $(document).on("ajax:complete", "[id^='new_item']", function(event, data, status, xhr){
    console.log(data.responseText);
    var index = this.id.replace("new_item", "");
    $("#item-block" + index).html(data.responseText);
    $(this).hide();
    $("#new_item_button" + index).show();
    $("#cancel_new_item_button" + index).hide();
    console.log($(".new_item"))
    $.each($(".new_item"), function(index, value){
      value.reset();
    });
  });


});
