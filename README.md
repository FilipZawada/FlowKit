# Flow Kit
_iOS/Swift_

Define screen flows easily with FlowKit. Elegant syntax, clear separation of concerns and testability makes it a perfect add-on for your current MV* setup.

```swift
let tutorialScreen = Flow(with: TutorialViewController()) { vc, lets in
    vc.onContinue = lets.push(loginScreen)
}
```

```swift
let loginScreen = Flow(with: LoginViewController()) { vc, lets in
    vc.onLogin = lets.push(dashboardScreen)
    vc.onBack = lets.pop()
}
```

```swift
let dashboardScreen = Flow(with: DashboardViewController()) { vc, lets in
    vc.onBack = lets.pop()
    vc.onLogOut = lets.popToRoot()
}
```

This supports following flow 
```text
 ____________                _________             _____________
|            |              |         |           |             |  
| TutorialVC | onContinue() | LoginVC | onLogin() | DashboardVC |
|            | -----------> |         | --------> |             |
|____________|              |_________|           |_____________|
```

This is how any of our view controllers may look like:
```swift
class DashboardViewController: UIViewController {
    var onBack: () -> Void = {}
    var onLogOut: () -> Void = {}
    
    @IBAction func backButtonTapped(button: UIButton) {
        onBack()
    }
    
    @IBAction func logOutButtonTapped(button: UIButton) {
        onLogOut()
    }
}
```
## Defining a flow

`Flow` is a wrapper around any `UIViewController`. Through `Flow` you can define
how your `ViewController` interacts with other view controllers. Main interactions possible are:
* `push(otherViewController)`
* `present(otherViewController)`
* `pop()`
* `dismiss()`

This approach has a few major advantages, since your `ViewController`:
- doesn't need to know other view controllers in the town _#loosely-coupling_
- focuses on managing it's own view, rather than managing apps navigation _#single-responsibility_
- is easier to test _#testability_
- code becomes more readable, since navigation-related pieces can be put in one place _#readability_
- entrance and exit points of your `ViewController` are clearly defined _#clear-api_

There are multiple ways how to initialize the flow:

1. Without interactions:

   ```
   let yourScreen = Flow(with: YourViewController())
   
   // or e.g. with a custom xib
   let yourScreen = Flow(with: YourViewController(nibName: "YourView", bundle: nil))
   ```

   _Note that thanks to `@autoclosure` `YourViewController()` is instantiated lazily, i.e. only when needed. #swiftmagic_
  
2. With interactions (short version)
   ```
   let yourScreen = Flow(with: YourViewController()) { vc, lets in
       vc.onBack = lets.pop()
       vc.onAbout = lets.present(otherScreen)
   }
   ```

3. With interactions (long version)
   ```
   let yourScreen = Flow<YourViewController> { lets in
       // let's initialize our ViewController from a storyboard 
       let storyboard = UIStoryboard(name: "YourView", bundle: nil)
       let vc = storyboard.instantiateViewController(withIdentifier: "YourView") as! YourViewController

       vc.onBack = lets.pop()
       vc.onAbout = lets.present(otherScreen)
       
       return vc
   }
   ```

## Passing arguments
So, let's assume we've got a shopping app. `ItemViewController` presents our GreatProduct™.
If a user decides to purchase it, `CheckoutViewController` is pushed to the screen to guide user through the checkout process. 
Now, how can `CheckoutViewController` know which product is actually being purchased? 
Obviously, it should receive that info from `ItemViewController`. This is how to do this:

```Swift
class ItemViewController: UIViewController {
    var item: Item? // = GreatProduct™
    var quantity = 0
    
    var onCheckout: (Item, Int) -> Void
    
    @IBAction func checkout(button: UIButton) {
        if let item = item {
            onCheckout(item, quantity)        
        }
    }
}

class CheckoutViewController: UIViewController {
    func prepare(item: Item, quantity: Int) {
        print("User wants to purchase \(item) × \(quantity)")
    }
}

// our flow

let checkoutScreen = Flow(with: CheckoutViewController(nibName: "CheckoutView", bundle: nil))

let itemScreen = Flow(with: ItemViewController()) { vc, lets in

    vc.onCheckout = lets.push(checkoutScreen) { $0.prepare }
    
}

```

The trick here is to forward arguments from `onCheckout()` to `prepare()` function.
This is done exactly here `vc.onCheckout = lets.push(checkoutScreen) { $0.prepare }`
In plain words we'd say:
```plain
                   vc.  onCheckout= lets.push( checkoutScreen){$0.prepare }
hey itemViewController, on checkout lets push checkout screen and prepare it

```

Important thing to note here is that the signature of `onCheckout` has to be identical with the signature of `prepare`, so arguments can be passed successfully.

# Grouping Flows
In a usual scenario it's convenient to group your flows in a separate classes.
For example you can have a `LoginFlow`, `SignUpFlow`, `CheckoutFlow` etc...
If your app is small, it may be enough to have one `MainFlow`.

```swift
//
// Created by Filip on 10/25/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import FlowKit

class MainFlow {
    lazy var tutorialScreen: Flow<TutorialViewController> = Flow { [unowned self] lets in
        let screen = TutorialViewController()
        
        screen.onContinue = lets.push(self.loginScreen) { $0.prepare }
        
        return screen
    }

    lazy var dashboardScreen: Flow<DashboardViewController> = Flow { [unowned self] lets in
        let screen = DashboardViewController()
        
        screen.onBack = lets.pop()
        screen.onLogOut = lets.popTo(self.loginScreen)
        screen.onExit = lets.popToRoot()
        
        return screen
    }
    
    lazy var loginScreen: Flow<LoginViewController> = Flow { [unowned self] lets in
        let screen = LoginViewController()

        screen.onLogin = lets.push(self.mainScreen)
        screen.onBack = lets.pop()

        return screen
    }
}
```

_note 1. We had to use `lazy var` to allow `dashboardScreen` to reference `loginScreen` and vice versa. 
With regular `let` compiler wouldn't allow us to use `loginScreen` in `dashboardScreen`._ 

_note 2. Unfortunately due to compiler bug we have declare variable type, otherwise we can't use `self.`._ 

# Testability

_under construction_

I'd like to create a custom nimble matchers, so testing our flows would be as easy as writing them:
```swift
let mainScreen = Flow(with: MainViewController())
mainScreen.letsFactory = LetsSpyFactory()
let spy = mainScreen.letsFactory.makeSpy()

let vc = mainScreen.viewController

expect(vc.onBack).to(haveBeenBackedWith(spy.pop))
expect(vc.onLogOut).to(haveBeenBackedWith(spy.popTo(loginScreen)))
expect(vc.onExit).to(haveBeenBackedWith(spy.popToRoot()))
```

# Extensions

_under construction_

FlowKit shall integrate well with:

- RxSwift (in preparation)
  
  ```swift
    let tutorialScreen = Flow(with: TutorialViewController()) { vc, lets in
        vc.onContinue
          .asDriver()
          .drive(lets.push(loginScreen))
          .addToDisposeBag(disposeBag)
    }
    ```

- PromiseKit (in preparation)

  ```swift
  let tutorialScreen = Flow(with: TutorialViewController()) { vc, lets in
      vc.onContinue.then { lets.push(loginScreen) }
  }
  ```
  
  This is just an illustration, I'm not yet sure how this is going to look like.

# About
This project is created and maintained by Filip Zawada. It was created as a remedy for navigation problems in my last apps.

This projects is the next iteration over the idea of Flow Controllers, [described](http://merowing.info/2016/01/improve-your-ios-architecture-with-flowcontrollers/) by Krzysztof Zabłocki.
# License
To be chosen soon.

<p align="center" style="font-style: italic; font-size: 0.6em">
<sub><sup>designed in Poland, assembled in Swift 🙃</sub></sup>
</p>

