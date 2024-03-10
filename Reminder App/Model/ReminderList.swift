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

        listOfReminders["Tomorrow"]=[myReminder1,myReminder2]
        listOfReminders["Today"]=[myReminder3]
        listOfReminders["Yesterday"]=[myReminder4]
    }
    /**
     adds a new reminder to the list
     */
    func addReminder(reminder:Reminder,reminderKey:String){
//        self.listOfReminders.append(reminder)
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
     Sort items based on their Date
     */
//    func sortReminders(){
//        self.listOfReminders.sort(by: {value1,value2 in return value1.reminderDate<value2.reminderDate})
//    }
}
