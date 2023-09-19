//
//  LessonNameViewController.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 08.09.2023.
//

import UIKit

class LessonNameViewController: UITableViewController {
    
    var currentLessonNameEntity: LessonName?
    
    private var names: [LessonName]? = PersistenceController.shared.fetchObjects(entityName: "LessonName")
    
    weak var delegate: LessonNameDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("LessonNameViewController deinit")
    }
    
    @IBAction func addLessonName(_ sender: Any) {
        let alert = UIAlertController(title: "Новый предмет", message: nil, preferredStyle: .alert)
        alert.view.tintColor = .accent
        
        let cancel = UIAlertAction(title: "Закрыть", style: .destructive)
        
        let save = UIAlertAction(title: "Добавить", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            
            if let text = textField.text {
                //Add new LessonName Entity
                let lessonNameEntity = LessonName(context: PersistenceController.shared.context)
                lessonNameEntity.name = text
                
                PersistenceController.shared.saveContext()
                
                //update UI
                self.names?.append(lessonNameEntity)
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField()
        alert.addAction(cancel)
        alert.addAction(save)
        
        self.present(alert, animated: true)
    }
}

//MARK: Table VC
extension LessonNameViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let lessonEntity = self.names?[indexPath.row]
        
        if lessonEntity == self.currentLessonNameEntity {
            cell.accessoryType = .checkmark
        }
        
        cell.textLabel?.text = lessonEntity?.name
        cell.backgroundColor = .secondarySystemBackground
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let lessonNameEntity = names?[indexPath.row] else { return }
        
        self.delegate?.updateLessonName(lessonNameEntity: lessonNameEntity)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, success in
            let entity = self.names![indexPath.row]
            
            if entity == self.currentLessonNameEntity {
                self.delegate?.updateLessonName(lessonNameEntity: nil)
            }
            
            //update UI
            self.names = self.names?.filter { $0 != entity }
            
            self.tableView.reloadDataWithAnimation()
            
            PersistenceController.shared.context.delete(entity)
            PersistenceController.shared.saveContext()
            
            success(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
