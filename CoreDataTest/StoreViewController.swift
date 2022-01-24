//
//  StoreViewController.swift
//  CoreDataTest
//
//  Created by JeongTaek Han on 2022/01/24.
//

import UIKit
import CoreData

class StoreViewController: UIViewController {
    
    
    @IBOutlet weak var passageTextField: UITextField!
    @IBOutlet weak var kindSegmentControl: UISegmentedControl!
    
    var form: JokeModel {
        JokeModel(
            id: UUID(),
            category: kindSegmentControl.currentText,
            content: passageTextField.text ?? ""
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        saveData()
        dismiss(animated: true)
        
    }
    
    private func saveData() {
        let context = PersistenceManager.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Joke", in: context) else {
            return
        }
        
        let joke = NSManagedObject(entity: entity, insertInto: context)
        joke.setValue(form.id, forKey: "id")
        joke.setValue(form.category.kind, forKey: "category")
        joke.setValue(form.content, forKey: "body")
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
}


fileprivate extension UISegmentedControl {
    
    var currentText: Category {
        let currentIndex = self.selectedSegmentIndex
        let title = self.titleForSegment(at: currentIndex)
        let category = Category(kind: title ?? "")
        return category
    }
    
}
