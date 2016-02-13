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
    
    @IBOutlet weak var timerBtn: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var chicken: UIButton!
    let timeInterval:NSTimeInterval = 1.0
    let timerEnd:NSTimeInterval = 10.0
    var timeCount:NSTimeInterval = 0.0

    //Set timer
    @IBAction func timerPressed(sender: AnyObject) {
        if timeCount != 120.0{
            timeCount = timeCount + 1
        }
        else {
            timeCount = 0
        }
        timerLabel.text = timeString(timeCount)
    }

    //Tap hen to start timer
    @IBAction func chickenPressed(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target:self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopTimer(sender: UIButton) {
        timer.invalidate()
    }
    
    @IBAction func resetTimer(sender: UIButton) {
        timer.invalidate()
        timeCount = 0.0
        timerLabel.text = timeString(timeCount)
    }
    
    func timeString(time:NSTimeInterval) -> String {
        let minutes = Int(time)
        let seconds = Double(time)*60 % 60
        return String(format:"%02i:%02i",minutes,Int(seconds))
    }
    
    func updateTimer(timer:NSTimer){
        //timerLabel.text = timer.userInfo as? String
            //timer that counts down
            timeCount = timeCount - timeInterval
            if timeCount <= 0 {  //test for target time reached.
                timerLabel.text = "0:00"
                timer.invalidate()
            } else { //update the time on the clock if not reached
                timerLabel.text = timeString(timeCount)
            }
    }
    
    /*
    func updateCounter() {
        if timerOn == true{
            min--
            timerOn = false
        }
        sec--
        if sec > 10 {
            timerLabel.text = "\(min):\(sec)"
        }
        else if sec > 0{
            timerLabel.text = "\(min):0\(sec)"
        }
        else if sec == 0 {
            min--
            timerLabel.text = "\(min):00"
            sec = 60
        }
        else if min == 0 && sec == 0{
            timer.invalidate()
            sec = 60
            min = 0
            timerLabel.text = "\(min):00"
        }
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
