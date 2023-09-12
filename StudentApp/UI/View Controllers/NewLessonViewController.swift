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
    private var lessonAudienceEntity: LessonAudience?
    private var lessonTimeEntity: LessonTime?

    @IBOutlet weak var lessonNameCell: UITableViewCell!
    @IBOutlet weak var lessonTeacherCell: UITableViewCell!
    @IBOutlet weak var lessonAudienceCell: UITableViewCell!
    @IBOutlet weak var lessonTimeCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("AddNewLessenViewController deinit")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? LessonNameViewController, segue.identifier == SegueIdentifiers.LESSON_NAME {
            vc.delegate = self
            vc.currentLessonNameEntity = self.lessonNameEntity
        }
        
        if let vc = segue.destination as? LessonTeacherViewController, segue.identifier == SegueIdentifiers.LESSON_TEACHER {
            vc.delegate = self
            vc.currentTeacher = self.lessonTeacherEntity
        }
        
        if let vc = segue.destination as? LessonAudienceViewController, segue.identifier == SegueIdentifiers.LESSON_AUDIENCE {
            vc.delegate = self
            vc.currentAudience = self.lessonAudienceEntity
        }
        
        if let vc = segue.destination as? LessonTimeViewController, segue.identifier == SegueIdentifiers.LESSON_TIME {
            vc.delegate = self
            vc.currentLessonTime = self.lessonTimeEntity
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
    func updateLessonTeacher(lessonTeacherEntity: LessonTeacher?) {
        self.lessonTeacherEntity = lessonTeacherEntity
        
        guard let lessonTeacherEntity = lessonTeacherEntity else {
            self.lessonTeacherCell.textLabel?.text = "Преподаватель"
            
            return
        }
        
        self.lessonTeacherCell.textLabel?.text = lessonTeacherEntity.name
    }
}

//MARK: Lesson Audience Delegate
extension NewLessonViewController: LessonAudienceDelegate {
    func updateLessonAudience(lessonAudienceEntity: LessonAudience?) {
        self.lessonAudienceEntity = lessonAudienceEntity
        
        guard let entity = lessonAudienceEntity else {
            self.lessonAudienceCell.textLabel?.text = "Аудитория"
            
            return
        }
        
        var text = "№ \(entity.number), этаж: \(entity.floor)"
        
        if let frame = lessonAudienceEntity?.frame, frame != 0 {
            text.append(", корпус: \(frame)")
        }
            
        self.lessonAudienceCell.textLabel?.text = text
    }
}

//MARK: Lesson Time Delegate
extension NewLessonViewController: LessonTimeDelegate {
    func updateLessonTime(lessonTimeEntity: LessonTime?) {
        self.lessonTimeEntity = lessonTimeEntity
        
        guard let lessonTimeEntity = lessonTimeEntity else {
            self.lessonTimeCell.textLabel?.text = "Время"
            
            return
        }
        
        self.lessonTimeCell.textLabel?.text = "\(lessonTimeEntity.start!.stringTime()) - \(lessonTimeEntity.end!.stringTime())"
    }
}
