//
//  RegisterViewController.swift
//  CovidTracker
//
//  Created by Mac-Mini_2021 on 14/04/2022.
//

import UIKit

class RegisterViewController: UIViewController {

    //var
    var user: User?
    
    //Widget
    @IBOutlet weak var fullnameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullnameTF.showDoneButtonOnKeyboard()
        emailTF.showDoneButtonOnKeyboard()
        passwordTF.showDoneButtonOnKeyboard()        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewController
        destination.email = sender as? String
    }
    func saveEmail(email: String?) {
        self.performSegue(withIdentifier: "toLogin", sender: email)
    }
    @IBAction func signUpbtn(_ sender: Any) {
        if (fullnameTF.text!.isEmpty) {
            print("type your full name")
            return
        }
        if (emailTF.text!.isEmpty) {
            print("type your email")
            return
        }
        if (passwordTF.text!.isEmpty) {
            print("type your password")
            return
        }
        
        user?.name = fullnameTF.text
        user?.email = emailTF.text
        user?.password = passwordTF.text
        
        UserViewModel().register(user: user!, completed: {
            (success) in
            if success {
                let alert = UIAlertController(title: "Success", message: "Your account has been created.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                    self.saveEmail(email: self.user?.email)
                }
                alert.addAction(action)
                self.present(alert, animated: true)
            }
            else {
                print("account may already exists")
            }
        })
    }
    

}




