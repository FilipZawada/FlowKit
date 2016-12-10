//
// Created by Filip on 12/9/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import FlowKit
import UIKit

class LetsStub: Lets {

    func push<Args, ViewController>(_ flow: Flow<ViewController>,
                                    animated: Bool = true,
                                    with getConfigure: ((ViewController) -> ((Args) -> Void))? = nil)
                    -> (Args) -> Void where ViewController: UIViewController {

        return { _ in }
    }

    func pop(animated: Bool = true)  -> () -> Void {
        return {}
    }

    func popTo<U>(_ flow: Flow<U>, animated: Bool = true) -> () -> Void {
        return {}
    }

    func popToRoot(animated: Bool = true) -> () -> Void {
        return {}
    }

    func present<U>(_ flow: Flow<U>, animated: Bool = true) -> () -> Void {
        return {}
    }

    func dismiss(animated: Bool = true) -> () -> Void {
        return {}
    }

}
