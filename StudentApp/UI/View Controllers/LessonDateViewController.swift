//
//  LessonDateViewController.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 12.09.2023.
//

import UIKit

class LessonDateViewController: UITableViewController {
    
    var currentLessonDate: LessonDate?
    
    weak var delegate: LessonDateDelegate?
    
    private var dates: [LessonDate]? = PersistenceController.shared.fetchObjects(entityName: "LessonDate")

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? AddNewLessonDateViewController, segue.identifier == "addNewLessonDateSegue" {
//
//        }
//    }
}

//MARK: Table View
extension LessonDateViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dates?.count ?? 0
    }
}
