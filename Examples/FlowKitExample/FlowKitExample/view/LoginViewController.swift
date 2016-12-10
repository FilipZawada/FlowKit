//
// Created by Filip on 12/10/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var onLogin: () -> Void = {}
    var onBack: () -> Void = {}
    var onSayHello: () -> Void = {}

    let loginButton = UIButton(frame: CGRect(x: 50, y: 100, width: 100, height: 100))
    let backButton = UIButton(frame: CGRect(x: 50, y: 200, width: 100, height: 100))
    let sayHelloButton = UIButton(frame: CGRect(x: 50, y: 300, width: 100, height: 100))
    let titleLabel = UIButton(frame: CGRect(x: 50, y: 400, width: 100, height: 100))

    func prepare(string: String, int: Int, bool: Bool) {
        print("received \(string) \(int) \(bool)")
    }

    override func viewDidLoad() {
        view.backgroundColor = .green

        loginButton.setTitle("login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        backButton.setTitle("back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        sayHelloButton.setTitle("hello", for: .normal)
        sayHelloButton.setTitleColor(.black, for: .normal)

        view.addSubview(loginButton)
        view.addSubview(backButton)
        view.addSubview(sayHelloButton)

        loginButton.tap(onLogin)
        backButton.tap(onBack)
        sayHelloButton.tap(onSayHello)
    }

    deinit {
        print("Deinit LoginViewController")
    }
}

