//
//  PopoverController.swift
//  GestureGameApp
//
//  Created by Danya on 05.10.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit

class PopoverController: UIViewController {
    @IBOutlet weak var yeslabel: UIButton!
    @IBOutlet weak var nolabel: UIButton!
    
    var pointsStr : String = ""
    @IBOutlet weak var pointsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pointsLabel.center.y -= self.view.bounds.height
        pointsLabel.text = "\(pointsStr) points you have "
        self.yeslabel.center.x -= self.view.bounds.width
        self.nolabel.center.x += self.view.bounds.width
    }

     override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, animations: {self.yeslabel.center.x += self.view.bounds.width})
        UIView.animate(withDuration: 1, delay: 0.5, options: .autoreverse, animations: {
            self.pointsLabel.center.y += self.view.bounds.height
            }, completion: nil)
        UIView.animate(withDuration: 1, delay: 0.8, options: .curveLinear, animations: {
            self.nolabel.center.x -= self.view.bounds.width
            }, completion: nil)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
