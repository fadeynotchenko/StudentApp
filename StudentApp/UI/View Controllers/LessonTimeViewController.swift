//
//  LessonDateViewController.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 12.09.2023.
//

import UIKit

class LessonTimeViewController: UITableViewController {
    
    var currentLessonTime: LessonTime?
    
    weak var delegate: LessonTimeDelegate?
    
    private var times: [LessonTime]? = PersistenceController.shared.fetchObjects(entityName: "LessonTime")

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("LessonTimeViewController deinit")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddNewLessonTimeViewController, segue.identifier == SegueIdentifiers.LESSON_ADD_TIME {
            vc.delegate = self
        }
    }
}

//MARK: Table View
extension LessonTimeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.times?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let entity = self.times![indexPath.row]
        
        if entity == self.currentLessonTime {
            cell.accessoryType = .checkmark
        }
        
        cell.textLabel?.text = "\(entity.start!.stringTime()) - \(entity.end!.stringTime())"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entity = self.times![indexPath.row]
        
        self.delegate?.updateLessonTime(lessonTimeEntity: entity)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, success in
            let entity = self.times![indexPath.row]
            
            self.times = self.times?.filter { $0 != entity }
            
            PersistenceController.shared.context.delete(entity)
            PersistenceController.shared.saveContext()
            
            self.tableView.reloadDataWithAnimation()
            
            success(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: Add New Time delegate
extension LessonTimeViewController: AddLessonTimeDelegate {
    func add(new lessonTimeEntity: LessonTime) {
        self.times?.append(lessonTimeEntity)
        
        self.tableView.reloadData()
    }
}
