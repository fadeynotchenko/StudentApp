//
//  AddNewLessonDeleate.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 08.09.2023.
//

import UIKit

protocol LessonNameDelegate: AnyObject {
    func updateLessonName(lessonNameEntity: LessonName?)
}

protocol LessonTeacherDelegate: AnyObject {
    func updateLessonName(lessonTeacherEntity: LessonTeacher?)
}
