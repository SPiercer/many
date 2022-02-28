import 'package:shared_preferences/shared_preferences.dart';

/// Once Durations in milliseconds
const _year = _day * 365;
const _week = _day * 7;
const _day = 86400000;

abstract class Many {
  static Stream<T?> _listen<T>({
    required String key,
    required int duration,
    required T? Function() callback,
  }) async* {
    while (true) {
      final prefs = await SharedPreferences.getInstance();

      /// listen only Monthly
      if (duration == -1) {
        while (true) {
          if (prefs.containsKey(key)) {
            final currentMonth = DateTime.now().month;
            final currentYear = DateTime.now().year;
            final monthMilliseconds =
                (_daysInMonth(currentMonth, currentYear) * _day);

            await Future.delayed(Duration(milliseconds: monthMilliseconds));
            yield callback.call();
          }
        }
      }

      /// listen any other once options
      if (prefs.containsKey(key)) {
        await Future.delayed(Duration(milliseconds: duration));
        yield callback.call();
      }
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      prefs.setInt(key, currentTime);
      yield callback.call();
    }
  }

  static Stream<T?> listenEvery12Hours<T>(
    String key,
    T? Function() callback,
  ) =>
      _listen(
        key: key,
        duration: _day ~/ 2,
        callback: callback,
      );

  static Stream<T?> listenHourly<T>(
    String key,
    T? Function() callback,
  ) =>
      _listen(
        key: key,
        duration: _day ~/ 24,
        callback: callback,
      );

  static Stream<T?> listenDaily<T>(
    String key,
    T? Function() callback,
  ) =>
      _listen(
        key: key,
        duration: _day,
        callback: callback,
      );

  static Stream<T?> listenWeekly<T>(
    String key,
    T? Function() callback,
  ) =>
      _listen(
        key: key,
        duration: _week,
        callback: callback,
      );

  static Stream<T?> listenMonthly<T>(
    String key,
    T? Function() callback,
  ) =>
      _listen(
        key: key,
        duration: -1,
        callback: callback,
      );

  static Stream<T?> listenYearly<T>(
    String key,
    T? Function() callback,
  ) =>
      _listen(
        key: key,
        duration: _year,
        callback: callback,
      );

  static Stream<T?> listenCustom<T>(
    String key,
    T? Function() callback, {
    required Duration duration,
  }) =>
      _listen(
        key: key,
        duration: duration.inMilliseconds,
        callback: callback,
      );
}

int _daysInMonth(final int monthNum, final int _year) {
  List<int> monthLength = List.filled(12, 0);
  monthLength[0] = 31;
  monthLength[2] = 31;
  monthLength[3] = 30;
  monthLength[4] = 31;
  monthLength[5] = 30;
  monthLength[6] = 31;
  monthLength[7] = 31;
  monthLength[8] = 30;
  monthLength[9] = 31;
  monthLength[10] = 30;
  monthLength[11] = 31;

  if (_leapYear(_year) == true) {
    monthLength[1] = 29;
  } else {
    monthLength[1] = 28;
  }

  return monthLength[monthNum - 1];
}

bool _leapYear(int _year) {
  bool leapYear = false;
  bool leap = ((_year % 100 == 0) && (_year % 400 != 0));
  if (leap == true) {
    leapYear = false;
  } else if (_year % 4 == 0) {
    leapYear = true;
  }

  return leapYear;
}
