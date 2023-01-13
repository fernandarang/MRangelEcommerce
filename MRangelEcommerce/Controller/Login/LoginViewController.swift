//
//  LoginViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 12/01/23.
//

import UIKit
import FirebaseAuth

class LoginViewController : UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var CreateBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func LoginBtn(_ sender: UIButton) {
        
        if let email = EmailField.text, let password = PasswordField.text {
            Auth.auth().signIn(withEmail: email, password: password){ (result, error) in
                if let result = result, error == nil {
                    self.EmailField.text = ""
                    self.PasswordField.text = ""
                    self.performSegue(withIdentifier: "LoginSegue", sender: self)
                }else{
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error al ingresar", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true)
                }
            }
        }
        
        
        
    }
    
    @IBAction func CreateBtn(_ sender: UIButton) {
    }
    
}
