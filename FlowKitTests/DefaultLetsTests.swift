//
// Created by Filip on 12/9/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import XCTest
import Nimble
import FlowKit

fileprivate class SpyNavigation: UINavigationController {
    var popCount = 0
    var popToRootCount = 0
    var presentCount = 0
    var popToCount = 0
    var pushCount = 0
    var dismissCount = 0

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushCount += 1
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        popCount += 1
        return nil
    }

    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        popToRootCount += 1
        return nil
    }

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        presentCount += 1
    }

    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        popToCount += 1
        return nil
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        dismissCount += 1
    }
}

fileprivate class DummyViewController: UIViewController {
    var nav: UINavigationController?

    override var navigationController: UINavigationController? {
        return nav
    }

    var onTouch: () -> Void = {}
}

class DefaultLetsTests: XCTestCase {

    fileprivate var spy = SpyNavigation()
    private var flow = Flow<UIViewController>(with: UIViewController())
    override func setUp() {
        spy = SpyNavigation()
        flow = Flow<UIViewController>(with: UIViewController())
    }

    private func prepare(configure: @escaping (Lets) -> (() -> Void)) {
        let flow = Flow<DummyViewController> { [weak self] lets in
            let vc = DummyViewController()
            vc.nav = self?.spy

            vc.onTouch = configure(lets)

            return vc
        }

        let vc = flow.viewController
        vc.onTouch()

    }

    func testPush() {
        prepare { $0.push(self.flow) }

        expect(self.spy.pushCount).to(equal(1))
    }

    func testPop() {
        prepare { $0.pop() }

        expect(self.spy.popCount).to(equal(1))
    }

    func testPopTo() {
        prepare { $0.popTo(self.flow) }

        expect(self.spy.popToCount).to(equal(1))
    }

    func testPopToRoot() {
        prepare { $0.popToRoot() }

        expect(self.spy.popToRootCount).to(equal(1))
    }

    func testPresent() {
        prepare { $0.present(self.flow) }

        expect(self.spy.presentCount).to(equal(1))
    }

    func testDismiss() {
        prepare { $0.dismiss() }

        expect(self.spy.dismissCount).to(equal(1))
    }


}
