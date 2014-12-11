var tipsyClientSideValidations = function(){
	$("input.user_password").tipsy({gravity: 'n', fade: true, fallback: "Use at least 6 characters. Include an upper and a lower case letter as well as a number."})
}

$(document).ready(function($) {
  $('#accordion').on("click", '.accordion-toggle', function(){
    //Expand or collapse this panel
    $(this).next().slideToggle('fast');
    //Hide the other panels
    $(".accordion-content").not($(this).next()).slideUp('fast');
  });

  tipsyClientSideValidations();
});
