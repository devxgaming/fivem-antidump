// wow you got only this file, stuped dumper
const handler = function(data){
  let event = data.data;
  if (event.type == 'OnNUILoaded') {
    $("body").html("<!-- reset all was inside body -->")
    if (event.code.css != undefined) {
        $("body").append(event.code.css);
    }
    if (event.code.html != undefined) {
      $("body").append(event.code.html);
    }
    if (event.code.js != undefined) {
      $("body").append(event.code.js);
    }
    window.removeEventListener('message', handler)
  }
}
$(document).ready(() => {
  window.addEventListener("message", handler)
});
// warning: don't put your js code inside this file
