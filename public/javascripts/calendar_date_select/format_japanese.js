// format_japanese.js
// 日付セパレータを "/" にする
Date.prototype.toFormattedString = function(include_time) {
        var hour;
    var str = this.getFullYear() + "/" + Date.padded2(this.getMonth() + 1) + "/" +Date.padded2(this.getDate());
    if (include_time) {
        hour = Date.padded2(this.getHours());
        str += " " + hour + ":" + this.getPaddedMinutes();
    }
    return str;
};

// TODO: take care of timezone offsets
// as the timezone is not displayed in the input,
// this could be tricky (or just unnessesary)
Date.parseFormattedString = function (string) {
  var regexp = "([0-9]{4})(/([0-9]{2})(/([0-9]{2})" +  "( ([0-9]{1,2}):([0-9]{2})?" + "?)?)?)?"; 
  var d = string.match(new RegExp(regexp, "i"));
  if (d==null) {
    return Date.parse(string); // Give javascript a chance to parse it.
  }
 
  ymd = d[1].split('/');
  hrs = 0;
  mts = 0;
  if(d[2] != null) {
    hrs = parseInt(d[2].split(':')[0], 10);
    mts = parseInt(d[2].split(':')[1], 10);
  }
  return new Date(ymd[0], parseInt(ymd[1], 10)-1, ymd[2], hrs, mts, 0);

};
