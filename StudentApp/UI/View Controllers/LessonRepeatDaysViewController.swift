//
//  LessonRepeatDaysViewController.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 14.09.2023.
//

import UIKit

class LessonRepeatDaysViewController: UITableViewController {
    
    var currentRepeat: LessonRepeat?
    
    weak var delegate: LessonRepeatDelegate?
    
    private let repeats = Repeats.allCases
    private let weekTypes = Repeats.WeekType.allCases
    
    private var currentRepeatIndex: Int16 = 0
    private var currentWeekTypeIndex: Int16 = 0
    
    deinit {
        print("LessonRepeatDaysViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentRepeatIndex = self.currentRepeat?.repeatIndex ?? 0
        self.currentWeekTypeIndex = self.currentRepeat?.weakTypeIndex ?? 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.saveLessonRepeatEntity()
    }
}

//MARK: Table View
extension LessonRepeatDaysViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.currentRepeatIndex == 1 {
            return 2
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repeats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.section == 0 {
            let item = self.repeats[indexPath.row]
            
            cell.textLabel?.text = item.rawValue
            
            if self.currentRepeatIndex == indexPath.row {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
        } else {
            let item = self.weekTypes[indexPath.row]
            
            
            cell.textLabel?.text = item.rawValue
            
            if self.currentWeekTypeIndex == indexPath.row {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.currentRepeatIndex = Int16(indexPath.row)
        } else {
            self.currentWeekTypeIndex = Int16(indexPath.row)
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.reloadDataWithAnimation()
    }
}

extension LessonRepeatDaysViewController {
    private func saveLessonRepeatEntity() {
        let lessonRepeatEntity = LessonRepeat(context: PersistenceController.shared.context)
        
        lessonRepeatEntity.repeatIndex = self.currentRepeatIndex
        lessonRepeatEntity.weakTypeIndex = self.currentWeekTypeIndex
        
        PersistenceController.shared.saveContext()
        
        self.delegate?.updateLessonRepeat(lessonRepeatEntity: lessonRepeatEntity)
    }
}
