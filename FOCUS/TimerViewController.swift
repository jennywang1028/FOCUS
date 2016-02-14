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
    
    @IBOutlet weak var changeTimerBtn: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerImage: UIImageView!

    let timeInterval:NSTimeInterval = 1.0
    let timerEnd:NSTimeInterval = 10.0
    var timeCount:NSTimeInterval = 0.0 //time in seconds
    var limit = 120.0*60 //sets limit for timer in seconds
    var totalTime = 0.0 //sets total time

    //Set timer
    @IBAction func changeTimerBtnPressed(sender: AnyObject) {
            if timeCount != limit{
                timeCount = timeCount + 60
            }
            else {
                timeCount = 0
            }
            timerLabel.text = timeString(timeCount)
            totalTime = timeCount
    }

    @IBAction func startTimerBtnPressed(sender: UIButton) {
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target:self, selector: Selector("updateTimer:"), userInfo: nil, repeats: true)
    }
    
   func stopTimer(sender: UIButton) {
        timer.invalidate()
    }
    
    func resetTimer(sender: UIButton) {
        timer.invalidate()
        timeCount = 0.0
        timerLabel.text = timeString(timeCount)
    }
    
    func timeString(time:NSTimeInterval) -> String { //NSTimeInterval time represents time in seconds
        let minutes = Int(time/60)
        let seconds = Int(time%60)
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func updateTimer(timer: NSTimer){
            timeCount = timeCount - timeInterval //returns # of seconds
            if timeCount <= 0 {  //test for target time reached.
                timerImage.image = UIImage(named: "dragon")
                timerLabel.text = "0:00"
                timer.invalidate()
            } else { //update the time on the clock if not reached
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
        timerImage.image = UIImage(named: "egg")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
