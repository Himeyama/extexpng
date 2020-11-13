function plain2html(){
    let e = document.getElementById("plain");
    e.innerHTML = e.innerHTML.replace(/\r?\n/g, "<br>")
}
plain2html()