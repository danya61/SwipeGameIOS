//
//  SettingsViewController.swift
//  GestureGameApp
//
//  Created by Danya on 24.10.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit

var AppSound : Bool = true

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var returnImage: UIImageView!

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
        let rightGest = UISwipeGestureRecognizer(target: self, action: #selector(RecordController.goback))
        rightGest.direction = .right
        self.view.addGestureRecognizer(rightGest)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1, delay: 0.6, options: .repeat, animations: {
            self.returnImage.center.x += self.returnImage.frame.width
            }, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        returnImage.image = UIImage(named: "rightst")
        self.returnImage.center.x -= self.returnImage.frame.width
        if AppSound == true {
            SoundButton.setTitle("Sound : On", for: .normal)
        } else {
            SoundButton.setTitle("Sound : Off", for: .normal)
        }
    }
    
    func goback(){
        let st = UIStoryboard(name: "Main", bundle: nil)
        let VC = st.instantiateViewController(withIdentifier: "main")
        self.present(VC, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
