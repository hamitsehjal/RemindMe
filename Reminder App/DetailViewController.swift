//
//  DetailViewController.swift
//  Reminder App
//
//  Created by Hamit Sehjal on 2024-03-07.
//

import UIKit

class DetailViewController: UIViewController {
    var reminder:Reminder! // reference to the item that is being currently shown
    
    @IBOutlet var SaveBtn: UIBarButtonItem!
    
    var reminderList:ReminderList? // reference to list of reminders
    
    
    
    
    var dateSelectedByUser:Date!
    var titleOfReminder:String!{
        didSet{
            if titleOfReminder .isEmpty{
                // Disable Save button if title  of the Remainder is Empty
                SaveBtn.isEnabled=false
            }
            else{
                SaveBtn.isEnabled=true
            }
        }
    }
    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var descTextView: UITextView!
    @IBOutlet var datePickerView: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // configure UIDatePicker
        datePickerView.datePickerMode = .dateAndTime
        datePickerView.minimumDate = Date() // minimum date is today
        

        // setting the border layout for description Text View
        descTextView.layer.borderWidth=2.0
        descTextView.layer.borderColor=UIColor.white.cgColor
        descTextView.layer.cornerRadius=10
        descTextView.layer.backgroundColor=UIColor.white.cgColor
        
        // Add padding to the Descript
        let padding:CGFloat=30.0
        
        descTextView.textContainerInset=UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        // setting the border for Date Picker View
        datePickerView.layer.borderWidth=2.0
        datePickerView.layer.borderColor=UIColor.white.cgColor
        datePickerView.layer.cornerRadius=10
        datePickerView.layer.backgroundColor=UIColor.white.cgColor
    }
    
    @IBAction func titleChanged(_ sender: UITextField) {
        titleOfReminder=sender.text
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIBarButtonItem) {
        
//        // pop off the topViewController
//        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnTapped(_ sender: UIBarButtonItem) {
        
        print("Save Button Pressed")
        // set the entered values to the Controller's Remainder instance
        reminder.title=titleOfReminder
        reminder.description=descTextView.text
        reminder.reminderDate=datePickerView.date
        
        // Check if the reminder already exists in the list
        // If it doesn't, create a new instance of the reminder and add it to the lis
//        if let list=reminderList{
//            if !list.listOfReminders.contains(where: {element in return element.id == reminder.id}){
//                // Add the reminder to the collection
//                reminderList?.addReminder(reminder: reminder)
//                print("Added New item")
//            }
//        }
        
//        navigationController?.popViewController(animated: true)
        
        performSegue(withIdentifier: "unwindSegueSave", sender: self)
    }
    @IBAction func handleDateChanged(_ sender: UIDatePicker) {
        
        dateSelectedByUser=sender.date
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleOfReminder=reminder.title
        titleTextField.text="\(reminder.title)"
        descTextView.text="\(reminder.description ?? "")"
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
