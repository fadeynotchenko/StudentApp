//
//  UITableView.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 13.09.2023.
//

import UIKit

extension UITableView {
    func reloadDataWithAnimation() {
        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve) {
            self.reloadData()
        }
    }
}
