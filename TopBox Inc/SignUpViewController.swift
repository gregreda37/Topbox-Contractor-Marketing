//
//  SignUpViewController.swift
//  TopBox Inc
//
//  Created by Gregory Reda on 8/14/19.
//  Copyright © 2019 TopBox Inc. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField:UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var firstName: UITextField!
    

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //do any additional setup after loading the view
        setUpElements()
    }
    func setUpElements(){
        errorLabel.alpha = 0
    }
    
    //check the fields and validate that the data is correct If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields()-> String?{
        //check that all fields are filled in
        if
            firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        //check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if forumUtilites.isPasswordValid(cleanedPassword) == false {
            //password isn't secured
            return "Please make sure your password is at least 8 characters, contrains a special character and a number"
        }
        
        
        return nil
        
    }
    
        
    
    @IBAction func signUpTapped(_ sender: Any) {
        //Validate the fields
        let error = validateFields()
        
        if error != nil{
            //there's something wrong with the fields, show error message
            showError(message: error!)
            
        }
        else{
            
            //Create cleaned versions of the data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let firstname = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password){(result,err) in
                
                //Check for errors
                if err != nil{
                    //there was an error creating the user
                    self.showError(message:"error creating user")
                }
                else {
                    //user was created successfully
                   let db = Firestore.firestore()
                    db.collection("users").addDocument(data:["firstname": firstname,"lastname": lastname,"uid":result!.user.uid]){(error) in
                        
                        if error != nil{
                            //show error message
                            self.showError( message: "User data be saved in Database")
                        }

                    }
                    
                    //transition to home screen
                    self.transitionToHome()
                        
                    }
                }
            
            
        }
      

}
    func showError( message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
        func transitionToHome(){
            let homeViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as?
            HomeViewController
            
            view.window?.rootViewController = homeViewController
            view.window?.makeKeyAndVisible()
            
        }
}

