//
//  SignUpViewController.swift
//  CustomLogin
//
//  Created by Chris Meile on 2020-06-08.
//  Copyright © 2020 Chris Meile. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var completionHandler: ((String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        
        // Hiding Error Label
        errorLabel.alpha = 0
        
        // Styling Elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // Checks fields and validates that data is correct. If everything is correct, returns null. Else returns Error message as a string
    func validateFields() -> String?{
        
        // Check all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        // Check if the password is secure -> in utilities (existing func)
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(Utilities.isPasswordValid(cleanedPassword)) == false {
            //pass isnt secure enough
            return "Please ensure your password is at least 8 characters, contains a special character, and contains a number."
        }
        
        // ADD EMAIL FORMAT CHECK HERE
        return nil
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate Fields
        let error = validateFields()
        
        if error != nil{
            // there was an error in fields - show error message
            showError(error!)
            
        } else {
            
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the User
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    
                    self.showError("Error creating user")
                    
                } else {
                    
                    // User was created successfuly store first name last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname": firstName, "lastname": lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil{
                            
                            // Show error if there was one
                            self.showError("User could not be saved in database. Please contact support.")
                        }
                        
                    }
                    
                    // WORKING HERE ***** may be wrong one -> this has to be on the one that sends the data
                    self.completionHandler?(firstName)
                    
                    
                    // Transition ot home screen
                    self.transitionToHome()
                    
                }
            }

        }
        
    }
        
    
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    func transitionToHome(){
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        
        
        // Makes the home view controller new root view controller
        view.window?.rootViewController = homeViewController
        
        //Shows new home view controller as root controller
        view.window?.makeKeyAndVisible()
        
    }
    
}
