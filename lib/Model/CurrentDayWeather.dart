class CurrentDayWeather {
  var _lat;
  var _lon;
  String _main;
  String _description;
  var _temp;
  var _temp_min;
  var _temp_max;
  var _wind_speed;
  var _sunrise;
  var _sunset;
  var _humidity;

  CurrentDayWeather(
    this._lat,
    this._lon,
    this._main,
    this._description,
    this._temp,
    this._temp_min,
    this._temp_max,
    this._wind_speed,
    this._sunrise,
    this._sunset,
    this._humidity,
  );

  get lat => _lat;
  get lon => _lon;
  get main => _main;
  get description => _description;
  get temp => _temp;
  get temp_min => _temp_min;
  get temp_max => _temp_max;
  get wind_speed => _wind_speed;
  get sunrise => _sunrise;
  get sunset => _sunset;
  get humidity => _humidity;
}

