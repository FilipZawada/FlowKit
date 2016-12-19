//
// Created by Filip on 12/9/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import XCTest
import Nimble
@testable import FlowKit

fileprivate class DummyViewController: UIViewController {
    var configured: (String, Bool, Int)?

    func configure(string: String, bool: Bool, int: Int) {
        configured = (string, bool, int)
    }
}
fileprivate class BogusViewController: UIViewController {
    var onSth: (String, Bool, Int) -> Void = {_, _, _ in }
}
class FlowTests: XCTestCase {

    func testFlowInit_closure() {
        let vc = DummyViewController()
        let flow = Flow { _ in vc }

        let viewController = flow.viewController

        expect(viewController).to(equal(vc))
    }

    func testFlowInit_with() {
        let vc = DummyViewController()
        let flow = Flow(with: vc)

        let viewController = flow.viewController

        expect(viewController).to(equal(vc))
    }

    func testFlowInit_withAndClosure() {
        let vc = DummyViewController()
        var receivedViewController: DummyViewController?
        var receivedLets: Lets?

        let flow = Flow(with: vc) { vc, lets in
            receivedViewController = vc
            receivedLets = lets
        }
        let viewController = flow.viewController

        expect(receivedViewController).to(equal(vc))
        expect(viewController).to(equal(vc))
        expect(type(of: receivedLets!)).to(be(DefaultLets<DummyViewController>.self))
    }

    func testFlowGetViewController_returnsSameInstance() {
        var callCount = 0
        let flow = Flow { _ in
            callCount += 1
            return DummyViewController()
        }

        let vc1 = flow.viewController
        let vc2 = flow.viewController

        expect(vc1).to(equal(vc2))
        expect(callCount).to(equal(1))
    }

    func testFlowPassArguments() {
        let dummyScreen = Flow<DummyViewController> { _ in DummyViewController() }
        let bogusScreen = Flow<BogusViewController> { lets in
            let vc = BogusViewController()

            vc.onSth = lets.push(dummyScreen, animated: true) { $0.configure }

            return vc
        }

        let bogusViewController = bogusScreen.viewController
        let dummyScreenViewController = dummyScreen.viewController
        bogusViewController.onSth("A", true, 1)

        let received = dummyScreenViewController.configured
        let expected = ("A", true, 1)
        expect(received!.0).to(equal(expected.0))
        expect(received!.1).to(equal(expected.1))
        expect(received!.2).to(equal(expected.2))
    }

    func testFlowLetsFactory() {
        var receivedLets: Lets?
        let factory = StubLetsFactory<DummyViewController>()
        let flow = Flow<DummyViewController>(factory: factory) { lets in
            receivedLets = lets
            return DummyViewController()
        }

        _ = flow.viewController

        expect(type(of: receivedLets!)).to(be(LetsStub.self))
    }

    func testFlowReturnsDefaultLets() {
        var receivedLets: Lets?
        let flow = Flow<DummyViewController>() { lets in
            receivedLets = lets
            return DummyViewController()
        }

        // triggers closure above
        _ = flow.viewController

        expect(type(of: receivedLets!)).to(be(DefaultLets<DummyViewController>.self))
    }

}
