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

## Why no RxSwift?

As a professional with over three years of accumulated experience with RxSwift/RxCocoa/RxGestures (I will call these RxSwift from now, but they are separate libraries), I made a decision not to use a RxSwift for this project for some reasons, hereby listed :

 1. **Maintainability**: I find that while Rx libraries introduce very cool and unique ways to write code, and perform data binding and etc., it presents itself as something with a steep learning curve for Jr. developers who may be involved, and in general makes code more difficult to debug for those with less experience. Code tends to naturally get messier with time if not continuously taken care of, and RxSwift accelerates that, in my oppinion.
 2. **Dispose Bags**: RxSwift is a bit unique when it comes to setup. It requires the use of dispose bags to manage the way observables are disposed. The problem with this, is that it is dificult to determine exactly when to dispose of observables in some situations. While avoidable, this is a problem that can cause memory leaks fairly easily if one is not aware of how to handle the library.

That said, RxSwift is a pretty cool set of libraries and presents a really nice way to handle some problems. Using it (or not) must always be a team choice, considering all the gives and takes that it provides, since you don't really want to use RxSwift inside a single UIViewController or Module (and most often you won't be able to isolate it to that scope).

Thank you for reading!
