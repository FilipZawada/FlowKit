//
// Created by Filip on 12/9/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import Foundation
import UIKit

public protocol Lets {
    func push<Args, ViewController>(_ flow: Flow<ViewController>, animated: Bool, with getConfigure: ((ViewController) -> ((Args) -> Void))?)
                    -> (Args) -> Void where ViewController: UIViewController
    func pop(animated: Bool) -> () -> Void
    func popTo<Args, ViewController>(_ flow: Flow<ViewController>, animated: Bool, with getConfigure: ((ViewController) -> ((Args) -> Void))?)
                    -> (Args) -> Void where ViewController: UIViewController
    func popToRoot(animated: Bool) -> () -> Void
    func present<U>(_ flow: Flow<U>, animated: Bool) -> () -> Void
    func dismiss(animated: Bool) -> () -> Void
}

// add default values
public extension Lets {
    func push<Args, ViewController>(_ flow: Flow<ViewController>, animated: Bool = true, with getConfigure: ((ViewController) -> ((Args) -> Void))? = nil)
                    -> (Args) -> Void where ViewController: UIViewController {
        return self.push(flow, animated: animated, with: getConfigure)
    }

    func pop(animated: Bool = true) -> () -> Void {
        return self.pop(animated: animated)
    }

    func popTo<Args, ViewController>(_ flow: Flow<ViewController>, animated: Bool = true, with getConfigure: ((ViewController) -> ((Args) -> Void))? = nil)
                    -> (Args) -> Void where ViewController: UIViewController {
        return self.popTo(flow, animated: animated, with: getConfigure)
    }

    func popToRoot(animated: Bool = true) -> () -> Void {
        return self.popToRoot(animated: animated)
    }

    func present<U>(_ flow: Flow<U>, animated: Bool = true) -> () -> Void {
        return self.present(flow, animated: animated)
    }

    func dismiss(animated: Bool = true) -> () -> Void {
        return self.dismiss(animated: true)
    }
}