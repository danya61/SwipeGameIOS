//
//  SettingsViewController.swift
//  GestureGameApp
//
//  Created by Danya on 24.10.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit

var AppSound = true

class SettingsViewController: UIViewController {

    @IBOutlet weak var SoundButton: UIButton!
    @IBAction func soundChange(_ sender: AnyObject) {
        if SoundButton.currentTitle == "Sound : On" {
            SoundButton.setTitle("Sound : Off", for: .normal)
            AppSound = false
        }
        else {
            SoundButton.setTitle("Sound : On", for: .normal)
            AppSound = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if AppSound == true {
            SoundButton.setTitle("Sound : On", for: .normal)
        } else {
            SoundButton.setTitle("Sound : Off", for: .normal)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
