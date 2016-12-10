//
// Created by Filip on 10/25/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import Foundation
import UIKit


public class Flow<T: UIViewController> {
    private weak var _viewController: T?

    private let letsFactory:LetsFactory<T>

    public var viewController: T {
        get {
            if let _viewController = self._viewController {
                return _viewController
            }
            let lets = letsFactory.makeLets(flow: self)
            let vc = self.configuration(lets)
            self._viewController = vc
            return vc
        }
    }

    private var configuration: (Lets) -> T

    public init(_ configuration: @escaping (Lets) -> T) {
        letsFactory = DefaultLetsFactory()
        self.configuration = configuration
    }

    public init(with configuration: @autoclosure @escaping () -> T) {
        letsFactory = DefaultLetsFactory()
        self.configuration = { _ in configuration() }
    }

    public init(factory: LetsFactory<T>, configuration: @escaping (Lets) -> T) {
        letsFactory = factory
        self.configuration = configuration
    }
}
