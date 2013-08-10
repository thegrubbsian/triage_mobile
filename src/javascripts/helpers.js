var Helpers = {

  formData: function(selector) {
    var data = {};
    var els = $("input, textarea, select, datetime, date, time, number", selector);
    els.each(function(i, el) {
      var el = $(el);
      var name = el.attr("name");
      var value;
      if (el.is("[type='checkbox']")) {
        value = el.is(":checked");
      } else if (el.is("[type='radio']:checked")) {
        value = el.val();
      } else {
        value = el.val();
      }
      if (value) { data[name] = value; }
    });
    return data;
  },

  currentTimezoneOffset: function() {
    var dstPeriod = {}, lastStartDay = 11, lastEndDay = 4;
    for (var i = 2012; i < 2030; i++) {
      if (lastStartDay == 8) { lastStartDay = 11; } else { lastStartDay--; }
      if (lastEndDay == 1) { lastStartDay = 6; } else { lastStartDay--; }
      dstPeriod[i] = [new Date(i, 2, lastStartDay), new Date(i, 10, lastEndDay)];
    }
    var today = new Date();
    var offset = today.getTimezoneOffset();
    var year = today.getFullYear();
    var january = new Date(today.getFullYear(), 0, 1);
    var januaryOffset = january.getTimezoneOffset();
    var july = new Date(today.getFullYear(), 6, 1);
    var julyOffset = july.getTimezoneOffset();
    var dstObserved = januaryOffset == julyOffset;
    var dstDiff = Math.abs(januaryOffset - julyOffset);
    if (dstObserved) {
      var period = dstPeriod[year];
      if (today >= period[0] && today < period[1]) {
        offset += dstDiff;
      }
    }
    return ((offset / 60) * -1);
  }

};
