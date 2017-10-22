//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Caleb Stultz on 7/31/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import UIKit
import CoreData


class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTextField.delegate = self
    }

    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        // Pass data into Core Data Goal Model
        
       if pointsTextField.text != ""
       {
        self.save{(complete) in
            if complete {dismiss(animated: true, completion: nil)}
        }
        
        }
        
        
        
    }
    @IBAction func backBTN(_ sender: Any) {
       dismissDetail() // same dismiss
        
    }
    
    func save(complition: (_ finished: Bool)->() ) {
        guard let managedContex = appDelegate?.persistentContainer.viewContext else {return }
        let goal = Goal(context: managedContex)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContex.save()
            complition(true)
            print(" data save done ")
        }
        catch {
            debugPrint("could not save:\(error.localizedDescription)")
            complition (false)
        }
        
        
    }
}
