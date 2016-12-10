//
//  FlowKitExampleTests.swift
//  FlowKitExampleTests
//
//  Created by Filip on 10/27/16.
//  Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import XCTest
@testable import FlowKitExample

class FlowKitExampleTests: XCTestCase {

//    func testLetStubs() {
//        let loginScreen = Flow { LoginViewController() }
//        let mainScreen = Flow { lets in
//            let screen = MainViewController()
//
//            screen.onBack = lets.pop()
//            screen.onLogOut = lets.popTo(self.loginScreen)
//            screen.onExit = lets.popToRoot()
//
//            return screen
//        }
//
//        let letsFactory = LetsSpyFactory()
//
//        mainScreen.letsFactory = letsFactory
//
//        // `LetsSpyFactory` always return the same item, so `factory.makeLets() === factoryMakeLets()` is always true
//        let spy = letsFactory.makeLets() as! LetsSpy
//
//        let mainScreenViewController = mainScreen.viewController
//
//        // a) - lets.pop(), lets.popTo(self.loginScreen), lets.popToRoot() - were called
//        // b) - no other lets.method() was called
//        // c) - check if screen `onBack`, `onLogOut` & `onExit` handlers were properly set.
//        XCTAssertEqual(spy.pushCalled, 0)
//        XCTAssertEqual(spy.popCalled, 1)
//        XCTAssertEqual(spy.popToCalled, 1)
//        XCTAssertEqual(spy.popToRootCalled, 1)
//        XCTAssertEqual(spy.presentCalled, 0)
//        XCTAssertEqual(spy.dismissCalled, 0)
//        XCTAssertEqual(spy.popToCalledWithArgument, loginScreen)
//
//        XCTAssertEqual(mainScreenViewController.onBack, spy.pop())
//        XCTAssertEqual(mainScreenViewController.onLogOut, spy.popTo(self.loginScreen))
//        XCTAssertEqual(mainScreenViewController.popToRoot, spy.popToRoot())
//    }
    
}
