//
//  MainViewController.swift
//  OralHygienePro
//
//  Created by Gefei Wang on 7/16/20.
//  Copyright © 2020 Gefei Wang. All rights reserved.
//

import UIKit

class HabitsTableViewController: UITableViewController {
    private var persistence = PersistenceLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        tableView.register(
                    HabitTableViewCell.nib,
                    forCellReuseIdentifier: HabitTableViewCell.identifier
        )

        // Do any additional setup after loading the view.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

      return persistence.habits.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell
    {

     let cell = tableView.dequeueReusableCell(
          withIdentifier: HabitTableViewCell.identifier,
          for: indexPath
      ) as! HabitTableViewCell
    let habit = persistence.habits[indexPath.row]
    cell.configure(habit)
      return cell
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           persistence.setNeedsToReloadHabits()
           tableView.reloadData()
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

         let selectedHabit = persistence.habits[indexPath.row]
         let habitDetailVC = HabitDetailedViewController.instantiate()
         habitDetailVC.habit = selectedHabit
         habitDetailVC.habitIndex = indexPath.row
         navigationController?.pushViewController(habitDetailVC, animated: true)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      switch editingStyle {
        case .delete:
          let habitToDelete = persistence.habits[indexPath.row]
          let habitIndexToDelete = indexPath.row

          let deleteAlert = UIAlertController(habitTitle: habitToDelete.title) {
            self.persistence.delete(habitIndexToDelete)
            tableView.deleteRows(at: [indexPath], with: .automatic)
          }

          self.present(deleteAlert, animated: true)
        default:
          break
        }
    }
}
extension HabitsTableViewController {

    func setupNavBar() {
        title = "Oral Hygiene Pro"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddHabit(_:)))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = self.editButtonItem
    }

    @objc func pressAddHabit(_ sender: UIBarButtonItem) {
        let addHabitVC = AddHabitViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: addHabitVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)

    }
}
extension UIAlertController {
    convenience init(habitTitle: String, comfirmHandler: @escaping () -> Void) {
        self.init(title: "Delete Habit", message: "Are you sure you want to delete \(habitTitle)?", preferredStyle: .actionSheet)

        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            comfirmHandler()
        }
        self.addAction(confirmAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        self.addAction(cancelAction)
    }
}
