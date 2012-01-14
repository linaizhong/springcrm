(function ($) {

    "use strict";

    var $noteContent = $("#note-content");

    $("#organization").autocompleteex();
    $("#person").autocompleteex({
            loadParameters: function () {
                return { organization: $("#organization\\.id").val() };
            }
        });
    $noteContent.attr({ rows: 30, cols: 120 })
        .tinymce({
            language: "de",
            plugins: "autolink,lists,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,advlist",
            script_url: $noteContent.attr("data-rte-script"),
            skin: /*"o2k7",*/ "springcrm",
            skin_variant: "silver",
            theme: "advanced",
            theme_advanced_buttons1: "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,formatselect,fontselect,fontsizeselect",
            theme_advanced_buttons2: "search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,|,forecolor,backcolor",
            theme_advanced_buttons3: "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,|,print,|,fullscreen",
            theme_advanced_toolbar_location: "top",
            theme_advanced_toolbar_align: "left",
            theme_advanced_statusbar_location: "bottom",
            theme_advanced_resizing: true
        });
}(jQuery));