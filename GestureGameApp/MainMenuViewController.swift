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
        let def = UserDefaults.standard
        if !def.bool(forKey: "FirstIn") {
            def.set(true, forKey: "FirstIn")
            makeNotification()
        }
    
    }
    
    func makeNotification(){
        var calendar = NSCalendar.current
        let calc = NSDateComponents()
        calc.hour = 4
        calc.minute = 0
        calc.second = 0
        calendar.timeZone = NSTimeZone.default
        let dataForce = calendar.date(from: calc as DateComponents)
        
        let notif = UILocalNotification()
        if #available(iOS 8.2, *) {
            notif.alertTitle = "Let's Play"
        } else {
        }
        notif.alertBody = "We are waiting you"
        notif.alertAction = "Go"
        notif.soundName = UILocalNotificationDefaultSoundName
        notif.alertLaunchImage = "playback"
        notif.fireDate = dataForce
        notif.repeatInterval = .weekday
        UIApplication.shared.scheduleLocalNotification(notif)
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
