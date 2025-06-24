# open_weather_app

Please run this in Android or Web for now since I don't have an apple machine with me.

TO RUN

1. In your terminal cd to this directory
1. run flutter run --dart-define=OPEN_WEATHER_API_KEY=YOUR_KEY
1. select android or chrome

or edit the launch.json replace YOUR_KEY

{
"configurations": [
{
"name": "Debug",
"request": "launch",
"type": "dart",
"toolArgs": ["--debug", "--dart-define", "OPEN_WEATHER_API_KEY=YOUR_KEY"]
}
]
}
