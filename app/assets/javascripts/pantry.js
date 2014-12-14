var tipsyPantryIcons = function(){
  $("[id^='edit_pantry_button']").tipsy({gravity: "s", fallback: "Pantry Settings"});
  $("[id^='new_item_button']").tipsy({gravity: "s", fallback: "Add Item"});
  $("[id^='new_invite_button']").tipsy({gravity: "s", fallback: "Invite to Pantry"});
  $(".opt-out").tipsy({gravity: "s", fallback: "Leave Pantry"});
  $("i.fa.fa-cutlery.fa-2x").tipsy({gravity: "s", fallback: "Find Recipes"});
}

var toggleCreatePantrybutton =  function(){
  var $formButton = $('#new_pantry input[type="submit"]')
  var $formText = $('#new_pantry input[type="text"]')
  
  $formButton.attr('disabled',true);
  $formText.keyup(function() {
    if($(this).val() != '') {
      $formButton.attr('disabled', false);
    }
    else{
      $formButton.attr('disabled', true);
    }
  });
}

$(function(){
  tipsyPantryIcons();
  toggleCreatePantrybutton();

  $('#accordion').on("click", "[id^='edit_pantry_button']", function(e){
    e.preventDefault();
    console.log(this);
    var index = this.id.replace("edit_pantry_button", "");
    $("#edit_pantry_button" + index).hide();
    $("#edit_pantry" + index).show();
    $("#cancel_edit_pantry_button" + index).show();
  });

  $('#accordion').on("click", "[id^='cancel_edit_pantry_button']", function(e){
    e.preventDefault();
    console.log(this);
    var index = this.id.replace("cancel_edit_pantry_button", "");
    $("#edit_pantry_button" + index).show();
    $("#edit_pantry" + index).hide();
    $("#cancel_edit_pantry_button" + index).hide();
  });

  $(document).on("ajax:complete", "[id^='edit_pantry']", function(event, data, status, xhr) {
    console.log(event.target);
    var index = this.id.replace("edit_pantry", "");
    console.log(index);
    $("#pantry" + index).remove();
    console.log(data.responseText);
    $("#creator_pantries").append(data.responseText);
    $("#edit_pantry" + index).hide();
    $("#edit_pantry_button" + index).show();
    $("#cancel_edit_pantry_button" + index).hide();
  });

  $(document).on("click", "#new_pantry_button", function(e){
    e.preventDefault();
    $("#new_pantry_button").hide();
    $("#new_pantry").show();
    $("#cancel_new_pantry_button").show();
  });

  $(document).on("click", "#cancel_new_pantry_button", function(e){
    e.preventDefault();
    console.log(this);
    $("#new_pantry_button").show();
    $("#new_pantry").hide();
    $("#cancel_new_pantry_button").hide();
  });

  $(document).on("ajax:complete", "#new_pantry", function(event, data, status, xhr) {
    $("#creator_pantries").append(data.responseText);
    $("#new_pantry").hide();
    $("#new_pantry_button").show();
    $("#cancel_new_pantry_button").hide();
    $(".new_pantry")[0].reset();
    tipsyPantryIcons();
    toggleCreatePantrybutton();
  });

  $(document).on("ajax:complete", "[id^='pantry_delete_button']", function(event, data, status, xhr){
    var index = this.id.replace("pantry_delete_button", "");
    $("#pantry" + index).remove();
  });

  $(document).on("ajax:complete", "[id^='opt_out_button']", function(event, data, status, xhr){
    var index = this.id.replace("opt_out_button", "");
    console.log(index);
    $("#pantry" + index).remove();
  });

  $('#accordion').on("click", "[id^='new_invite_button']", function(e){
    e.preventDefault();
    console.log(this);
    var index = this.id.replace("new_invite_button", "");
    console.log(index);
    $("#new_invite_button" + index).hide();
    $("#new_invite" + index).show();
    $("#cancel_new_invite_button" + index).show();
  });

  $('#accordion').on("click", "[id^='cancel_new_invite_button']", function(e){
    e.preventDefault();
    console.log(this);
    var index = this.id.replace("cancel_new_invite_button", "");
    console.log(index);
    $("#new_invite_button" + index).show();
    $("#new_invite" + index).hide();
    $("#cancel_new_invite_button" + index).hide();
  });

  $(document).on("ajax:complete", "[id^='new_invite']", function(event, data, status, xhr){
    var index = this.id.replace("new_invite", "");
    console.log(index);
    $("#new_invite_button" + index).show();
    $("#new_invite" + index).hide();
    $("#cancel_new_invite_button" + index).hide();

    $.each($(".new_invite"), function(index, value){
      value.reset();
    });
  });
});

