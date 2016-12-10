//
// Created by Filip on 12/9/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import Foundation
import FlowKit
import UIKit

// todo: decide on one universal naming convention
class StubLetsFactory<ViewController: UIViewController>: LetsFactory<ViewController> {

    public override func makeLets(flow: Flow<ViewController>) -> Lets {
        return LetsStub()
    }

}
