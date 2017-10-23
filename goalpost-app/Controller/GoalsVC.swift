//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Caleb Stultz on 7/31/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import UIKit
import CoreData
// accessable from every VC
let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var goals : [Goal]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       fetchCoreDataObject()
        tableView.reloadData()
    }
    
    
    func fetchCoreDataObject () {
        
        self.fetch{(complete) in
            if complete{
                if goals.count >= 1 {
                    
                    tableView.isHidden = false
                    
                } else {tableView.isHidden = true }
                
            }
            
        }
    }

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        presentDetail(createGoalVC)
    }
    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal : goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowACtion, indexPath) in
             self.removeGoal(atindexpath: indexPath)
            self.fetchCoreDataObject()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        // add ation add to tableview
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowACtion, indexPath) in
            self.setProgress(atIndexPath:indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return [deleteAction, addAction]
    }
    
}

extension GoalsVC{
    
    func setProgress (atIndexPath indexPath: IndexPath){
         guard let managedContx = appDelegate?.persistentContainer.viewContext else {return}
        
        let chocenGoal = goals[indexPath.row]
        if chocenGoal.goalProgress < chocenGoal.goalCompletionValue {
            chocenGoal.goalProgress = chocenGoal.goalProgress+1
            
        }else { return }
        
        do {
            try
                managedContx.save()
            print("done")
            
        }catch {
            debugPrint("could not do:\(error.localizedDescription)")
        }
        
      
        
    }
    
    // remove function
    func removeGoal (atindexpath indexpath: IndexPath) {
        
        guard let managedContx = appDelegate?.persistentContainer.viewContext else {return}
        managedContx.delete(goals[indexpath.row])
        
        do {
            
            try managedContx.save()
            print("remove done")
        } catch {
            
            debugPrint("couldnot delete :\(error.localizedDescription)")
        }
    }
    
    func fetch(comlition : (_ complete: Bool) -> ()) {
        guard let managedContx = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        
        do {
            goals = try managedContx.fetch(fetchRequest) as! [Goal]
        comlition (true)
        }
        catch {
            debugPrint("could not fetch :\(error.localizedDescription)")
            comlition (false)
            
        }
        
    }
    
}













