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
    
    var urlData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.pv.delegate = self
        self.pv.dataSource = self
        
        //refresh punishment for server
        
        //refresh("https://dont-drag-on.herokuapp.com/punmaker.random")
        // Input data into the Array:
        pickerData = ["meme1", "meme2", "meme3", "meme4", "meme5", "meme6"]
        
        urlData = ["http://img.memecdn.com/go-study_o_995957.jpg", "https://s-media-cache-ak0.pinimg.com/564x/b6/3b/e4/b63be44c1dd6530aaf246d3b11e1c74f.jpg", "http://www.quickmeme.com/img/31/3142c1ed8d8225a982534959cf2c3de90568c969b6da635fb41c7991a9f23b59.jpg", "http://www.troll.me/images/screaming-baby/da-hell-r-u-doing-go-and-study-nau.jpg", "https://s-media-cache-ak0.pinimg.com/236x/d5/2a/af/d52aafe8da307ab377422bbc08330f6b.jpg","http://www.troll.me/images/smeagle/close-it-and-go-study-thumb.jpg"]
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
        secVc.rText = urlData[index]
    }
    
    func  refresh(urlString: String, index: Int){
        var url : NSURL = NSURL(string: urlString)!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            if error != nil{
                self.setPun(data!, index: index)}
            else{
                self.pickerData = ["Jane", "IS", "MEAN", "LIKE", "VERY", "MEEEEEAAANNN"]
            }
        }
            
        task.resume()
    }

    func setPun(punData: NSData, index: Int){
        
        
    }
    
}