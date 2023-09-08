//
//  SelectLessonNameViewController.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 07.09.2023.
//

import UIKit
import CoreData

class SelectLessonNameViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var data = PersistenceController.shared.getLessonNameEntityArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    deinit {
        print("SelectLessonNameViewController deinit")
    }
    
    weak var delegate: SelectLessonNameDelegate?
    
    @IBAction func addNewLesson(_ sender: Any) {
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
                self.delegate?.updateLessonName(name: text)
                
                self.data?.append(lessonNameEntity)
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField()
        alert.addAction(cancel)
        alert.addAction(save)
        
        self.present(alert, animated: true)
    }
}

extension SelectLessonNameViewController {
    private func setupView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension SelectLessonNameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data![indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let name = data![indexPath.row].name else { return }
        
        self.delegate?.updateLessonName(name: name)
        
        self.navigationController?.popViewController(animated: true)
    }
}
