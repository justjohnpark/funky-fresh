$(document).ready(function() {
  $(document).on("ajax:complete", "header li a.login", function(event,data){
    $(".body_container").html(data.responseText);
  });

  $(document).on("ajax:complete", "header li a.register", function(event,data){
    $(".body_container").html(data.responseText);
  });

  $(document).on("ajax:complete", "header li a.home", function(event,data){
    $(".body_container").html(data.responseText);
  });

  $('a[rel=tipsy]').tipsy({fade: true, gravity: 'n'});

  $('#home').tipsy({fallback: "Home"});
  $('#sign_up').tipsy({fallback: "Sign Up"});
  $('#login').tipsy({fallback: "Login"});
  $('#logout_button').tipsy({fallback: "Logout"});
  $('#kitchen').tipsy({fallback: "Pantries"});
  $('#edit_cog').tipsy({fallback: "Edit Profile"});
  $("[id^='edit_pantry']").tipsy({fallback: "Change Pantry Name"})
  $("[id^='new_item']").tipsy({fallback: "Add Item"})
  $("[id^='new_invite']").tipsy({fallback: "Invite to Pantry"})
  $(".cookbook").tipsy({fallback: "Find Recipes"})



});
