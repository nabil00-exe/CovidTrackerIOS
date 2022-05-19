//
//  ViewController.swift
//  CovidTracker
//
//  Created by Mac-Mini_2021 on 12/04/2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    //var
    let userViewModel = UserViewModel()
    var email: String?
    
    
    
    //widget
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        if(emailTF.text!.isEmpty || passwordTF.text!.isEmpty) {
            return
        }
        
        userViewModel.authenticate(email: emailTF.text!, password: passwordTF.text!,completed: { (success, reponse) in
            
            
            if success {
                self.performSegue(withIdentifier: "homepage", sender: nil)
            } else {
                print("Wrong credentials!")
                return
            }
        })
        
    }
    @IBAction func signupButton(_ sender: Any) {
        performSegue(withIdentifier: "capturePass", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTF.showDoneButtonOnKeyboard()
        emailTF.showDoneButtonOnKeyboard()
        emailTF.text = email
    }

}


extension UITextField {
    func showDoneButtonOnKeyboard(){
        let flexSpace = UIBarButtonItem  (barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resignFirstResponder))
        
    var toolBarItems = [UIBarButtonItem]()
        toolBarItems.append(flexSpace)
        toolBarItems.append(doneButton)
        
    let doneToolbar =  UIToolbar()
        doneToolbar.items = toolBarItems
        doneToolbar.sizeToFit()
        
        inputAccessoryView = doneToolbar
        
    }
}

