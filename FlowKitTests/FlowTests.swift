//
// Created by Filip on 12/9/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import XCTest
import Nimble
@testable import FlowKit

class DummyViewController: UIViewController {
    var configured: (String, Bool, Int)?

    func configure(string: String, bool: Bool, int: Int) {
        configured = (string, bool, int)
    }
}
class BogusViewController: UIViewController {
    var onSth: (String, Bool, Int) -> Void = {_, _, _ in }
}
class FlowTests: XCTestCase {

    func testFlowGetViewController_initWithLets() {
        let vc = DummyViewController()
        let flow = Flow { _ in vc }

        let viewController = flow.viewController

        expect(viewController).to(equal(vc))
    }

    func testFlowGetViewController_initWithoutLets() {
        let vc = DummyViewController()
        let flow = Flow(with: vc)

        let viewController = flow.viewController

        expect(viewController).to(equal(vc))
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
        _ = dummyScreen.viewController
        bogusViewController.onSth("A", true, 1)

        let received = dummyScreen.viewController.configured
        let expected = ("A", true, 1)
        expect(received!.0).to(equal(expected.0))
        expect(received!.1).to(equal(expected.1))
        expect(received!.2).to(equal(expected.2))
    }

}
