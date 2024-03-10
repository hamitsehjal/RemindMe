//
//  Reminder.swift
//  Reminder App
//
//  Created by Hamit Sehjal on 2024-03-07.
//

import Foundation

class Reminder{
    var title:String
    var description:String?
    var id:String
    var reminderDate:Date
    
    // designated initializer
    init(title: String, description: String? = nil, id: String, reminderDate: Date) {
        self.title = title
        self.description = description
        self.id = id
        self.reminderDate = reminderDate
    }
    
    
    
}


