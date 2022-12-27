//
//  ViewController.swift
//  FirstCoreData
//
//  Created by Sang Hyeon kim on 2022/12/27.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var context: NSManagedObjectContext {
        guard let app = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        
        return app.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var age: UITextField!
    
    @IBAction func createEntity(_ sender: Any) {
        guard let name = name.text else { return }
        guard let age = age.text else { return }
        
        
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context)
        newEntity.setValue(name, forKey: "name")
        newEntity.setValue(Int(age), forKey: "age")
        
        if context.hasChanges {
            do {
                try context.save()
                print("saved")
            } catch {
                print(error)
            }
        }
        
        self.name.text = nil;
        self.age.text = nil;
        
    }
    
    @IBAction func readEntity(_ sender: Any) {
        let request = NSFetchRequest<NSManagedObject> (entityName: "Person")
        do {
            let list = try context.fetch(request)
            if let first = list.first {
                self.name.text = first.value(forKey: "name") as? String
                if let age = first.value(forKey: "age") as? Int {
                    self.age.text = "\(age)"
                }
                
                editTarget = first
            } else {
                print("Not Found")
            }
        } catch  {
            print(error)
        }
    }
    
    var editTarget: NSManagedObject?
    
    @IBAction func updateEntity(_ sender: Any) {
        guard let name = name.text else { return }
        guard let age = age.text else { return }
        
        if let target = editTarget {
            target.setValue(name, forKey: "name")
            target.setValue(Int(age), forKey: "age")
        }
        
        if context.hasChanges {
            do {
                try context.save()
                print("saved")
            } catch {
                print(error)
            }
        }
        
        self.name.text = nil;
        self.age.text = nil;
    }
    
    @IBAction func DeleteEntity(_ sender: Any) {
        if let target = editTarget {
            context.delete(target)
        }
        if context.hasChanges {
            do {
                try context.save()
                print("delete")
            } catch {
                print(error)
            }
        }
        
        self.name.text = nil;
        self.age.text = nil;
        
    }
    
}

