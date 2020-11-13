function preview(){
    document.getElementById("preview").src = `tex?text=${btoa(document.getElementById("editor").getElementsByClassName("ace_content")[0].innerText)}&keyword=hello,yamaguchi`
}
