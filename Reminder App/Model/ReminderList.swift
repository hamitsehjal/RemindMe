//
//  ReminderList.swift
//  Reminder App
//
//  Created by Hamit Sehjal on 2024-03-07.
//

import Foundation


class ReminderList{
    // data structure to store reminders

    var listOfReminders=[String:[Reminder]]()
    
    // helper array to lay sections in specific order
    var sectionOrder=["Tomorrow","Today","Yesterday"]
    init(){

        let myReminder1=Reminder(title: "Tomorrow-1", description: "YO", id: "hello", reminderDate: Date())
        let myReminder2=Reminder(title: "Tomorrow-2", description: "YO", id: "hello", reminderDate: Date())
        let myReminder3=Reminder(title: "Today", description: "YO", id: "hello", reminderDate: Date())
        let myReminder4=Reminder(title: "Yesterday", description: "YO", id: "hello", reminderDate: Date())

//        listOfReminders["Tomorrow"]=[myReminder1,myReminder2]
//        listOfReminders["Today"]=[myReminder3]
//        listOfReminders["Yesterday"]=[myReminder4]
        
        listOfReminders["Tomorrow"]=[]
        listOfReminders["Today"]=[]
        listOfReminders["Yesterday"]=[]
    }
    /**
     adds a new reminder to the list
     */
    func addReminder(reminder:Reminder){

        let reminderKey=ReminderList.findReminderCategory(dateToCheck: reminder.reminderDate)
        print("Inserting new reminder into \(reminderKey)")
        self.listOfReminders[reminderKey]?.append(reminder)
    }
    
    /**
     remove a reminder from the list
     takes the following paramter
      - reminder instance to be deleted
      - index to find the section key since we are using dictionary as data Source
     
     */
    func removeReminder(reminder:Reminder,sectionIndex:Int){
        let sectionKey=self.sectionOrder[sectionIndex]
        
        if let index=listOfReminders[sectionKey]?.firstIndex(of: reminder){
            listOfReminders[sectionKey]?.remove(at: index)
        }
        
    }
    /**
     Sort reminders in a specific section based on their Date
     */
    func sortReminders(){
        for sectionKey in self.sectionOrder{
            self.listOfReminders[sectionKey]?.sort(by: {value1,value2 in return value1.reminderDate<value2.reminderDate})
            }
        }
        
    // find the category to insert the new reminder
    static func findReminderCategory(dateToCheck:Date)->String{
        
        var categoryString=""
        // get the current calender
        let calender=Calendar.current
        // get the current date
        let currentDate=Date()
        
        // Get the components of the current Date
        let currentDateComponents=calender.dateComponents([.year,.month,.day], from:currentDate)
        
        // Get the components of the datePickerView's Date object
        let dateToCheckComponents=calender.dateComponents([.year,.month,.day], from: dateToCheck)
        
        // Compare the Date components
        if let currentDateDay=currentDateComponents.day,
           let currentDateMonth=currentDateComponents.month,
           let currentDateYear=currentDateComponents.year,
           let dateToCheckDay=dateToCheckComponents.day,
           let dateToCheckMonth=dateToCheckComponents.month,
           let dateToCheckYear=dateToCheckComponents.year{
            print("DateToCheckYear = \(dateToCheckYear)")
            print("CurrentDateYear = \(currentDateYear)")
            print("DateToCheckMonth = \(dateToCheckMonth)")
            print("CurrentDateMonth = \(currentDateMonth)")

            print("DateToCheckDay = \(dateToCheckDay)")
            print("CurrentDateDay = \(currentDateDay)")
            if dateToCheckYear == currentDateYear{
                // check month
                if dateToCheckMonth == currentDateMonth{
                    // check day
                    if dateToCheckDay == currentDateDay{
                        // today
                        categoryString="Today"
                    }
                    else if dateToCheckDay > currentDateDay{
                        // tomorrow
                        categoryString="Tomorrow"
                    }
                    else{
                        // yesterday
                        categoryString="Yesterday"
                    }
                }
                else if dateToCheckMonth > currentDateMonth{
                    // tomorrow
                    categoryString="Tomorrow"
                }
                else{
                    // yesterday
                    categoryString="Yesterday"
                }
            }
            else if dateToCheckYear > currentDateYear{
                // tomorrow
                categoryString="Tomorrow"
            }
            else{
                // yesterday
               categoryString="Yesterday"
            }
            
        }
        return categoryString
    }

    }

