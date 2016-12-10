//
// Created by Filip on 12/9/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import XCTest
import Nimble
import FlowKit

class DefaultLetsTests: XCTestCase {

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
