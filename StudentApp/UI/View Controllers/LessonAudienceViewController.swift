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
        
        let cancel = UIAlertAction(title: "Закрыть", style: .destructive)
        
        let save = UIAlertAction(title: "Добавить", style: .default) { (alertAction) in
            
            let numberTF = alert.textFields![0] as UITextField
            let floorTF = alert.textFields![1] as UITextField
            
            if let number = numberTF.text, let floor = floorTF.text {
                //Add new LessonAudience Entity
                let lessonAudienceEntiry = LessonAudience(context: PersistenceController.shared.context)
                lessonAudienceEntiry.number = Int16(number) ?? 0
                lessonAudienceEntiry.floor = Int16(floor) ?? 0
                
                PersistenceController.shared.saveContext()
                
                //update UI
                self.audience?.append(lessonAudienceEntiry)
                self.tableView.reloadData()
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(save)
        
        self.present(alert, animated: true)
    }
}

//MARK: Table View
extension LessonAudienceViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.audience?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let entity = self.audience![indexPath.row]
        
        if self.currentAudience == entity {
            cell.accessoryType = .checkmark
        }
        
        cell.textLabel?.text = "№ \(entity.number), этаж: \(entity.floor)"
        cell.backgroundColor = .secondarySystemBackground
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entity = self.audience![indexPath.row]
        
        self.delegate?.updateLessonAudience(lessonAudienceEntity: entity)
        
        self.navigationController?.popViewController(animated: true)
    }
}
