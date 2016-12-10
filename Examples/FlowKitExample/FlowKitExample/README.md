* Loosely couples view controllers. View control
* Keeps Flow in a dedicated place, not coupled with other things your app do
* Flow only takes care of flow, i.e what view causes other view to display and how views are created.
  You don't write wiring code (controllerA.a = controllerB.b)  
* Provides methods for testing flow
* Integration with RxSwift (coming soon)
* integration with PromiseKit (coming soon)
* ViewController doesn't know anything about FlowKit (yay!)

1. Testing
    * vaniila testing
    * using simon matchers

2. RxSwift version



1. Naive way of writing navigation code
 - it has many pitfalls, e.g.:
 - MassiveViewController
 - Tightly Coupled Views
 - Krzysztof Zablocki proposed a better solution
2. Improved version
 - it's x100 better than the old approach, however we can still improve it
 - mediators take care of setting flow & configuring view controllers
 - there's a lot of boilerplate in the code making it less readable
 - it's not easy to test this stuff