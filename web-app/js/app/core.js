// Generated by CoffeeScript 1.4.0
(function() {
  var $, $html, decimalSeparator, groupingSeparator, numFractions;

  $ = jQuery;

  $html = $("html");

  decimalSeparator = $html.data("decimal-separator") || ",";

  groupingSeparator = $html.data("grouping-separator") || ".";

  numFractions = $html.data("num-fraction-digits") || 2;

  Date.prototype.format = function(format) {
    var d, delimiter, fmt, pad, regexp, res, token;
    if (format == null) {
      format = "datetime";
    }
    if ((format === "date") || (format === "time") || (format === "datetime")) {
      fmt = "";
      if ((format === "date") || (format === "datetime")) {
        fmt += $L("default.format.date");
      }
      if (format === "datetime") {
        fmt += " ";
      }
      if ((format === "time") || (format === "datetime")) {
        fmt += $L("default.format.time");
      }
      format = fmt;
    }
    pad = function(x) {
      var s;
      s = x.toFixed();
      if (s.length < 2) {
        s = "0" + s;
      }
      return s;
    };
    d = this;
    regexp = /[^dMyHm]/;
    res = "";
    while (format) {
      if (regexp.test(format)) {
        token = RegExp.leftContext;
        delimiter = RegExp.lastMatch;
        format = RegExp.rightContext;
      } else {
        token = format;
        delimiter = "";
        format = "";
      }
      switch (token) {
        case "d":
          res += d.getDate();
          break;
        case "dd":
          res += pad(d.getDate());
          break;
        case "M":
          res += d.getMonth() + 1;
          break;
        case "MM":
          res += pad(d.getMonth() + 1);
          break;
        case "y":
          res += d.getYear();
          break;
        case "yy":
          res += pad(d.getYear() % 100);
          break;
        case "yyy":
        case "yyyy":
          res += String(d.getFullYear());
          break;
        case "H":
          res += d.getHours();
          break;
        case "HH":
          res += pad(d.getHours());
          break;
        case "m":
          res += d.getMinutes();
          break;
        case "mm":
          res += pad(d.getMinutes());
      }
      res += delimiter;
    }
    return res;
  };

  Number.prototype.format = function(n) {
    var dotPos, frac, gs, int, num, numSgn, pos, sgn;
    if (n == null) {
      n = null;
    }
    gs = groupingSeparator;
    num = this;
    numSgn = (n === null ? num : num.round(n));
    sgn = (numSgn < 0 ? "-" : "");
    n = (n === null ? void 0 : Math.abs(n));
    num = Math.abs(+num || 0);
    int = String(parseInt(num = (isNaN(n) ? num.toString() : num.toFixed(n)), 10));
    pos = ((pos = int.length) > 3 ? pos % 3 : 0);
    frac = "";
    if (n !== 0) {
      dotPos = num.indexOf(".");
      if (dotPos >= 0) {
        frac = Math.abs(num.substring(dotPos));
        frac = (isNaN(n) ? frac.toString() : frac.toFixed(n));
        frac = decimalSeparator + frac.substring(2);
      }
    }
    return sgn + (pos ? int.substr(0, pos) + gs : "") + int.substr(pos).replace(/(\d{3})(?=\d)/g, "$1" + gs) + frac;
  };

  Number.prototype.formatCurrencyValue = function() {
    return this.format(numFractions);
  };

  Number.prototype.round = function(n) {
    var power;
    if (n == null) {
      n = numFractions;
    }
    power = Math.pow(10, n);
    return Math.round(this * power) / power;
  };

  RegExp.escape = function(s) {
    return s.replace(/[\-\/\\\^$*+?.()|\[\]{}]/g, "\\$&");
  };

  String.prototype.parseDate = function(format, baseYear) {
    var day, hours, minutes, month, part, pos, regexp, s, token, year;
    if (format == null) {
      format = "datetime";
    }
    if (baseYear == null) {
      baseYear = 35;
    }
    s = this;
    if (!$.trim(s)) {
      return null;
    }
    if ((format === "date") || (format === "time") || (format === "datetime")) {
      if ((format === "date") || (format === "datetime")) {
        fmt += $L("default.format.date");
      }
      if (format === "datetime") {
        fmt += " ";
      }
      if ((format === "time") || (format === "datetime")) {
        fmt += $L("default.format.time");
      }
      format = fmt;
    }
    day = 1;
    month = 0;
    year = 1970;
    hours = 0;
    minutes = 0;
    pos = 0;
    regexp = /[^dMyHm]/;
    while (format) {
      if (regexp.test(format)) {
        token = RegExp.leftContext;
        pos = s.indexOf(RegExp.lastMatch);
        if ((pos < 0) || (pos + 1 >= s.length)) {
          throw new Error("Invalid date or time format: " + s);
        }
        part = s.substring(0, pos);
        s = s.substring(pos + 1);
        format = RegExp.rightContext;
      } else {
        token = format;
        part = s;
        format = "";
      }
      switch (token) {
        case "d":
        case "dd":
          day = parseInt(part, 10);
          break;
        case "M":
        case "MM":
          month = parseInt(part, 10) - 1;
          break;
        case "y":
        case "yy":
        case "yyy":
        case "yyyy":
          year = parseInt(part, 10);
          if (year < 100) {
            year += (year < baseYear ? 2000 : 1900);
          }
          break;
        case "H":
        case "HH":
          hours = parseInt(part, 10);
          break;
        case "m":
        case "mm":
          minutes = parseInt(part, 10);
      }
    }
    if (isNaN(year) || isNaN(month) || isNaN(day) || isNaN(hours) || isNaN(minutes)) {
      throw new Error("Invalid date or time format: " + s);
    }
    return new Date(year, month, day, hours, minutes, 0, 0);
  };

  String.prototype.parseNumber = function() {
    var reD, reG, s;
    reD = new RegExp(RegExp.escape(decimalSeparator), "g");
    reG = new RegExp(RegExp.escape(groupingSeparator), "g");
    s = this.toString();
    if (s === "") {
      return 0;
    } else {
      return parseFloat(s.replace(reG, "").replace(reD, "."));
    }
  };

}).call(this);
