//
//  PersistenceLayer.swift
//  OralHygienePro
//
//  Created by Gefei Wang on 7/16/20.
//  Copyright © 2020 Gefei Wang. All rights reserved.
//

import Foundation
struct PersistenceLayer {

    // Step 1
    private(set) var habits: [Habit] = []

    // Step 2
    private static let userDefaultsHabitsKeyValue = "HABITS_ARRAY"

    init() {
        // Step 3
        self.loadHabits()
    }
    // Step 4
    private mutating func loadHabits() {

        // Step 5
        let userDefaults = UserDefaults.standard

        // Step 6
        guard
            let habitData = userDefaults.data(forKey: PersistenceLayer.userDefaultsHabitsKeyValue),
            let habits = try? JSONDecoder().decode([Habit].self, from: habitData) else {
                return
        }

        self.habits = habits
    }
    // Step 7
    @discardableResult

       // Step 8
       mutating func createNewHabit(name: String) -> Habit {

           let newHabit = Habit(title: name)
           self.habits.insert(newHabit, at: 0) // Prepend the habits to the array
           self.saveHabits()

           return newHabit
       }
    private func saveHabits() {
        // Step 9
        guard let habitsData = try? JSONEncoder().encode(self.habits) else {
            fatalError("could not encode list of habits")
        }

        // Step 10
        let userDefaults = UserDefaults.standard
        userDefaults.set(habitsData, forKey: PersistenceLayer.userDefaultsHabitsKeyValue)
        userDefaults.synchronize()

    }
    // Step 11
    mutating func delete(_ habitIndex: Int) {
        // Remove habit at the given index
        self.habits.remove(at: habitIndex)

        // Persist the changes we made to our habits array
        self.saveHabits()
    }
    mutating func markHabitAsCompleted(_ habitIndex: Int) -> Habit {

       // Step 12
        var updatedHabit = self.habits[habitIndex]

       // Step 13
        guard updatedHabit.completedToday == false else { return updatedHabit }

        updatedHabit.numberOfCompletions += 1

        // Step 14
        if let lastCompletionDate = updatedHabit.lastCompletionDate, lastCompletionDate.isYesterday {
            updatedHabit.currentStreak += 1
        } else {
            updatedHabit.currentStreak = 1
        }

        // Step 15
        if updatedHabit.currentStreak > updatedHabit.bestStreak {
            updatedHabit.bestStreak = updatedHabit.currentStreak
        }

        // Step 16
        let now = Date()
        updatedHabit.lastCompletionDate = now

        // Step 17
        self.habits[habitIndex] = updatedHabit

        // Step 18
        self.saveHabits()
        return updatedHabit
    }
    // Step 19
     mutating func swapHabits(habitIndex: Int, destinationIndex: Int) {
            let habitToSwap = self.habits[habitIndex]
            self.habits.remove(at: habitIndex)
            self.habits.insert(habitToSwap, at: destinationIndex)
            self.saveHabits()
        }

    // Step 20
     mutating func setNeedsToReloadHabits() {
            self.loadHabits()
    }
}
