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
    func popTo<U>(_ flow: Flow<U>, animated: Bool) -> () -> Void
    func popToRoot(animated: Bool) -> () -> Void
    func present<U>(_ flow: Flow<U>, animated: Bool) -> () -> Void
    func dismiss(animated: Bool) -> () -> Void
}


// add default values
fileprivate let msg = "The only purpose of this extension is to provide default values with the protocol `Lets`"

public extension Lets {
    func push<Args, ViewController>(_ flow: Flow<ViewController>, animated: Bool = true, with getConfigure: ((ViewController) -> ((Args) -> Void))? = nil)
                    -> (Args) -> Void where ViewController: UIViewController {
        fatalError(msg)
    }

    func pop(animated: Bool = true) -> () -> Void {
        fatalError(msg)
    }

    func popTo<U>(_ flow: Flow<U>, animated: Bool = true) -> () -> Void {
        fatalError(msg)
    }

    func popToRoot(animated: Bool = true) -> () -> Void {
        fatalError(msg)
    }

    func present<U>(_ flow: Flow<U>, animated: Bool = true) -> () -> Void {
        fatalError(msg)
    }

    func dismiss(animated: Bool = true) -> () -> Void {
        fatalError(msg)
    }
}
