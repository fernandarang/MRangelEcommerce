//
//  SigninViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 12/01/23.
//

import Foundation
import UIKit
import FirebaseAuth

class SigninViewController : UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var EmailField: UITextField!
    
    @IBOutlet weak var PasswordField: UITextField!
    
    @IBOutlet weak var ConfirmPassField: UITextField!
    
    @IBOutlet weak var SigninBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func SigninBtn(_ sender: UIButton) {
        
        if let email = EmailField.text, let password = PasswordField.text {
                Auth.auth().createUser(withEmail: email, password: password){ (result, error) in
                
                if let result = result, error == nil {
                    let alert = UIAlertController(title: "Confirmación", message: "Usuario registrado correctamente", preferredStyle: .alert)
                    let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                                                    { action in
                        self.EmailField.text = ""
                        self.PasswordField.text = ""
                        
                    })
                    alert.addAction(Aceptar)
                    self.present(alert, animated: false)
                }else{
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error registrando el usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true)
                }
            }
        }
    }
}
