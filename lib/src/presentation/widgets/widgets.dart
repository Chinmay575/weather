import 'package:flutter/material.dart';
import 'package:weather/src/domain/models/forecast.dart';
import 'package:weather/src/utils/constants.dart';

import '../../domain/models/weather.dart';

Widget initialWidget() {
  return const SizedBox(
    width: double.maxFinite,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        CircularProgressIndicator(
          color: Colors.amber,
        ),
        Text("Wait the weather is being loaded"),
      ],
    ),
  );
}

Widget loadingWidget() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget displayWeather(Weather w, String lastUpdated, BuildContext context) {
  double deviceHeight = MediaQuery.of(context).size.height;
  double deviceWidth = MediaQuery.of(context).size.width;
  return Container(
    width: deviceWidth,
    height: deviceHeight * 0.3,
    margin: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      boxShadow: const [
        BoxShadow(
          blurRadius: 10,
          blurStyle: BlurStyle.outer,
          color: Colors.grey,
        ),
      ],
      // border: Border.all(color: Colors.grey,width: 2),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          height: 100,
          width: 100,
          child: Image.asset(w.image, fit: BoxFit.fitHeight),
        ),
        Text(
          '${w.tempratureC}° C',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        Text(
          w.condition,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          w.city,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Last Updated: $lastUpdated",
        )
      ],
    ),
  );
}

Widget sunRiseDetails(Weather w, BuildContext context) {
  double deviceHeight = MediaQuery.of(context).size.height;
  double deviceWidth = MediaQuery.of(context).size.width;
  return Container(
    height: deviceHeight * 0.15,
    width: deviceWidth,
    margin: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      boxShadow: const [
        BoxShadow(
          blurRadius: 10,
          blurStyle: BlurStyle.outer,
          color: Colors.grey,
        ),
      ],
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        detailsCard(w.sunrise, "Sunrise", "assets/images/sunrise.png"),
        detailsCard(w.sunset, "Sunset", "assets/images/sunset.png"),
      ],
    ),
  );
}

Widget extraDetails(Weather w, BuildContext context) {
  double deviceHeight = MediaQuery.of(context).size.height;
  double deviceWidth = MediaQuery.of(context).size.width;
  return Container(
    height: deviceHeight * 0.34,
    width: deviceWidth,
    margin: const EdgeInsets.only(right: 15, left: 15),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      boxShadow: const [
        BoxShadow(
          blurRadius: 10,
          blurStyle: BlurStyle.outer,
          color: Colors.grey,
        ),
      ],
      borderRadius: BorderRadius.circular(15),
    ),
    child: GridView(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      children: [
        detailsCard(
          "${w.uvIndex}",
          "UV Index",
          "assets/images/uv-index.png",
        ),
        detailsCard(
          "${w.humidity}%",
          "Humidity",
          "assets/images/humidity.png",
        ),
        detailsCard(
          "${w.windK} kmp",
          "Wind",
          "assets/images/wind.png",
        ),
        detailsCard(
          "${w.pressuremb} mbar",
          "Pressure",
          "assets/images/atmospheric-pressure.png",
        ),
        detailsCard(
          "${w.rain} %",
          "Precipitation",
          "assets/images/rain-cloud.png",
        ),
        detailsCard(
          "${w.gustK} kmp",
          "Gust",
          "assets/images/dashing-away.png",
        ),
      ],
    ),
  );
}

Widget detailsCard(String data, String parameterName, String iconPath) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(
        height: 50,
        width: 50,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Image.asset(iconPath),
      ),
      Text(
        parameterName,
        style: const TextStyle(fontWeight: FontWeight.w400),
      ),
      Text(
        data,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
  );
}

Widget locations(BuildContext context,List<String> cities) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 15),
          height: 50,
          width: double.maxFinite,
          alignment: Alignment.center,
          child: const Text(
            "Manage Locations",
            // textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                width: 200,
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      (cities[index].length > 30)
                          ? '${cities[index].substring(0, 30)}...'
                          : cities[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.location_on,
                      color: (index == 0) ? Colors.black : Colors.white,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        addLocationButton(context),
      ],
    ),
  );
}

Widget addLocationButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, AppRoutes.addLocation);
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 50),
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      width: double.maxFinite,
      child: const Text(
        " + Add new Location",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget showError() {
  return const Center(
    child: Text(
      "Error occured when fetching the current weather,try restarting the app or reinstalling it",
    ),
  );
}

Widget showForecast(BuildContext context, Weather w) {
  double deviceHeight = MediaQuery.of(context).size.height;
  double deviceWidth = MediaQuery.of(context).size.width;
  return Container(
    width: deviceWidth,
    height: deviceHeight * 0.2,
    margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      boxShadow: const [
        BoxShadow(
          blurRadius: 10,
          blurStyle: BlurStyle.outer,
          color: Colors.grey,
        ),
      ],
      borderRadius: BorderRadius.circular(15),
    ),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: w.forecast7Day[0].hourly.length,
      itemBuilder: (context, index) {
        return forecastCard(
          w.forecast7Day[0].hourly[index],
          (index == 0) ? 'first' : 'middle',
        );
      },
    ),
  );
}

Widget forecastCard(ForecastHour f, String position) {
  return Container(
    width: 75,
    margin: (position == 'first')
        ? const EdgeInsets.all(15)
        : const EdgeInsets.only(top: 15, right: 15, bottom: 15),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          f.time,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          // margin: const EdgeInsets.all(20),
          height: 64,
          width: 64,
          child: Image.asset(f.image, fit: BoxFit.fitHeight),
        ),
        Text(
          "${f.tempratureC}° C",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          f.text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ],
    ),
  );
}

Widget showForecastNext7Days(BuildContext context, Weather w) {
  double deviceHeight = MediaQuery.of(context).size.height;
  double deviceWidth = MediaQuery.of(context).size.width;
  return Container(
    width: deviceWidth,
    height: deviceHeight * 0.25,
    margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      boxShadow: const [
        BoxShadow(
          blurRadius: 10,
          blurStyle: BlurStyle.outer,
          color: Colors.grey,
        ),
      ],
      borderRadius: BorderRadius.circular(15),
    ),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: w.forecast7Day.length - 1,
      itemBuilder: (context, index) {
        return forecastDayCard(
          w.forecast7Day[index + 1],
          (index == 0) ? 'first' : 'middle',
        );
      },
    ),
  );
}

Widget forecastDayCard(ForecastDay f, String position) {
  return Container(
    width: 150,
    margin: (position == 'first')
        ? const EdgeInsets.all(15)
        : const EdgeInsets.only(top: 15, right: 15, bottom: 15),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          f.date,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          // margin: const EdgeInsets.all(20),
          height: 64,
          width: 64,
          child: Image.asset(f.image, fit: BoxFit.fitHeight),
        ),
        Text("Avg Temp"),
        Text(
          "${f.avgTempC}° C",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          f.text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ],
    ),
  );
}
