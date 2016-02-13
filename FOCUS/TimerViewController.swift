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
    var min = 0
    var sec = 60
    var timerOn = false
    
    @IBOutlet weak var timerBtn: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var chicken: UIButton!
    
    @IBAction func timerPressed(sender: AnyObject) {
        if min != 120{
            min = min + 1
        }
        else {
            min = 0
        }
        timerLabel.text = "\(min):00"
    }

    @IBAction func chickenPressed(sender: AnyObject) {
        counter = min
        timerOn = true
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
