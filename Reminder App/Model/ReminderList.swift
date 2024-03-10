//
//  ReminderList.swift
//  Reminder App
//
//  Created by Hamit Sehjal on 2024-03-07.
//

import Foundation


class ReminderList{
    var listOfReminders=[Reminder]()
    
    
    /**
     adds a new reminder to the list
     */
    func addReminder(reminder:Reminder){
        self.listOfReminders.append(reminder)
    }
    
    /**
     Sort items based on their Date
     */
    func sortReminders(){
        self.listOfReminders.sort(by: {value1,value2 in return value1.reminderDate<value2.reminderDate})
    }
}
