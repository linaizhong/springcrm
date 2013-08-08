// Generated by CoffeeScript 1.6.1
(function() {
  var $, onClickCreateNoteBtn, onClickSendMessageToCustomerBtn, onClickSendMessageToUserMenu, showMessageDialog;

  $ = jQuery;

  onClickCreateNoteBtn = function() {
    var $this;
    $this = $(this);
    return showMessageDialog($this.data("title"), $this.data("submit-url"));
  };

  onClickSendMessageToCustomerBtn = function() {
    var $this;
    $this = $(this);
    return showMessageDialog($this.data("title"), $this.data("submit-url"));
  };

  onClickSendMessageToUserMenu = function() {
    var $span, $this;
    $ = jQuery;
    $this = $(this);
    $span = $("#send-message-to-user-menu .button:first-child");
    return showMessageDialog($span.data("title"), $span.data("submit-url"), $this.data("user-id"));
  };

  showMessageDialog = function(title, url, recipient) {
    if (recipient == null) {
      recipient = "";
    }
    $("#send-message-dialog").find("form").attr("action", url).end().find("#recipient").val(recipient).end().dialog({
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
      title: title,
      width: "40em"
    });
    return false;
  };

  $("#send-message-to-customer-btn").on("click", onClickSendMessageToCustomerBtn);

  $("#send-message-to-user-menu").on("click", "ul a", onClickSendMessageToUserMenu);

  $("#create-note-btn").on("click", onClickCreateNoteBtn);

  $("#take-on-btn").on("click", function() {
    return $.confirm($L("ticket.takeOn.confirm"));
  });

  $("#assign-user-menu").on("click", "a", function() {
    return $.confirm($L("ticket.changeStage.assign.confirm"));
  });

  $("#close-ticket-btn").on("click", function() {
    return $.confirm($L("ticket.changeStage.closed.confirm"));
  });

}).call(this);
