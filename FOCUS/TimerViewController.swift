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
    
    var Time = 10
    var timerN = NSTimer()
    
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

        timerImage.image = UIImage(named: "egg1")
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "appMovedToBackground", name: UIApplicationWillResignActiveNotification, object: nil)
    }
    
    func appMovedToBackground() {
            var Notification = UILocalNotification()
            Notification.alertAction = "You should be punished! :("
            Notification.alertBody = "You just killed your dragon!"
            
            Notification.fireDate = NSDate(timeIntervalSinceNow: 0)
            
            UIApplication.sharedApplication().scheduleLocalNotification(Notification)
        print("App moved to background!")
        timer.invalidate()
        timeCount = 0.0
        timerLabel.font = UIFont(name: "AvenirNext-Regular", size: 28)
        timerLabel.text = "You killed your dragon! 😭"
        timerImage.image = UIImage(named: "grave")
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
    
    func resetTimer(sender: UIButton) {
        timer.invalidate()
        timeCount = 0.0
        timerLabel.text = timeString(timeCount)
        timerImage.image = UIImage(named: "egg")
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
                timer.invalidate()
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
