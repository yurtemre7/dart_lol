# dart_lol the one good league of legends plugin for flutter

A German package production :D 
im 17 btw!!!

## Introduction / Einführung
This is a simple good package for using the [League of Legends API](https://developer.riotgames.com/api-methods/) (will reference it as LoLApi)

Im going to keep it simple!
How to use it properly:

First you have to assign a ApiToken given by LoLApi (You need to wait approximately 3 weeks to get your project verified! Register yours [here](https://developer.riotgames.com/app-type))

```dart
final league = League(apiToken: apiToken);
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

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
