//
// Created by Filip on 12/10/16.
// Copyright (c) 2016 Filip Zawada. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    var continueButton = UIButton(frame: CGRect(x: 200, y: 200, width: 100, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red

        continueButton.setTitle("continue", for: .normal)

        view.addSubview(continueButton)

        continueButton.tap {
            self.onContinue("AAA", 123, true)
        }
    }

    var onContinue = { (_: String, _: Int, _: Bool) in
        print("noop") // throw?
    }

    deinit {
        print("Deinit TutorialViewController")
    }
}