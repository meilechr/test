//
//  LoginViewController.swift
//  CustomLogin
//
//  Created by Chris Meile on 2020-06-08.
//  Copyright © 2020 Chris Meile. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailNameTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements(){
        //Hide Error Label
        errorLabel.alpha = 0
        
        // Style
        Utilities.styleTextField(emailNameTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // Validate Text Fields -- TODO check errors
        
        let email = emailNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            
            if error != nil{
                // could not sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
                
            } else {
                
                // have to use self in closure
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                       
                       
                       
                       // Makes the home view controller new root view controller
                self.view.window?.rootViewController = homeViewController
                       
                       //Shows new home view controller as root controller
                self.view.window?.makeKeyAndVisible()
                
            }
        }
        
        
    }
    
    

}
