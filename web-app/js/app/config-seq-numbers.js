// Generated by CoffeeScript 1.6.1
(function() {
  var $, ConfigSeqNumberWidget;

  $ = jQuery;

  ConfigSeqNumberWidget = {
    _computeRndNumber: function($tr) {
      var diff, end, start;
      start = parseInt(this._getFieldVal($tr, "startValue"), 10);
      end = parseInt(this._getFieldVal($tr, "endValue"), 10);
      if (isNaN(start) || isNaN(end)) {
        return "";
      } else {
        diff = Math.abs(end - start);
        return String(Math.round(Math.random() * diff) + start);
      }
    },
    _create: function() {
      var _this = this;
      $ = jQuery;
      return this.element.on("change", function(event) {
        return _this._onChange(event);
      }).find("tbody tr").each(function(index, tr) {
        return _this._renderExample($(tr));
      });
    },
    _getFieldVal: function($tr, name) {
      return $tr.find("input[name$='." + name + "']").val();
    },
    _needOrgNumber: function($tr) {
      var ctrl;
      ctrl = $tr.data("controller-name");
      return ctrl === "quote" || ctrl === "salesOrder" || ctrl === "invoice" || ctrl === "dunning" || ctrl === "creditMemo";
    },
    _onChange: function(event) {
      var $target, $tr,
        _this = this;
      $target = $(event.target);
      $tr = $target.parents("tr");
      this._renderExample($tr);
      if ($tr.data("controller-name") === "organization") {
        return $tr.siblings().each(function(index, tr) {
          $tr = $(tr);
          if (_this._needOrgNumber($tr)) {
            return _this._renderExample($tr);
          }
        });
      }
    },
    _renderExample: function($tr) {
      var $orgTr, s, suffix;
      s = this._getFieldVal($tr, "prefix");
      if (s !== "") {
        s += "-";
      }
      s += this._computeRndNumber($tr);
      if (this._needOrgNumber($tr)) {
        $orgTr = $tr.siblings("tr[data-controller-name=organization]");
        s += "-" + (this._computeRndNumber($orgTr));
      }
      suffix = this._getFieldVal($tr, "suffix");
      if (suffix !== "") {
        s += "-" + suffix;
      }
      return $tr.find("td:last-child").text(s);
    }
  };

  $.widget("springcrm.configSeqNumber", ConfigSeqNumberWidget);

  $("#seq-numbers").configSeqNumber();

}).call(this);