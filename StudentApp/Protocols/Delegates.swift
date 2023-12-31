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

protocol LessonTimeDelegate: AnyObject {
    func updateLessonTime(lessonTimeEntity: LessonTime?)
}

protocol AddLessonTimeDelegate: AnyObject {
    func add(new lessonTimeEntity: LessonTime)
}

protocol LessonDaysDelegate: AnyObject {
    func updateLessonDays(lessonDays: [Days])
}

protocol LessonRepeatDelegate: AnyObject {
    func updateLessonRepeat(lessonRepeatEntity: LessonRepeat?)
}
