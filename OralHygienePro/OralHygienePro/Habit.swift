//
//  Habit.swift
//  OralHygienePro
//
//  Created by Gefei Wang on 7/16/20.
//  Copyright © 2020 Gefei Wang. All rights reserved.
//

import Foundation

struct Habit:Codable {

    var title: String
    let dateCreated: Date=Date()
    var currentStreak: Int=0
    var bestStreak: Int=0
    var lastCompletionDate: Date?
    var numberOfCompletions: Int=0
    var completedToday: Bool {
        return lastCompletionDate?.isToday ?? false
        }
    init(title: String) {
        self.title = title
    }
}
