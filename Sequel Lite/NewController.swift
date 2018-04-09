//
//  NewController.swift
//  Sequel Lite
//
//  Created by alj on 4/9/18.
//  Copyright © 2018 Kyle Lee. All rights reserved.
//

import UIKit
import SQLite

class NewController: UIViewController {

    var database: Connection!
    var nName = [String]()
    let usersTable = Table("users")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    
    @IBOutlet weak var newnameinput: UITextField!
    
    @IBOutlet weak var newemailinput: UITextField!
    
    @IBAction func cancelAdd(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savenew(_ sender: UIBarButtonItem) {
        var newname = "";
        var newemail = "";
        
        newname = newnameinput.text!
        newemail = newemailinput.text!
        
        print(newname)
        print(newemail)
        
        if(newname != "" && newemail != ""){
            let submitnew = self.usersTable.insert(self.name <- newname, self.email <- newemail)
            print(submitnew)
            do {
                try self.database.run(submitnew)
                print("INSERTED USER")
                dismiss(animated: true, completion: nil)
//                _ = navigationController?.popViewController(animated: true)
//                if let nav = self.navigationController {
//                    nav.popViewController(animated: true)
//                } else {
//                    self.dismiss(animated: true, completion: nil)
//                }
                
            } catch {
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
