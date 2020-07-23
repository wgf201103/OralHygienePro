//
//  HabitTableViewCell.swift
//  OralHygienePro
//
//  Created by Gefei Wang on 7/16/20.
//  Copyright © 2020 Gefei Wang. All rights reserved.
//

import UIKit

class HabitTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var labelHabitTitle: UILabel!
    
    @IBOutlet weak var labelStreaks: UILabel!
    
    // Set the identifier for the custom cell
    static let identifier = "HabitCell"

    // Returning the xib file after instantiating it
    static var nib: UINib {
           return UINib(nibName: String(describing: self), bundle: nil)
    }
    // configure medthod
    
    func configure(_ habit: Habit) {
      self.labelHabitTitle.text = habit.title
      self.labelStreaks.text = "streak: \(habit.currentStreak)"

      if habit.completedToday {
        self.accessoryType = .checkmark
      } else {
       self.accessoryType = .disclosureIndicator
      }
    }
}
