//
//  LessonDaysViewController.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 13.09.2023.
//

import UIKit

class LessonDaysViewController: UITableViewController {
    
    var selectedDays: [Days] = []
    
    weak var delegate: LessonDaysDelegate?
    
    private let days = Days.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.delegate?.updateLessonDays(lessonDays: self.selectedDays)
    }
    
    deinit {
        print("LessonDaysViewController deinit")
    }
}

//MARK: Table View
extension LessonDaysViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.days.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let entity = self.days[indexPath.row]
        
        if selectedDays.contains(entity) {
            cell.accessoryType = .checkmark
        }
        
        cell.textLabel?.text = self.days[indexPath.row].rawValue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.tableView.cellForRow(at: indexPath) else { return }
        let item = days[indexPath.row]
        
        //append day
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            
            self.selectedDays.append(item)
        } else {
            //delete day
            
            cell.accessoryType = .none
            self.selectedDays = self.selectedDays.filter { $0 != item }
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
