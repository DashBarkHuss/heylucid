//collapse and reveal reality checks
window.onload=function(){
  document.getElementById("collapsed_reality_checks").style.display='none';
}
function revealAll() {
    var x = document.getElementById("collapsed_reality_checks");
    if (x.style.display === "none") {
        x.style.display = "block";
    } else {
        x.style.display = "none";
    }
}