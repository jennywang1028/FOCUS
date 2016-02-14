//
//  publishmentController.swift
//  FOCUS
//
//  Created by Jenny Wang on 2/13/16.
//  Copyright © 2016 Jenny Wang. All rights reserved.
//

import Foundation

class PublishmentController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource  {
    
    var index = 0
    
    @IBOutlet weak var pv: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.pv.delegate = self
        self.pv.dataSource = self
        
        // Input data into the Array:
        pickerData = ["Jane", "IS", "MEAN", "LIKE", "VERY", "MEEEEEAAANNN"]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        index = row
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var secVc: TimerViewController = (segue.destinationViewController as? TimerViewController)!
        secVc.rText = pickerData[index]
    }
}