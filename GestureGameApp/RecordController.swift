//
//  RecordController.swift
//  GestureGameApp
//
//  Created by Danya on 05.10.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit

class RecordController: UIViewController {
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var second: UILabel!
    @IBOutlet weak var third: UILabel!
    @IBOutlet weak var foured: UILabel!
    @IBOutlet weak var fived: UILabel!
    
    
    @IBOutlet weak var str: UIImageView!
    
    var coord : CGFloat = 0
    
    override func viewDidLoad() {
        coord = self.str.center.x
        super.viewDidLoad()
        let rightGest = UISwipeGestureRecognizer(target: self, action: #selector(RecordController.goback))
        rightGest.direction = .right
        self.view.addGestureRecognizer(rightGest)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        str.image = UIImage(named: "rightst")
        self.str.center.x -= self.str.frame.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, delay: 0.6, options: .repeat, animations: {
            self.str.center.x += self.str.frame.width
            }, completion: nil)
        var arrRecord : [Int] = Record.TimeRecord()
        first.text = String(arrRecord[0])
        second.text = String(arrRecord[1])
        third.text = String(arrRecord[2])
        foured.text = String(arrRecord[3])
        fived.text = String(arrRecord[4])
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
    

    @IBAction func changeSeg(_ sender: AnyObject) {
        if segment.selectedSegmentIndex == 0 {
            viewDidAppear(true)
        } else if segment.selectedSegmentIndex == 1 {
            var arrRecord : [Int] = Record.MistakeRecord()
            first.text = String(arrRecord[0])
            second.text = String(arrRecord[1])
            third.text = String(arrRecord[2])
            foured.text = String(arrRecord[3])
            fived.text = String(arrRecord[4])
        }
    }

}
