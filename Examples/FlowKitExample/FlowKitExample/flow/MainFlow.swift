//
// Created by Filip on 10/25/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import FlowKit

class MainFlow {
    // todo: provide a link to a radar about `lazy var` type required:
    // - https://twitter.com/filip_zawada/status/791732757177200640
    // - https://twitter.com/filip_zawada/status/791732993769500672
    lazy var tutorialScreen: Flow<TutorialViewController> = Flow { [unowned self] lets in
        let screen = TutorialViewController()

        // we forward 3 args from TutorialVC::onContinue(String, Int, Bool) to LoginVC::prepare(String, Int, Bool)
        screen.onContinue = lets.push(self.loginScreen) { $0.prepare }

        return screen
    }

    lazy var mainScreen: Flow<MainViewController> = Flow { [unowned self] lets in
        let screen = MainViewController()
        
        screen.onBack = lets.pop()
        screen.onLogOut = lets.popTo(self.loginScreen)
        screen.onExit = lets.popToRoot()
        
        return screen
    }
    
    lazy var loginScreen: Flow<LoginViewController> = Flow { [unowned self] lets in
        let screen = LoginViewController()

        screen.onLogin = lets.push(self.mainScreen)
        screen.onBack = lets.pop()
        screen.onSayHello = { print("Howdy?") }

        return screen
    }

}
