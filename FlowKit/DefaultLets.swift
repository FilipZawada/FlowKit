//
// Created by Filip on 12/9/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import UIKit

// todo: shouldn't be public
public class DefaultLets<T: UIViewController>: Lets {

    let flow: Flow<T>

    var nav: UINavigationController? {
        get {
            return flow.viewController.navigationController
        }
    }

    public init(flow: Flow<T>) {
        self.flow = flow
    }

    public func push<Args, ViewController>(_ flow: Flow<ViewController>,
                                           animated: Bool = true,
                                           with getConfigure: ((ViewController) -> ((Args) -> Void))? = nil)
                    -> (Args) -> Void where ViewController: UIViewController
    {
        return { args in
            let viewController = flow.viewController

            if let configureViewController = getConfigure?(viewController) {
                _ = configureViewController(args)
            }

            self.nav?.pushViewController(viewController, animated: animated)
        }
    }

    public func pop(animated: Bool = true) -> () -> Void {
        return {
            _ = self.nav?.popViewController(animated: animated)
        }
    }

    public func popTo<Args, ViewController>(_ flow: Flow<ViewController>,
                                           animated: Bool = true,
                                           with getConfigure: ((ViewController) -> ((Args) -> Void))? = nil)
                    -> (Args) -> Void where ViewController: UIViewController
    {
        return { args in
            let viewController = flow.viewController

            _ = self.nav?.popToViewController(viewController, animated: animated)

            if let configureViewController = getConfigure?(viewController) {
                _ = configureViewController(args)
            }
        }
    }

    public func popToRoot(animated: Bool = true) -> () -> Void {
        return {
            _ = self.nav?.popToRootViewController(animated: animated)
        }
    }

    public func present<U>(_ flow: Flow<U>, animated: Bool = true) -> () -> Void {
        return {
            self.nav?.present(flow.viewController, animated: animated)
        }
    }

    public func dismiss(animated: Bool = true) -> () -> Void {
        return {
            self.nav?.dismiss(animated: animated)
        }
    }

}