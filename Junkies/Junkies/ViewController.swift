//
//  ViewController.swift
//  Junkies
//
//  Created by Jennifer Yang on 10/22/20.
//  Copyright © 2020 Cubstart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var locationName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func chipotleClick(_ sender: Any) {
        locationName = "Chipotle"
        performSegue(withIdentifier: "goToMap", sender: self)
    }
    
    @IBAction func tacoBellClick(_ sender: Any) {
        locationName = "Taco Bell"
        performSegue(withIdentifier: "goToMap", sender: self)
    }
    @IBAction func starbucksClick(_ sender: Any) {
        locationName = "Starbucks"
        performSegue(withIdentifier: "goToMap", sender: self)
    }
    @IBAction func mcdonaldsClick(_ sender: Any) {
        locationName = "McDonalds"
        performSegue(withIdentifier: "goToMap", sender: self)
    }
    
    // MARK: - Navigation

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         //Get the new view controller using segue.destination.
         //Pass the selected object to the new view controller.
        let map = segue.destination as! MapViewController
        map.locationName = locationName

    }
}

