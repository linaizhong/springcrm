// Generated by CoffeeScript 1.6.1
(function() {
  var $, PurchaseInvoiceWidget;

  $ = jQuery;

  PurchaseInvoiceWidget = {
    options: {
      loadVendorsUrl: null
    },
    _create: function() {
      var _this = this;
      $ = jQuery;
      $.springcrm.invoicingtransaction.prototype._create.call(this);
      this.element.find(".price-table").invoicingitems("option", {
        productListUrl: null,
        serviceListUrl: null
      });
      $("#vendorName").autocomplete({
        focus: this._onFocusVendor,
        select: this._onSelectVendor,
        source: function(request, response) {
          return _this._onLoadVendors(request, response);
        }
      });
      return $(".document-delete").on("click", function() {
        $ = jQuery;
        $("#fileRemove").val(1);
        return $(".document-preview").add(".document-preview-links").remove();
      });
    },
    _onFocusVendor: function(event, ui) {
      $(event.target).val(ui.item.label);
      return false;
    },
    _onLoadVendors: function(request, response) {
      var url;
      $ = jQuery;
      url = this.options.loadVendorsUrl;
      if (url) {
        return $.getJSON(url, {
          name: request.term
        }, function(data) {
          return response($.map(data, function(item) {
            return {
              label: item.name,
              value: item.id
            };
          }));
        });
      }
    },
    _onSelectVendor: function(event, ui) {
      var item;
      $ = jQuery;
      item = ui.item;
      $("#vendor").val(item.label);
      $("#vendor\\.id").val(item.value);
      return false;
    }
  };

  $.widget("springcrm.purchaseinvoice", $.springcrm.invoicingtransaction, PurchaseInvoiceWidget);

}).call(this);
