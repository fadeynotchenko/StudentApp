//
//  AddNewLessenTableViewController.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 08.09.2023.
//

import UIKit

class NewLessonViewController: UITableViewController {
    
    private var lessonNameEntity: LessonName?
    private var lessonTeacherEntity: LessonTeacher?

    @IBOutlet weak var lessonNameCell: UITableViewCell!
    @IBOutlet weak var lessonTeacherCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("AddNewLessenViewController deinit")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? LessonNameViewController, segue.identifier == "selectLessonNameSegue" {
            vc.delegate = self
            vc.currentLessonNameEntity = self.lessonNameEntity
        }
        
        if let vc = segue.destination as? LessonTeacherViewController, segue.identifier == "selectLessonTeacherSegue" {
            vc.delegate = self
            vc.currentTeacher = self.lessonTeacherEntity
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

//MARK: Lesson Name Delegate
extension NewLessonViewController: LessonNameDelegate {
    func updateLessonName(lessonNameEntity: LessonName?) {
        self.lessonNameEntity = lessonNameEntity
        
        guard let lessonNameEntity = lessonNameEntity else {
            self.lessonNameCell.textLabel?.text = "Название"
            
            return
        }
        
        self.lessonNameCell.textLabel?.text = lessonNameEntity.name
    }
}

//MARK: Lesson Teacher Delegate
extension NewLessonViewController: LessonTeacherDelegate {
    func updateLessonName(lessonTeacherEntity: LessonTeacher?) {
        self.lessonTeacherEntity = lessonTeacherEntity
        
        guard let lessonTeacherEntity = lessonTeacherEntity else {
            self.lessonTeacherCell.textLabel?.text = "Преподаватель"
            
            return
        }
        
        self.lessonTeacherCell.textLabel?.text = lessonTeacherEntity.name
    }
}
