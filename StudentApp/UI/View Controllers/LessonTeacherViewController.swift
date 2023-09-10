//
//  NewLessonTeacherViewController.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 09.09.2023.
//

import UIKit

class LessonTeacherViewController: UITableViewController {
    
    var currentTeacher: LessonTeacher?
    
    private var teachers: [LessonTeacher]? = PersistenceController.shared.fetchObjects(entityName: "LessonTeacher")

    weak var delegate: LessonTeacherDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    deinit {
        print("LessonTeacherViewController deinit")
    }
    
    @IBAction func addTeacher(_ sender: Any) {
        let alert = UIAlertController(title: "Новый преподаватель", message: nil, preferredStyle: .alert)
        alert.view.tintColor = .accent
        
        let cancel = UIAlertAction(title: "Закрыть", style: .destructive)
        
        let save = UIAlertAction(title: "Добавить", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            
            if let text = textField.text {
                //Add new LessonTeacher Entity
                let lessonTeacherEntity = LessonTeacher(context: PersistenceController.shared.context)
                lessonTeacherEntity.name = text
                
                PersistenceController.shared.saveContext()
                
                //update UI
                self.teachers?.append(lessonTeacherEntity)
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField()
        alert.addAction(cancel)
        alert.addAction(save)
        
        self.present(alert, animated: true)
    }
}

extension LessonTeacherViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachers?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let teacher = self.teachers?[indexPath.row]
        
        if teacher == self.currentTeacher {
            cell.accessoryType = .checkmark
        }
        
        cell.textLabel?.text = teacher?.name
        cell.backgroundColor = .secondarySystemBackground
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lessonTeacherEntity = self.teachers?[indexPath.row]
        
        self.delegate?.updateLessonTeacher(lessonTeacherEntity: lessonTeacherEntity)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, success in
            let entity = self.teachers![indexPath.row]
            
            if entity == self.currentTeacher {
                self.delegate?.updateLessonTeacher(lessonTeacherEntity: nil)
            }
            
            //update UI
            self.teachers = self.teachers?.filter { $0 != entity }
            
            self.tableView.reloadData()
            
            PersistenceController.shared.context.delete(entity)
            PersistenceController.shared.saveContext()
            
            success(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
