//
// Created by Filip on 12/10/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let logOutButton = UIButton(frame: CGRect(x: 50, y: 100, width: 100, height: 100))
    let backButton = UIButton(frame: CGRect(x: 50, y: 200, width: 100, height: 100))
    let exitButton = UIButton(frame: CGRect(x: 50, y: 300, width: 100, height: 100))

    override func viewDidLoad() {
        view.backgroundColor = .yellow

        logOutButton.setTitle("log out", for: .normal)
        logOutButton.setTitleColor(.black, for: .normal)
        backButton.setTitle("back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        exitButton.setTitle("exit", for: .normal)
        exitButton.setTitleColor(.black, for: .normal)

        view.addSubview(logOutButton)
        view.addSubview(backButton)
        view.addSubview(exitButton)

        logOutButton.tap(onLogOut)
        backButton.tap(onBack)
        exitButton.tap(onExit)
    }

    var onBack: () -> Void = {}
    var onLogOut: () -> Void = {}
    var onExit: () -> Void = {}

    deinit {
        print("Deinit MainViewController")
    }

}