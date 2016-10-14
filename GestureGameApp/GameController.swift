import UIKit

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
    
    @IBOutlet weak var apLabel: UILabel!
    var gameType : String = ""
    
    @IBAction func yesAnswer(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func pausePressed(_ sender: AnyObject) {
        darkView.isHidden = false
        let pauseXib = myView(frame: CGRect(x: 0 + (view.bounds.width - 340) / 2 , y: 0 + (view.bounds.height - 280) / 2, width: 340, height: 280))
        view.addSubview(pauseXib)
    }
    
    
    let sides = ["Left", "Right", "Up", "Down"]
    var timer = Timer()
    var timer2 = Timer()
    
    @IBOutlet weak var imageDown: UIImageView!
    @IBOutlet weak var imageUp: UIImageView!
    @IBOutlet weak var imageRight: UIImageView!
    @IBOutlet weak var imageLeft: UIImageView!
    
    
    @IBOutlet weak var myLab: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gest = UISwipeGestureRecognizer(target: self, action: #selector(GameController.DidSwipeIt(_:)))
        gest.direction = .right
        self.view.addGestureRecognizer(gest)
        
        
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
        if gameType == "mistake" {
            apLabel.alpha = 0
        }
        view.addSubview(darkView)
        darkView.isHidden = true;
        imageRight.alpha = 0
        imageUp.alpha = 0
        imageDown.alpha = 0
        imageLeft.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        myLab.text = "0"
        if gameType == "time" {
            timeLabel.text = "\(levelTimeDefault)"
            mainTimer()
        }
        BeginForNSec()
    }
    
    func mainTimer(){
        if (levelTimeDefault > 0){
            timeLabel.text = String(levelTimeDefault)
            timer2.invalidate()
            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameController.mainTimer), userInfo: nil, repeats: false)
            levelTimeDefault -= 1
        } else {
            EndFlag = false
        }
    }
    
    
    func DidSwipeIt(_ gest : UIGestureRecognizer){
        if let gestOpt = gest as? UISwipeGestureRecognizer{
            switch gestOpt.direction {
            case UISwipeGestureRecognizerDirection.right :
                if imageRight.alpha == 1{
                    myLab.text = String(Int(myLab.text!)! + 1)}
                else if gameType == "mistake" {
                    if imageRight.alpha == 0 {
                        callStop()
                    }
                }
            case UISwipeGestureRecognizerDirection.left :
                if imageLeft.alpha == 1{
                    myLab.text = String(Int(myLab.text!)! + 1)}
                else if gameType == "mistake" {
                    if imageLeft.alpha == 0 {
                        callStop()
                    }
                }
            case UISwipeGestureRecognizerDirection.up :
                if imageUp.alpha == 1{
                    myLab.text = String(Int(myLab.text!)! + 1)}
            else if gameType == "mistake" {
                if imageUp.alpha == 0 {
                    callStop()
                }
            }
            case UISwipeGestureRecognizerDirection.down :
                if imageDown.alpha == 1{
                    myLab.text = String(Int(myLab.text!)! + 1)}
            else if gameType == "mistake" {
                if imageDown.alpha == 0 {
                    callStop()
                }
            }
            default:
                break
            }
        }
    }
    
    func callStop() {
        timer.invalidate()
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
        default : break
        }
    }
    
    
    internal func BeginForNSec(){
        if EndFlag {
            let timeSec = Float.random(0.33, upper: 1.0)
            let nameOfStr = sides[Int(arc4random_uniform(4))]
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
        record.updateMistakeRecords(Int(myLab.text!)!)
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
            default : break
                
            }
            
        }
        
    }
    
}
