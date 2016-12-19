//
// Created by Filip on 12/19/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import UIKit
import FlowKit

var sampleFlow: Flow<UIViewController> {
    let flow = Flow(with: UIViewController())

    // run `UIViewController()`
    _ = flow.viewController

    return flow
}