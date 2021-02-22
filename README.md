[![Maintainability](https://api.codeclimate.com/v1/badges/37cb1befb614cf3c870a/maintainability)](https://codeclimate.com/github/bedranfleck/poke-app/maintainability)
[![Bitrise](https://app.bitrise.io/app/d50ee96720391d8f/status.svg?token=zDRwAOD4ug1ZV37FrqRuXw)](https://app.bitrise.io/app/d50ee96720391d8f/status.svg?token=zDRwAOD4ug1ZV37FrqRuXw)

# Poor Man's Dex (or PokeApp) :rocket:

This is a showcase app, written in swift, that uses MVVM-C architecture.

## Dependencies :handshake:
 This project uses **Cocoapods** to manage dependencies, and features the following frameworks:
 
 * **Moya** for the network layer abstractions, and ease of use.
 * **Kingfisher** to handle images that need to be fetched from an external source, as well as general image processing (and for it's built-in image cache).
 * **SnapKit** to simplify syntax when writing View code.
 * **Quick/Nimble** to enable declarative syntax when writing tests.
 * **MulticastDelegate** to broadcast events to multiple listeners. _(Important notice: This single dependency is not handled through cocoapods, but copied directly to the project, with due copyright references, and in accordance to the project LICENSE.)_.

## Architecture :european_castle:
This project follows the MVVM-C architecture, which is a specialization of the _Model-View-ViewModel_ architecture with the added component of _Coordinators_ to handle routing.

Even though it has few actual Views, this project was built to be scalable, in a way that adding new application flows and new APIs to the network layer costs little effort to develop and test.

I have used an Xcode Configuration file to define a base environment that is currently used for both Debug and Release, but this could be easily scaled to support a plethora of environments if need be, by simply creating new build configurations and assigning each one a configuration file with environment-specific values.

## Running this project locally :runner:

  * Clone this repo;
  * Make sure you have cocoapods installed and update. If you have homebrew just run `$brew install cocoapods`;
  * Navigate to the project's root directory and run `$pod install`;
  * Open the file `PokeApp.xcworkspace` with XCode (I'm using XCode 12.x as of now);
  * Select a deployment target (either a connected iOS Device or simulator);
  * Hit the :play: button on the top bar, or `Cmd+R` on your keyboard;
  * Wait for the project to build and install to the selected target.
