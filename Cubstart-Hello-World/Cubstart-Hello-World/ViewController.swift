//
//  ViewController.swift
//  Cubstart-Hello-World
//
//  Created by User on 9/22/20.
//  Copyright © 2020 Jennifer Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //control, click drag
    @IBOutlet weak var helloWorldLabel: UILabel!
    @IBOutlet weak var clickmeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func updateLabelText(sender:Any){
        helloWorldLabel.text = "Welcome, Jennifer!"
        clickmeButton.setTitle("Clicked!", for:UIControl.State.normal)
    }


}

