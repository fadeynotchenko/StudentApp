//
//  AddNewLessonViewController.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 07.09.2023.
//

import UIKit

class AddNewLessonViewController: UIViewController {
    
    @IBOutlet weak var selectLessonNameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewLessonSegue", let vc = segue.destination as? SelectLessonNameViewController {
            vc.delegate = self
        }
    }
}

extension AddNewLessonViewController: SelectLessonNameDelegate {
    func updateLessonName(name: String) {
        let attributedTitle = selectLessonNameButton.attributedTitle(for: .normal)
        attributedTitle?.setValue(name, forKey: "string")
        self.selectLessonNameButton.setAttributedTitle(attributedTitle, for: .normal)
        print(name)
    }
    
    
}
