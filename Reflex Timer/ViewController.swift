//
//  ViewController.swift
//  Reflex Timer
//
//  Created by Henry Goodwin on 23/06/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer:NSTimer = NSTimer()
    var startTime = NSTimeInterval()
    
    var high: Int! = 6000
    var seconds: Int!
    var fraction: Int!
    
    var strSeconds: String!
    var strFraction: String!
    
    var strSecs: String!
    var strFrac: String!
    
    var score: Int!
    
    @IBOutlet var highscoreLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var startBtn: RoundedButton!
    @IBOutlet var stack: UIStackView!
    @IBOutlet var stopBtn1: RoundedButton!
    @IBOutlet var stopBtn2: RoundedButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.hidden = true
        
        let fractionDefults = NSUserDefaults.standardUserDefaults()
        let secondDefults = NSUserDefaults.standardUserDefaults()
        let highscoreDefults = NSUserDefaults.standardUserDefaults()
        
        if (fractionDefults.valueForKey("Miliseconds") != nil){
            
            high = highscoreDefults.valueForKey("HighScore") as! Int!
            strSecs = secondDefults.valueForKey("Seconds") as! String
            strFrac = fractionDefults.valueForKey("Miliseconds") as! String
            highscoreLabel.text = "Highscore: \(strSecs):\(strFrac)"
        }

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer() {
        let randomb = Double(arc4random_uniform(2))
        
        if randomb == 0 {
            stack.hidden = false
            
            stopBtn2.enabled = false
            stopBtn2.hidden = false
            stopBtn2.backgroundColor = UIColor.Grey()
            
            stopBtn1.enabled = true
            stopBtn1.hidden = false
            stopBtn1.backgroundColor = UIColor.Orange()
        
        } else {
            stack.hidden = false
            
            stopBtn2.enabled = true
            stopBtn2.hidden = false
            stopBtn2.backgroundColor = UIColor.Orange()
            
            stopBtn1.enabled = false
            stopBtn1.hidden = false
            stopBtn1.backgroundColor = UIColor.Grey()
        }
        
        
        let aSelector : Selector = #selector(ViewController.updateTime)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()

        
    }
    
    @IBAction func start(sender: AnyObject) {
        
        let random = Double(arc4random_uniform(9))
        
        highscoreLabel.hidden = true
        scoreLabel.hidden = true
        startBtn.hidden = true
        
        stack.hidden = true
        
        delay(random, closure: { () -> () in
            self.startTimer()
        })
        
        
        
    }
    
    @IBAction func stop1Pressed(sender: AnyObject) {
        
        if (timer.valid) {
            invalidate()
       
        }

    }
    
    @IBAction func stop2Pressed(sender: AnyObject) {
        
        if (timer.valid) {
            invalidate()
           
        }
        
    }
    
    func invalidate() {
        
        if (score < high) {
            
            high = score
            strSecs = strSeconds
            strFrac = strFraction
            
            highscoreLabel.text = "Highscore: \(strSecs):\(strFrac)"
            
            let secondsDefults = NSUserDefaults.standardUserDefaults()
            secondsDefults.setValue(strSecs, forKey: "Seconds")
            secondsDefults.synchronize()
            
            let highscoreDefults = NSUserDefaults.standardUserDefaults()
            highscoreDefults.setValue(high, forKey: "HighScore")
            highscoreDefults.synchronize()
            
            let minutesDefults = NSUserDefaults.standardUserDefaults()
            minutesDefults.setValue(strFrac, forKey: "Miliseconds")
            minutesDefults.synchronize()
        }

        timer.invalidate()
        stack.hidden = true
        highscoreLabel.hidden = false
        scoreLabel.hidden = false
        startBtn.hidden = false
        
    }
    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        
        
        //calculate the seconds in elapsed time.
        seconds = Int(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        fraction = Int(elapsedTime * 10000)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        
        strSeconds = String(format: "%02d", seconds)
        strFraction = String(format: "%04d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        scoreLabel.text = "Score: \(strSeconds):\(strFraction)"
        
        score = ((seconds * 10000) + Int(fraction))
        
        if score > 590000
        {
            
            invalidate()
            
        }
    }
    
    @IBAction func alertBtn(sender: UIButton) {
        
        let alertView = UIAlertController(title: "Reflex Timer", message: "Press the Orange Flash When It Appears", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)
        
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

}
