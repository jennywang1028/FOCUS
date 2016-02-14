//
//  TimerViewController.swift
//  FOCUS
//
//  Created by Amanda Ong on 2/13/16.
//  Copyright © 2016 Jenny Wang. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
 
    
    var timer = NSTimer()
    var counter = 0
    //var min = 0
    var sec = 60
    var timerOn = false
    
    var rText:String = ""
    
    
    @IBOutlet weak var changeTimerBtn: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerImage: UIImageView!
    
    @IBOutlet weak var punishBtn: UIButton!
    @IBAction func punishBtnPressed(sender: AnyObject) {
    }

    let timeInterval:NSTimeInterval = 1.0
    let timerEnd:NSTimeInterval = 10.0
    var timeCount:NSTimeInterval = 0.0
    var limit = 120.0*60 //sets limit for timer in seconds
    var totalTime = 0.0 //sets total time
    var isPlaying = false
    var timerSelected = false
    var punishSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "appMovedToBackground", name: UIApplicationWillResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: "appMovedToForeground", name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.setNeedsDisplay()
    }
    
    func appMovedToBackground() {
        var Notification = UILocalNotification()
        Notification.alertAction = "You should be punished! :("
        Notification.alertBody = "You just killed your dragon!"
        Notification.fireDate = NSDate(timeIntervalSinceNow: 0)
        UIApplication.sharedApplication().scheduleLocalNotification(Notification)
        
        print("App moved to background!")
        
    }
    func appMovedToForeground() {
        timer.invalidate()
        timeCount = 0.0
        timerLabel.font = UIFont(name: "AvenirNext-Regular", size: 28)
        timerLabel.text = "You killed your dragon! 😭"
        timerImage.image = UIImage(named: "grave")
        //resetTimer(timer)
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: "resetTimer:", userInfo: nil, repeats: false)
        
       //share button
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        timerSelected = false
        punishSelected = false
        isPlaying = false
        content.contentURL = NSURL(string: rText)
        content.contentTitle = "I SHOULD BE STUDYING"
        content.contentDescription = "INSTEAD I KILLED A DRAGON"
        content.imageURL = NSURL(string: rText)
        
        let button : FBSDKShareButton = FBSDKShareButton()
        button.shareContent = content
        button.center = CGPoint(x : 195, y:100)
        self.view.addSubview(button)
        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Set timer
    @IBAction func changeTimerBtnPressed(sender: AnyObject) {
        if isPlaying == false{
            if timeCount != limit{
                timeCount = timeCount + 60
            }
            else {
                timeCount = 0
            }
            timerLabel.text = timeString(timeCount)
            totalTime = timeCount
            timerSelected = true
        }
    }
    
    //Tap hen to start timer
    @IBAction func startTimerBtnPressed(sender: UIButton) {
        isPlaying = true
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target:self, selector: Selector("updateTimer:"), userInfo: nil, repeats: true)
    }

    func stopTimer(sender: UIButton) {
        timer.invalidate()
    }
    
    //PRO: WHEN KILL DRAGON & RESTART TIMER, CLICKING ON TIMER DOESN'T WORK ANYMORE???!!!
    func resetTimer(timer2: NSTimer) {
        timer.invalidate()
        timerLabel.font = UIFont(name: "AvenirNext-Regular", size: 63)
        timeCount = 0.0
        timerLabel.text = timeString(timeCount)
        timerImage.image = UIImage(named: "egg1")
    }
    
    func timeString(time:NSTimeInterval) -> String { //NSTimeInterval time represents time in seconds
        let minutes = Int(time/60)
        let seconds = Int(time%60)
        return String(format:"%02i:%02i", minutes, seconds)
    }

    func updateTimer(timer: NSTimer){
        if timerSelected == true && punishSelected == true {
            timeCount = timeCount - timeInterval //returns # of seconds
            if timeCount <= 0 {
                timerImage.image = UIImage(named: "dragon")
                timerLabel.text = "0:00"
              // resetTimer(timer)
                timer.invalidate()
                timerSelected = false
                punishSelected = false
                isPlaying = false
            }
            else { //update the time on the clock if not reached
                if timeCount == 0.75*totalTime{
                    timerImage.image = UIImage(named: "egg2")
                }
                else if timeCount == 0.5*totalTime{
                    timerImage.image = UIImage(named: "egg3")
                }
                else if timeCount == 0.25*totalTime{
                    timerImage.image = UIImage(named: "egg4")
                }
                timerLabel.text = timeString(timeCount)
            }
        }
    }
    
    @IBAction func unwindToTimerVC(sender: UIStoryboardSegue) {
        punishSelected = true
    }
    
}
