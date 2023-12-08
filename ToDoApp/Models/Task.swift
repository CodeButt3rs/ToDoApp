//
//  Task.swift
//  ToDoApp
//
//  Created by Владислав Лесовой on 07.12.2023.
//

import Foundation
import SwiftData

@Model
class Task{
    var date: Date
    var name: String
    var details: String
    var completed: Bool
    var priority: Int
    
    init(date: Date = .now, name: String, details: String = "", completed: Bool = false, priority: Int = 0) {
        self.name = name
        self.details = details
        self.date = date
        self.completed = completed
        self.priority = priority
    }
}
