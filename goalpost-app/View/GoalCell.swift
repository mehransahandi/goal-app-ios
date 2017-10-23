//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Caleb Stultz on 7/31/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var complitionView: UIView!
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    @IBOutlet weak var ComplitionLBL: UILabel!
    
    func configureCell(goal : Goal) {
        self.goalDescriptionLbl.text = goal.goalDescription
        self.goalTypeLbl.text = goal.goalType
        self.goalProgressLbl.text = String(describing : goal.goalProgress)
        
        
        if goal.goalProgress == goal.goalCompletionValue {
            
            self.complitionView.isHidden = false
            self.ComplitionLBL.isHidden = false
            
        } else {
            self.ComplitionLBL.isEnabled = true
            self.complitionView.isHidden = true
        }
    }
    
}
