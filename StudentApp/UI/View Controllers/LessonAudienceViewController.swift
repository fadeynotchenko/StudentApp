//
//  LessonAudienceViewController.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 10.09.2023.
//

import UIKit

class LessonAudienceViewController: UITableViewController {
    
    var currentAudience: LessonAudience?
    
    weak var delegate: LessonAudienceDelegate?
    
    private var audience: [LessonAudience]? = PersistenceController.shared.fetchObjects(entityName: "LessonAudience")

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("LessonAudienceViewController deinit")
    }
    
    
    @IBAction func addAudience(_ sender: Any) {
        let alert = UIAlertController(title: "Новая аудитория", message: nil, preferredStyle: .alert)
        alert.view.tintColor = .accent
        
        alert.addTextField { tf in
            tf.keyboardType = .numberPad
            tf.placeholder = "Номер аудитории"
        }
        
        alert.addTextField { tf in
            tf.keyboardType = .numberPad
            tf.placeholder = "Этаж"
        }
        
        alert.addTextField { tf in
            tf.keyboardType = .numberPad
            tf.placeholder = "Корпус (необязательно)"
        }
        
        let cancel = UIAlertAction(title: "Закрыть", style: .destructive)
        
        let save = UIAlertAction(title: "Добавить", style: .default) { (alertAction) in
            
            let numberTF = alert.textFields![0] as UITextField
            let floorTF = alert.textFields![1] as UITextField
            let frameTF = alert.textFields![2] as UITextField
            
            if let number = numberTF.text, let floor = floorTF.text {
                //Add new LessonAudience Entity
                let lessonAudienceEntity = LessonAudience(context: PersistenceController.shared.context)
                
                lessonAudienceEntity.number = Int16(number) ?? 0
                lessonAudienceEntity.floor = Int16(floor) ?? 0
                
                if let frame = frameTF.text, frame != "" {
                    lessonAudienceEntity.frame = Int16(frame) ?? 0
                }
                
                PersistenceController.shared.saveContext()
                
                //update UI
                self.audience?.append(lessonAudienceEntity)
                
                self.tableView.reloadData()
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(save)
        
        self.present(alert, animated: true)
    }
}

//MARK: Table VC
extension LessonAudienceViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.audience?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let entity = self.audience![indexPath.row]
        
        if self.currentAudience == entity {
            cell.accessoryType = .checkmark
        }
        
        var text = "№ \(entity.number), этаж: \(entity.floor)"
        
        if entity.frame != 0 {
            text.append(", корпус: \(entity.frame)")
        }
        
        cell.textLabel?.text = text
        cell.backgroundColor = .secondarySystemBackground
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entity = self.audience![indexPath.row]
        
        self.delegate?.updateLessonAudience(lessonAudienceEntity: entity)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, success in
            let entity = self.audience![indexPath.row]
            
            if entity == self.currentAudience {
                self.delegate?.updateLessonAudience(lessonAudienceEntity: nil)
            }
            
            //update UI
            self.audience = self.audience?.filter { $0 != entity }
            
            self.tableView.reloadDataWithAnimation()
            
            PersistenceController.shared.context.delete(entity)
            PersistenceController.shared.saveContext()
            
            success(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
