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
        let fontName = UIFont.fontNames(forFamilyName: "Noteworthy").last
        yeslabel.titleLabel!.textColor = UIColor.green
        var sizeL : Int = 10;
        if view.frame.size.height == 568 {
            sizeL = 21
        } else if view.frame.size.height == 667 {
            sizeL = 27
        } else {
            sizeL = 32
        }
        yeslabel.titleLabel!.font = UIFont(name: fontName!, size : CGFloat(sizeL + 4))
        yeslabel.setTitle("Yes", for: .normal)
        
        nolabel.titleLabel!.textColor = UIColor.red
        nolabel.titleLabel!.font = UIFont(name: fontName!, size : CGFloat(sizeL))
        nolabel.setTitle("No, go to menu", for: .normal)
        
        PointBut.constant = (pointsLabel.bounds.height + self.view.bounds.height) / 2
        YesLeft.constant = yeslabel.frame.width +
            self.view.bounds.width
        NoRight.constant = nolabel.frame.width - self.view.bounds.width
    }
    
    
    @IBOutlet weak var PointBut: NSLayoutConstraint!
    @IBOutlet weak var pointRight: NSLayoutConstraint!
    @IBOutlet weak var pointLeft: NSLayoutConstraint!
    @IBOutlet weak var YesLeft: NSLayoutConstraint!
    @IBOutlet weak var NoRight: NSLayoutConstraint!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
        self.pointsLabel.center.y -= self.view.bounds.height
        pointsLabel.text = "\(pointsStr) points you have "
        self.yeslabel.center.x -= self.view.bounds.width
        self.nolabel.center.x += self.view.bounds.width
    }

     override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, animations: {
            self.yeslabel.center.x += self.view.bounds.width
            self.YesLeft.constant = 0
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 1, delay: 0.5, options: .autoreverse, animations: {
            self.pointsLabel.center.y += self.view.bounds.height
            self.PointBut.constant = 70
            self.view.layoutIfNeeded()
            }, completion: nil)
        UIView.animate(withDuration: 1, delay: 0.8, options: .curveLinear, animations: {
            self.nolabel.center.x -= self.view.bounds.width
            self.NoRight.constant = 0
            }, completion: nil)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
