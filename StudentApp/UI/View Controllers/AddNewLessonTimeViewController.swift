//
//  AddNewLessonDateViewController.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 12.09.2023.
//

import UIKit

class AddNewLessonTimeViewController: UITableViewController {

    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    weak var delegate: AddLessonTimeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDatePickers()
    }
    
    deinit {
        print("AddNewLessonTimeViewController deinit")
    }

    @IBAction func saveNewTime(_ sender: Any) {
        let lessonTime = LessonTime(context: PersistenceController.shared.context)
        lessonTime.start = self.startDatePicker.date
        lessonTime.end = self.endDatePicker.date
        
        PersistenceController.shared.saveContext()
        
        self.delegate?.add(new: lessonTime)
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddNewLessonTimeViewController {
    private func setupDatePickers() {
        //MARK: Start
        let startDate = Date()
        self.startDatePicker.setDate(startDate, animated: false)
        self.startDatePicker.addTarget(self, action: #selector(onStartDateUpdate(_:)), for: .valueChanged)
        
        //MARK: End
        let endDate = Calendar.current.date(byAdding: .minute, value: 40, to: startDate)!
        self.endDatePicker.setDate(endDate, animated: false)
        self.endDatePicker.addTarget(self, action: #selector(onEndDateUpdate(_:)), for: .valueChanged)
    }
    
    @objc private func onStartDateUpdate(_ datePicker: UIDatePicker) {
        if datePicker.date > self.endDatePicker.date {
            self.startDatePicker.setDate(endDatePicker.date, animated: true)
        }
    }
    
    @objc private func onEndDateUpdate(_ datePicker: UIDatePicker) {
        if datePicker.date < self.startDatePicker.date {
            self.endDatePicker.setDate(startDatePicker.date, animated: true)
        }
    }
}
