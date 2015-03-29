function tinymce_load(){
    tinyMCE.init({
        selector: "textarea.tinymce",
        toolbar: ["styleselect | bold italic | undo redo | image | link"],
        plugins: "image,link"
    });
}
$(window).load(tinymce_load());
$(document).on('pjax:complete', tinymce_load );