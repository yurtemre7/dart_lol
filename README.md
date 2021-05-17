# dart_lol, the one good league of legends plugin for flutter

A German package production :D
im 19 (16.1.2002) btw!!!

#Abitur2020 :D

## Introduction / Einführung
This is a simple good package for using the [League of Legends API](https://developer.riotgames.com/api-methods/) (will reference it as LoLApi)

This package is not yet finished an experimental! Please submit any bugs to my github repository and I will try the best in my hands to fix the g0d d4mn3d 3rr0r!

I am going to keep it simple!
How to use it properly:

First you have to assign a ApiToken given by LoLApi (You need to wait approximately 3 weeks to get your project verified! Register yours [here](https://developer.riotgames.com/app-type))

```dart
final league = League(apiToken: apiToken, server: "EUW1");
```

and furthermore

```dart
league.getSummonerInfo(summonerName: 'Ÿurt').then((summonerInfo){
    print(summonerInfo.summonerName);
    // Outputs Ÿurt
    print(summonerInfo.level);
    // Outputs current summoner level
    // etc.
  });
```

A bigger example to how to use my League package (maybe you can see how it actually appeals with the flutter-ish style :D)

```dart
league.getSummonerInfo(summonerName: emre).then((id) {
    final game = league.getGameHistory(accountID: id.accID);
    game.then((gameStat) {

      print(gameStat[1].championName);
      // Always outputs your stats for any game in the List of GameStat

      gameStat[2].stats().then((ok) {

        print(ok.participants[1].summonerName);
        // Outputs the second summoners name
        league
            .getRankInfos(summonerID: ok.participants[6].summonerID)
            .then((rankInfo) {

          print(rankInfo.leaguePoints);
          print(rankInfo.tier);
          // Outputs the sixth summoners current league points and his current tier
        });
      });
    });
  });
```

If you like my repo and want to help me or whatever, please contact me via Discord or Telegram:

Telegram: [emredev](https://t.me/emredev)

Thank you very much! Special thanks to you, Flutter!
Danke an alle, dass ihr hier seid!