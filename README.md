# many

the alter ego of the dart library [Once](https://pub.dev/packages/once) made by [Mostafa Soliman](https://github.com/MostafaSolimanMO) and me 😜️


----

many things should be listened to **multiple times**.
* idk what but i just made it to fix a bug in my work and i decided to make a package out of it 😂️.  
you can tell me though..

`many` supports  `runHourly`, `runEvery12Hours`, `runDaily`, `runWeekly`, `runMonthly`, and `Custom (Period)`.

## motivataion
As i said before i just made this package to fix a bug and i wondered if it can be reusable.  
so this is mainly for apps that runs all the time like `Kiosks` and for short runtime streams

**NOTE THAT THE STREAMS UNSUBSCRIBE IF YOU CLOSED THE APP**  
so if you want to run tasks periodically please check the package `once`  
as it runs on `futures` instead of `streams`

## Usage

Now you're ready to go. Say you have an app that's working 24/7 and you want to check for updates each 12 hours and show the updates:

```dart
Many.listenEvery12Hours("key",() {
    /* show updates if found else show [no updates] */
});
```

## Contributors
* [Nour Magdi](https://github.com/SPiercer)

## Please check the [Changelog](CHANGELOG.md) for new updates

