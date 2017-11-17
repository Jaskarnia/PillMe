//
//  AddDrugViewController.swift
//  PillMe
//
//  Created by Andy Yang on 11/12/17.
//  Copyright © 2017 Andy Yang. All rights reserved.
//

import UIKit
import UserNotifications

class AddDrugViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let center = UNUserNotificationCenter.current()
    var notificationIdentifierCount = 1
    
    var rowOfPillChoice = 1 //used to store the row of numOfPills
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var time: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var justAddedDrugLabel: UILabel!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return false
    }
    
    
    let numOfPillChoices = ["1","2","3","4","5","6","7","8","9","10"]
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return numOfPillChoices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return numOfPillChoices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        rowOfPillChoice = row
    }
    
    @IBAction func addDrug(_ sender: Any)
    {
        
        if (input.text != "")
        {
            
        let dateFormatr = DateFormatter()
        dateFormatr.dateFormat = "h:mm a"
        let strDate = dateFormatr.string(from: (time?.date)!)
        //stores the time as a string in strDate
            
        list.append([input.text!, strDate, numOfPillChoices[rowOfPillChoice]])
        
        //simulates a toast notifcation on label
        justAddedDrugLabel.text = "'" + input.text! + " " + strDate + " - " + numOfPillChoices[rowOfPillChoice] + " pills'  added to schedule"
        DispatchQueue.main.asyncAfter(deadline: .now() + 4)
        {
        self.justAddedDrugLabel.isHidden = true
        self.justAddedDrugLabel.text = ""
        }
        justAddedDrugLabel.isHidden = false
            
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Time to take your Pills"
        content.body = "Take " + numOfPillChoices[rowOfPillChoice] + " " + input.text!
        content.sound = UNNotificationSound.default()
       
        let date = Date(timeIntervalSinceNow: time.date.timeIntervalSinceNow)
        
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        let identifier =  String(notificationIdentifierCount)
        let request = UNNotificationRequest(identifier:identifier, content:content,trigger:trigger)
        center.add(request, withCompletionHandler: {
            (error) in if error != nil{
                print("error with notification")
            }
        })
        notificationIdentifierCount+=1
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.input.delegate = self;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
