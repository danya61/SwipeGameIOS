//
//  MainMenuViewController.swift
//  GestureGameApp
//
//  Created by Danya on 07.10.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBAction func noAnswer(segue:UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? GameController
        vc?.gameType = segue.identifier!
    }

}
