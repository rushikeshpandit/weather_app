import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';
import 'package:geolocator/geolocator.dart';

const apiKey = '126b8da017ba91a73559d8fff0476f2d';
const openWeatherMapURL = 'http://api.weatherstack.com/current';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    await Geolocator.requestPermission();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?query=$cityName&access_key=$apiKey&units=m');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    await Geolocator.requestPermission();
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?query=${location.latitude},${location.longitude}&access_key=$apiKey&units=m');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
