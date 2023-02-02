class SevenDaysForecast{
  var _temp;
  var _icon;
  String _date;
  
  SevenDaysForecast(
    this._temp,
    this._icon,
    this._date
  );

  get temp => _temp;
  get icon => _icon;
  get date => _date;
}

