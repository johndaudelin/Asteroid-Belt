# Asteroid Belt

## Description

Asteroid Belt is a retro mobile version of the Atari arcade game "Asteroids" that I developed in 2012. I was able to create and market this fully functional Android game on Amazon and Google Play when I was 13 years old. The software I used is a high level mobile game creation system called "App Game Kit" (see "code" section below).

## Download/Setup

To install Asteroid Belt on your Android device, download the "Asteroid_Belt.apk" file inside the ./prod/ directory of this repository. Follow steps similar to those outlined [here](https://www.cnet.com/how-to/how-to-install-apps-outside-of-google-play/) to install this APK file on your mobile device. NOTE: Currently, the app is not supported on iOS devices.

If you would like to run a simulation of Asteroid Belt on your computer, clone this repository and simply open "AsteroidBelt.exe."

## Code

The high-level language used to program Asteroid Belt is called BASIC (or Tier 1), and is a part of the App Game Kit (AGK) game development engine. View the AGK website [here](https://www.appgamekit.com/) and the BASIC code documentation [here](https://www.appgamekit.com/documentation/home.html).

Almost all of my original code is inside the file "main.agc." I make use of the language's native "gosub" functionality, which is the equivalent of using a goto statement in Java or C. I used this structure because I was unaware at the time of functional and object-oriented programming. I also make use of a common structure in BASIC:

```
do
    // ... Conditions, updating of graphics, etc. ...
    sync()
loop
```

This block of code continually loops to: update the screen graphics, check for any conditions that have been met in the game, and perform a single screen render ("sync()") to show these changes. Once an "exit" command is found (inside a conditional), the program breaks out of this loop and continues through the code.

## History

Developed during the summer and early fall of 2012.

## Authors

John Daudelin