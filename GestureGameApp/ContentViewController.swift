//
//  ContentViewController.swift
//  GestureGameApp
//
//  Created by Danya on 23.10.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var photoName : String = "";
    var ind : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image.image = UIImage(named: photoName)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
