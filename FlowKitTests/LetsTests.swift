//
// Created by Filip on 12/17/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import XCTest
import FlowKit
import Nimble

class LetsImpl: Lets {}

class LetsTests: XCTestCase {

    private func expectThrows(closure: @escaping ()->Void) {
        expect(expression: closure).to(throwAssertion())
    }

    func testLetsDefaultImpl() {
        let flow: Flow<UIViewController> = Flow(with: UIViewController())

        expectThrows { _ = LetsImpl().push(flow) { $0.loadView } }
        expectThrows { _ = LetsImpl().pop() }
        expectThrows { _ = LetsImpl().popTo(flow) }
        expectThrows { _ = LetsImpl().popToRoot() }
        expectThrows { _ = LetsImpl().present(flow) }
        expectThrows { _ = LetsImpl().dismiss() }
    }
}