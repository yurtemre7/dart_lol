# dart_lol, the one good league of legends plugin for flutter

A German package production :D!

## Introduction / Einführung
This is a simple good package for using the [League of Legends API](https://developer.riotgames.com/api-methods/) (will reference it as LoLApi)

This package is not yet finished an experimental! Please submit any bugs to my github repository and I will try the best in my hands to fix the g0d d4mn3d 3rr0r!

I am going to keep it simple!
How to use it properly:

First you have to assign a ApiToken given by LoLApi (You need to wait approximately 3 weeks to get your project verified! Register yours [here](https://developer.riotgames.com/app-type))

## Examples

```dart
final league = LeagueDB(apiToken: key, server: 'euw1');
```

and furthermore

```dart
var response = await league.getSummonerFromAPI(summonerName);
var summoner = response.summoner!;
print('Your name: ${summoner.name!}');
print('Your level ${summoner.summonerLevel!}');
```

For more examples, head over to this file on my github: [test.dart](https://github.com/yurtemre7/dart_lol/blob/master/test/tests.dart)

## Thanks

### Big thanks to:
- [SeaRoth](https://github.com/SeaRoth)
- [akadateppei](https://github.com/akadateppei)

---

If you like my repo and want to help me or whatever, please contact me via Telegram:

Telegram: [emredev](https://t.me/emredev)

Thank you very much! Special thanks to you, Flutter!

Danke an alle, dass ihr hier seid!