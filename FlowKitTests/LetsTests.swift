//
// Created by Filip on 12/17/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import XCTest
import FlowKit
import Nimble

class LetsImpl: Lets {
    var pushCount = 0
    var popCount = 0
    var popToCount = 0
    var popToRootCount = 0
    var presentCount = 0
    var dismissCount = 0

    func push<Args, ViewController>(_ flow: Flow<ViewController>, animated: Bool = true, with getConfigure: ((ViewController) -> ((Args) -> Void))? = nil)
                    -> (Args) -> Void where ViewController: UIViewController {
        pushCount += 1
        return { _ in }
    }

    func pop(animated: Bool = true) -> () -> Void {
        popCount += 1
        return {}
    }

    func popTo<U>(_ flow: Flow<U>, animated: Bool = true) -> () -> Void {
        popToCount += 1
        return {}
    }

    func popToRoot(animated: Bool = true) -> () -> Void {
        popToRootCount += 1
        return {}
    }

    func present<U>(_ flow: Flow<U>, animated: Bool = true) -> () -> Void {
        presentCount += 1
        return {}
    }

    func dismiss(animated: Bool = true) -> () -> Void {
        dismissCount += 1
        return {}
    }

}

class LetsTests: XCTestCase {

    func testLetsProtocolForwarding() {
        let flow: Flow<UIViewController> = Flow(with: UIViewController())
        let letsImpl = LetsImpl()

        // specify type as `Lets`, so we use `Lets` default extension methods, rather than `LetsImpl`
        let lets: Lets = letsImpl

        _ = lets.push(flow) { $0.loadView }
        expect(letsImpl.pushCount).to(equal(1))

        _ = lets.pop()
        expect(letsImpl.popCount).to(equal(1))

        // todo: we should also check if  `flow` is forwarded correctly
        _ = lets.popTo(flow)
        expect(letsImpl.popToCount).to(equal(1))

        _ = lets.popToRoot()
        expect(letsImpl.popToRootCount).to(equal(1))

        // todo: we should also check if  `flow` is forwarded correctly
        _ = lets.present(flow)
        expect(letsImpl.presentCount).to(equal(1))

        _ = lets.dismiss()
        expect(letsImpl.dismissCount).to(equal(1))
    }
}