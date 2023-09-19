//
//  Repeats.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 14.09.2023.
//

import Foundation

enum Repeats: String, CaseIterable {
    case none = "Нет"
    case week = "Раз в неделю"
    case month = "Раз в месяц"
    
    enum WeekType: String, CaseIterable {
        case even = "Нет"
        case odd = "Чётная"
        case none = "Нечётная"
    }
}

