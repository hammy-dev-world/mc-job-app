# MCJobApp

## Requirements
- Xcode 10.1+
- Swift 4.2+
- iOS 11.0+

## Compilation
- Open ```swift .xcodeproj``` in Xcode which supports Swift 4.2.
- Do code signing with your own Apple developer account credentials.
- Select attached iOS device or simulator.
- Clean, build and run.

###### Note:
As per the requirements, there is no third party is used so there is no need to generate ```swift .xcworkspace``` to install any external dependency.

## Architecture

This codebase is built on the variation of [**V-I-P-E-R**](https://www.objc.io/issues/13-architecture/viper/), a modern architecture for developing iOS Apps. There are following components in the architecture,
1. V - View
2. I - Interactor
3. P - Presenter
4. E - Entity
5. R - Router

###### Why VIPER?:

As VIPER works on **Single Responsibility Principle** i.e. every component has certain but fixed responsibilities. This thing leads to many benefits,

1. _Code Atomicity_ i.e. every component works like a single unit with single responsibility.
2. _Code Modularity_ i.e. every component is a sub-module itself to communicate with other modules.
3. _Code Reusability_ i.e. any component can be used again without much effort in some other workspace or feature of the same workspace.
4. _Code Clarity_ i.e. every component has minimal code related to its responsibility only so things don't mix up.
5. _Code Scalability_ i.e. application as a whole is very flexible enough to scale as per business needs.
6. _Code Refactoring_ i.e. distributed and refacctored code is easy to handle.

###### Why not others?:
Other architectures like **MVC** do most of the things (which are neither view nor model related) in _Controllers_ which leads to huge, bulky and mixed up controller files which are hard to handle as the project grows.

## Structure

The codebase is well divided into logical groups and every group serves the related purpose. Following grouping is being used,

```swift
Root
  App
    Classes
      App Delegate
        Root
        App Delegate Extensions
          Navigation (R of VIPER)
      View Controllers
        Group 1
          Screen A
            ViewController (V of VIPER)
              viewcontroller // Contains controller related implementations i.e. View lifecycle, objects configuratons, callbacks, initiate network request to Presenter, validations, data integrations
            View
              view // Contains only IBOutlets, IBActions and their configuratons
              XIB
            TableView (if needed)
              DelegateDatasource
                // contains all the delegate/datasource overridden implementations
              Custom Cells
                Custom Cell A
                  Cell View // UITableViewCell subclassed and related implementations (IBOutlets, IBActions, View configurations etc)
                  Cell XIB // Custom Cell XIB
                Custom Cell B
                .............
                Custom Cell N
              CollectionViews
              Other IBOutlets
              Handler (P of VIPER)
              // Contains local and remote operations to receive user input, pass on to the Interactor, receives the response and pass back to the View
            Screen B
          Group 2
          ....
          Group N
        Network
          Servicing
            EndPoint
            HTTPMethod
            HTTPTask
            Logger
            Router
          Encoding
            ParamterEncoding
            JSONEncoding
            URLEncoding
          Response Handler
          Manager
            Server Manager 1
            Server Manager 2
            ................
            Server Manager N
          Operations
            Server Manager 1
              Group 1
                Operation 1
                Operation 2
                ...........
                Operation N
              Group 2
              .......
              Group N
            Server Manager 2
            ................
            Server Manager N
          Constants
        Models (E of VIPER)
          Group 1
            Root
              Object 1
              Object 2
              ........
              Object N
          Group 2
          .......
          Group N
        Helpers
          ThirdParties
            Library 1
            Library 2
            .........
            Library N
          Utilities
          OperationQueue
            Base
            Queue
          Local Operations
            Server Manager 1
              Group 1
                Operation 1
                Operation 2
                ...........
                Operation N
              Group 2
              .......
              Group N
            Server Manager 2
            ................
            Server Manager N
          Extensions
            Extension 1
            Extension 2
            ,,,,,,,,,,,
            Extension N
          Constants
            Constants A
            Constants B
            ..........
            Constants Z
    Project Settings
      info.plist
    Resources
      Storyboards
        LaunchScreen.storyboard
      Assets Catalogue
        .xcassets
  Tests
    Unit Tests
  UITests
    UITests
  Products
    .app
```




## Explanations
