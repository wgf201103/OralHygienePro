//
//  AddHabitViewController.swift
//  OralHygienePro
//
//  Created by Gefei Wang on 7/16/20.
//  Copyright © 2020 Gefei Wang. All rights reserved.
//

import UIKit

class AddHabitViewController: UIViewController {

   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateUI()
    }

    private func updateUI() {
        title = "New Habit"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var habitNameInputField: UITextField!
    
    @IBAction func createHabitButtonPressed(_ sender: Any) {
        var persistenceLayer = PersistenceLayer()
               guard let habitText = habitNameInputField.text else { return }
               persistenceLayer.createNewHabit(name: habitText)
               self.presentingViewController?.dismiss(animated: true, completion: nil)
           
    }
}
