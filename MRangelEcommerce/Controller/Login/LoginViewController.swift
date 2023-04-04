//
//  LoginViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 12/01/23.
//

import UIKit
import FirebaseAuth
import LocalAuthentication
import Security

class LoginViewController : UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var CreateBtn: UIButton!
    
    let context = LAContext()
    var error : NSError?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loggear(_ sender: UIButton) {
        authenticate()
    }
    
    func authenticate() {
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error){
            
            let textReason = "Face ID access"
            
            if context.biometryType == .faceID {
                print("Face ID Biometrics")
            }else if context.biometryType == .touchID{
                print("Touch ID Biometrics")
            }else {
                print("No biometrics")
            }
            
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: textReason) { success, error in
                if success {
                    DispatchQueue.main.async {
                        self.get()
                        self.log()
                    }
                }
            }
        } else {
            print("No entro")
        }
    }
    
    
    @IBAction func LoginBtn(_ sender: UIButton) {
        log()
        save()
    }
    
    func log(){
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
    
    func save(){
        let username = "marifer@gmail.com"
        let password = "231200".data(using: .utf8)
        
        let attributes : [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : username,
            kSecValueData as String : password
        ]
        if SecItemAdd(attributes as CFDictionary, nil) == noErr{
            print("Guardada en keychain")
        }else{
            print("No guardado en keychain")
        }
    }
    
    func get(){
        let username = "marifer@gmail.com"
        
        let query : [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : username,
            kSecMatchLimit as String : kSecMatchLimitOne,
            kSecReturnAttributes as String : true,
            kSecReturnData as String : true
        ]
        var item: CFTypeRef?
        
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            
            if let existingItem = item as? [String: Any],
               let username = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8)
            {
                print(username)
                print(password)
                EmailField.text = username
                PasswordField.text = password
            }
        } else {
            print("Something went wrong trying to find the user in the keychain")
        }
    }
}
