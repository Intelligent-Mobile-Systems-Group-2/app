# Intelligent Mobile Systems: Group 2

A intelligent mobile system project. 
This project is created in flutter and intended for Android purposes only. 

# Project

A project where one should be able to communicate with a mower to give it drive commands and switch between a remote controlled state and autonomous state. The app also communcates with a REST API where it fetches object and boundary colission events and prints out on a canvas in the app. 

## Getting Started

To run this application, begin with downloading the flutter sdk

Download Flutter: https://docs.flutter.dev/get-started/install

When cloning repository, begin with doing a [flutter packages get] following with a [flutter pub get].

Make sure you have either a android emulator or an android device. 

## To start application

Begin with adding --no-sound-null-safety to your settings.json file.

For visual studio:

- open user settings in vs code. 
- Thereafter add string above to flutter Run Additional Args 
- save

For Android studio:

- First of all click on File.
- There You can See Preferences Click on Preferences.
- Now you can see Settings click on that.
- Then Just Search For Flutter run additional args.
- then click Add Item.
- now type --no-sound-null-safety.
- click ok.

After this it should work as intended. 

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
