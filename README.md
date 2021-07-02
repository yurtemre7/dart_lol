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
final league = League(apiToken: apiToken, server: "EUW1");
```

and furthermore

```dart
var player = await league.getSummonerInfo(summonerName: 'buff yi rep mid');
print(player.level);
```

A bigger example to how to use my League package (maybe you can see how it actually appeals with the flutter-ish style :D)

```dart
var player = await league.getSummonerInfo(summonerName: emre);

var gameStat = await league.getGameHistory(accountID: player.accID);

print(gameStat[1].championName);
// Always outputs your stats for any game in the List of GameStat

var game2 = await gameStat[2].stats();

print(game2.participants[1].summonerName);
// Outputs the second summoners name of the third game
var rankInfo = await league.getRankInfos(summonerID: game2.participants[6].summonerID);
// Outputs the sixth summoners current league points and his current tier
print(rankInfo.leaguePoints);
print(rankInfo.tier);
```

For more examples, head over to this file on my github: [test.dart](https://github.com/yurtemre7/dart_lol/blob/master/test/tests.dart)

## Thanks

If you like my repo and want to help me or whatever, please contact me via Telegram:

Telegram: [emredev](https://t.me/emredev)

Thank you very much! Special thanks to you, Flutter!
Danke an alle, dass ihr hier seid!