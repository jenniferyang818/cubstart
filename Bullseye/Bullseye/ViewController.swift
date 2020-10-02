//
//  ViewController.swift
//  Bullseye
//
//  Created by User on 10/1/20.
//  Copyright © 2020 Jennifer Yang. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var numSlider: UISlider!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var exactSwitch: UISwitch!
    
    var randomNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        randomNumber = Int(arc4random_uniform(101))
                numLabel.text = "Move the slider to: \(randomNumber)"
    }

    @IBAction func checkValue(_ sender: Any) {
        if (exactSwitch.isOn) {
            if randomNumber-3 <= Int(numSlider.value) && randomNumber+3 >= Int(numSlider.value){
                resultLabel.text = "Bullseye!"
            } else {
                resultLabel.text = "Sorry, you missed!"
            }
        }
        else {
            if (Int(numSlider.value) == randomNumber) {
                resultLabel.text = "Bullseye!"
            }
            else {
                resultLabel.text = "Sorry, you missed!"
            }
        }
        resultLabel.isHidden = false //we'll come back to this
        playAgainButton.isHidden = false
        
    }
    @IBAction func changeText(_ sender: Any) {
        numLabel.text="hi"
    }
    @IBAction func playAgain(_ sender: Any) {
        numSlider.setValue(50.0, animated: false)
        randomNumber = Int(arc4random_uniform(101))
        numLabel.text = "Move the slider to: \(randomNumber)"
        resultLabel.isHidden = true //must reappear next time it is checked ^
        playAgainButton.isHidden = true
    }
    @IBAction func sliderValueChanged(_ sender: Any) {
//        numLabel.text = "\(Int(numSlider.value))"
    }
    
}

