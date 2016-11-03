import UIKit
import AVFoundation
import AudioToolbox


public func arc4random <T: ExpressibleByIntegerLiteral> (_ type: T.Type) -> T {
    var r: T = 0
    arc4random_buf(&r, MemoryLayout<T>.size)
    return r
}

public extension Float{
    
    public static func random(_ lower: Float, upper: Float) -> Float {
        let r = Float(arc4random()) / Float(UInt32.max)
        return (r * (upper - lower)) + lower
    }
}


var levelTimeDefault = 60;
var EndFlag = true



class GameController: UIViewController {
    
    @IBOutlet weak var darkView: UIView!
    
    @IBOutlet weak var soundButton: UIButton!
    
    var gameType : String = ""
    
    @IBAction func yesAnswer(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func soundPressed(_ sender: AnyObject) {
        if AppSound == true {
            AppSound = false
            soundButton.setImage(#imageLiteral(resourceName: "nosound"), for: .normal)
        }
        else {
            AppSound = true
            soundButton.setImage(#imageLiteral(resourceName: "sound"), for: .normal)
        }
    }
    
    var pauseXib : myView? = nil
    
    @IBAction func pausePressed(_ sender: AnyObject) {
        darkView.isHidden = false
        pauseXib  = myView(frame: CGRect(x: 0 + (view.bounds.width - 340) / 2 , y: 0 + (view.bounds.height - 280) / 2, width: 320, height: 270))
        pauseXib?.continueButton.addTarget(self, action: #selector(xibContinueTapped), for: UIControlEvents.touchUpInside)
        pauseXib?.exitButton.addTarget(self, action: #selector(xibExitTapped), for: UIControlEvents.touchUpInside)
        view.addSubview(pauseXib!)
        timer2.invalidate()
        timer.invalidate()
    }
    
    func xibContinueTapped(sender : UIButton){
        hidePause()
        darkView.isHidden = true
    }
    
    func xibExitTapped(sender : UIButton){
        EndFlag = true
        levelTimeDefault = 60
        let VC = storyboard?.instantiateViewController(withIdentifier: "main") as? MainMenuViewController
        present(VC!, animated: true, completion: nil);
    }
    
    private func hidePause() {
        pauseXib?.removeFromSuperview()
        pauseXib = nil
        if imageRight.alpha == 1 {
            BeginForNSec("Right")
        } else if imageUp.alpha == 1{
            BeginForNSec("Up")
        } else if imageDown.alpha == 1 {
            BeginForNSec("Down")
        } else if imageLeft.alpha == 1 {
            BeginForNSec("Left")
        } else {
            BeginForNSec("Tap")
        }
        
        if gameType == "time"{
            mainTimer()
        }
    }
    
    let sides = ["Left", "Right", "Up", "Down", "Tap"]
    var timer = Timer()
    var timer2 = Timer()
    
    @IBOutlet weak var imageDown: UIImageView!
    @IBOutlet weak var imageUp: UIImageView!
    @IBOutlet weak var imageRight: UIImageView!
    @IBOutlet weak var imageLeft: UIImageView!
    @IBOutlet weak var imageTap: UIImageView!
    
    
    @IBOutlet weak var myLab: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gest = UISwipeGestureRecognizer(target: self, action: #selector(GameController.DidSwipeIt(_:)))
        gest.direction = .right
        self.view.addGestureRecognizer(gest)
        
        let gest1 = UITapGestureRecognizer(target: self, action: #selector(GameController.DidSwipeIt(_:)))
        self.view.addGestureRecognizer(gest1)
        
        let gest2 = UISwipeGestureRecognizer(target: self, action: #selector(GameController.DidSwipeIt(_:)))
        gest2.direction = .left
        view.addGestureRecognizer(gest2)
        
        let gest3 = UISwipeGestureRecognizer(target: self, action: #selector(GameController.DidSwipeIt(_:)))
        gest3.direction = .down
        view.addGestureRecognizer(gest3)
        
        let gest4 = UISwipeGestureRecognizer(target: self, action: #selector(GameController.DidSwipeIt(_:)))
        gest4.direction = .up
        view.addGestureRecognizer(gest4)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if AppSound == true {
            soundButton.setImage(#imageLiteral(resourceName: "sound"), for: .normal)
        } else {
            soundButton.setImage(#imageLiteral(resourceName: "nosound"), for: .normal)
        }
        view.addSubview(darkView)
        darkView.isHidden = true;
        imageRight.alpha = 0
        imageUp.alpha = 0
        imageDown.alpha = 0
        imageLeft.alpha = 0
        imageTap.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        myLab.text = "0"
        if gameType == "time" {
            timeLabel.text = "\(levelTimeDefault) ''"
            mainTimer()
        }
        BeginForNSec()
    }
    
    //timer2  -  отвечает за так называемый секундомер вверху
    func mainTimer(){
        if (levelTimeDefault > 0){
            timeLabel.text = String(levelTimeDefault) +  " ''"
            timer2.invalidate()
            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameController.mainTimer), userInfo: nil, repeats: false)
            levelTimeDefault -= 1
        } else {
            EndFlag = false
        }
    }
    
    
    func DidSwipeIt(_ gest : UIGestureRecognizer){
        if (darkView.isHidden) {
          if let gestOpt = gest as? UISwipeGestureRecognizer{
            switch gestOpt.direction {
            case UISwipeGestureRecognizerDirection.right :
                if imageRight.alpha == 1{
                    if AppSound {
                        AudioServicesPlaySystemSound(SystemSoundID(1109))
                    }
                    myLab.text = String(Int(myLab.text!)! + 1)}
                else if gameType == "mistake" {
                    if imageRight.alpha == 0 {
                        ifAlphaZeroMistakePress()
                    }
                }
            case UISwipeGestureRecognizerDirection.left :
                if imageLeft.alpha == 1{
                    if AppSound {
                        AudioServicesPlaySystemSound(SystemSoundID(1109))
                    }
                    myLab.text = String(Int(myLab.text!)! + 1)}
                else if gameType == "mistake" {
                    if imageLeft.alpha == 0 {
                        ifAlphaZeroMistakePress()
                    }
                }
            case UISwipeGestureRecognizerDirection.up :
                if imageUp.alpha == 1{
                    if AppSound {
                        AudioServicesPlaySystemSound(SystemSoundID(1109))
                    }
                    myLab.text = String(Int(myLab.text!)! + 1)}
            else if gameType == "mistake" {
                if imageUp.alpha == 0 {
                   ifAlphaZeroMistakePress()
                }
            }
            case UISwipeGestureRecognizerDirection.down :
                if imageDown.alpha == 1{
                    if AppSound {
                        AudioServicesPlaySystemSound(SystemSoundID(1109))
                      }
                    myLab.text = String(Int(myLab.text!)! + 1)}
            else if gameType == "mistake" {
                if imageDown.alpha == 0 {
                    ifAlphaZeroMistakePress()
                }
            }
            default:
                break
            }
        }
        
        else if gest is UITapGestureRecognizer{
            if imageTap.alpha == 1{
                if AppSound {
                    AudioServicesPlaySystemSound(SystemSoundID(1109))
                }
                myLab.text = String(Int(myLab.text!)! + 1)}
            else if gameType == "mistake" {
                if imageTap.alpha == 0 {
                    ifAlphaZeroMistakePress()
                }
            }

        }
      }
    }
    
    func ifAlphaZeroMistakePress(){
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        timer.invalidate()
        darkView.backgroundColor = UIColor.red
        darkView.isHidden = false
        timer2 = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(GameController.callStop), userInfo: nil, repeats: false)
    }
    
    
    func callStop() {
        timer2.invalidate()
        darkView.backgroundColor = UIColor.black
        darkView.isHidden = true
        EndFlag = false
        stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setImage(_ ImageName : String){
        switch ImageName {
        case "Right" :
            imageRight.image = UIImage(named: "rightst")
            imageRight.alpha = 1
        case "Left" :
            imageLeft.image = UIImage(named: "leftst")
            imageLeft.alpha = 1
        case "Up" :
            imageUp.image = UIImage(named: "ust")
            imageUp.alpha = 1
        case "Down" :
            imageDown.image = UIImage(named: "downst")
            imageDown.alpha = 1
        case "Tap" :
            imageTap.image = UIImage(named: "tap")
            imageTap.alpha = 1
        default : break
        }
    }

    
    internal func BeginForNSec(_ nameStr : String = "null"){
        if EndFlag {
            let timeSec = Float.random(0.33, upper: 1.0)
            var nameOfStr = "";
            if nameStr == "null"{
                nameOfStr = sides[Int(arc4random_uniform(5))]
            } else {
                nameOfStr = nameStr
            }
            let name : String = nameOfStr
            setImage(nameOfStr)
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(timeSec) , target: self, selector: #selector(GameController.Action), userInfo: name, repeats: false)
        }
        else
            if gameType == "time" {
            timer.invalidate()
            timer2.invalidate()
            levelTimeDefault = 60
            stop()
        }
    }
    
    func stop() {
        EndFlag = true
        let record = Record()
        if gameType == "mistake" {
            record.updateMistakeRecords(Int(myLab.text!)!)
        }
        else if gameType == "time" {
            record.updateTimeRecords(Int(myLab.text!)!)
        }
        presentPopover()
    }
    
    func presentPopover(){
        let VC = storyboard?.instantiateViewController(withIdentifier: "popover") as? PopoverController
        VC?.pointsStr = "\(myLab.text!)"
        self.present(VC!, animated: true, completion: nil)
    }
    
    func Action(_ timer : Timer) {
        if let myInfo : String = timer.userInfo as! String?{
            switch myInfo{
            case "Right":
                imageRight.alpha = 0
                BeginForNSec()
            case "Up" :
                imageUp.alpha = 0
                BeginForNSec()
            case "Down" :
                imageDown.alpha = 0
                BeginForNSec()
            case "Left" :
                imageLeft.alpha = 0
                BeginForNSec()
            case "Tap" :
                imageTap.alpha = 0
                BeginForNSec()
            default : break
                
            }
            
        }
        
    }
    
}
