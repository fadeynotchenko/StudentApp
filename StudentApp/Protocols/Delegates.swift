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
    func updateLessonTeacher(lessonTeacherEntity: LessonTeacher?)
}

protocol LessonAudienceDelegate: AnyObject {
    func updateLessonAudience(lessonAudienceEntity: LessonAudience?)
}

protocol LessonDateDelegate: AnyObject {
    func updateLessonDate(lessonDateEntity: LessonDate?)
}
