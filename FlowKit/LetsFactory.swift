//
// Created by Filip on 12/9/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import Foundation
import UIKit

// todo: figure out, how to do this as a protocol
open class LetsFactory<ViewController: UIViewController> {

    public init() {}

    open func makeLets(flow: Flow<ViewController>) -> Lets {

        fatalError("Needs to be overridden")

    }
}

public class DefaultLetsFactory<ViewController: UIViewController>: LetsFactory<ViewController> {

    public override func makeLets(flow: Flow<ViewController>) -> Lets {
        return DefaultLets<ViewController>(flow: flow)
    }

}