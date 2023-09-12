//
//  Date.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 12.09.2023.
//

import Foundation

extension Date {
    func stringTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        let result = dateFormatter.string(from: self)
        
        return result
    }
}
