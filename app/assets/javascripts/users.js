/ Document ready, bind events
$(function() {
  console.log("Users document ready, let's get started ...");

  console.log("Binding events ...");
  $(".toggle-role").bind('click', toggleRole);
  console.log("Binding events done");
});

// Event bound functions
function toggleRole(event) {
  if (confirm("Toggle role?")) {
    console.log("This is where we toggle the role")
  });
};
