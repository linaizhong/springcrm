// Generated by CoffeeScript 1.6.1
(function() {
  var $, $createTicketForm, $sendMessageForm, onClickCreateTicketBtn, onCloseSendMessageForm, onCloseTicket, onOpenSendMessageDlg, onSendMessage, storage;

  $ = jQuery;

  $createTicketForm = $("#create-ticket-form");

  $sendMessageForm = $("#send-message-form");

  storage = $.localStorage;

  onClickCreateTicketBtn = function() {
    var $form;
    $form = $createTicketForm;
    if ($form.css("display") !== "none") {
      $form.slideUp();
    }
    $form.slideDown();
    $sendMessageForm.slideUp();
    $(".content-table tr").removeClass("active");
    return $(".flash-message").remove();
  };

  onCloseSendMessageForm = function() {
    $createTicketForm.slideDown();
    $sendMessageForm.slideUp();
    $(".content-table tr").removeClass("active");
    return $(".flash-message").remove();
  };

  onCloseTicket = function() {
    return $.confirm($L("ticket.changeStage.closed.confirm"));
  };

  onOpenSendMessageDlg = function() {
    $ = jQuery;
    $("#send-message-dialog").dialog({
      buttons: [
        {
          click: function() {
            return $(this).find("form").submit();
          },
          text: $L("default.button.send.label")
        }, {
          "class": "red",
          click: function() {
            return $(this).dialog("close");
          },
          text: $L("default.button.cancel.label")
        }
      ],
      minHeight: "15em",
      modal: true,
      width: "40em"
    });
    return false;
  };

  onSendMessage = function() {
    var $form, $tr;
    $form = $sendMessageForm;
    if ($form.css("display") !== "none") {
      $form.slideUp();
    }
    $tr = $(this).parents("tr").addClass("active").siblings().removeClass("active").end();
    $createTicketForm.slideUp();
    $form.slideDown().find("input[name=id]").val($tr.data("ticket-id"));
    return false;
  };

  $("#font-size-sel").fontsize({
    change: function(event, fontSize) {
      return storage.set('fontSize', fontSize);
    },
    currentSize: storage.get('fontSize')
  });

  $sendMessageForm.on("click", ".cancel-btn", onCloseSendMessageForm);

  $(".create-ticket-btn").on("click", onClickCreateTicketBtn);

  $("#main-container").on("click", ".send-btn", onSendMessage).on("click", ".close-btn", onCloseTicket);

  $("#send-message-btn").on("click", onOpenSendMessageDlg);

}).call(this);