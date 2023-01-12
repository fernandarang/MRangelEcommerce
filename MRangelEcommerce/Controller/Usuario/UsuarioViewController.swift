//
//  UsuarioViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 06/01/23.
//

import UIKit

class UsuarioViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let usuarioViewModel = UsuarioViewModel()
    var usuarioModel : ModelUsuario? = nil
    var idUsuario : Int? = nil
    
    @IBOutlet weak var UserNameField: UITextField!
    @IBOutlet weak var NombreField: UITextField!
    @IBOutlet weak var ApellidoPaternoField: UITextField!
    @IBOutlet weak var ApellidoMaternoField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var SexoField: UITextField!
    @IBOutlet weak var TelefonoField: UITextField!
    @IBOutlet weak var CelularField: UITextField!
    @IBOutlet weak var CurpField: UITextField!
    @IBOutlet weak var FechaNacimiento: UIDatePicker!
    @IBOutlet weak var ImagenView: UIImageView!
    
    @IBOutlet weak var BtnImage: UIButton!
    @IBOutlet weak var BtnAcciones: UIButton!
    
    let imagePiker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePiker.delegate = self
        imagePiker.sourceType = .photoLibrary
        imagePiker.isEditing = false
        validar()
        }
    
    func validar(){
        if idUsuario == nil{
            BtnAcciones.setTitle("Agregar", for: .normal) //Mostrar boton que indique Agregar
            //Mostar el formulario vacio
            ImagenView.image = UIImage(named: "product")
        }else
        {
            BtnAcciones.setTitle("Actualizar", for: .normal)// Mostar buton que inque Actualizar
            let result = usuarioViewModel.GetById(IdUsuario: idUsuario!)//Uso del GetById
            if result.Correct{
                let usuario = result.Object as! ModelUsuario //Mostar el formulario precargado
                UserNameField.text = usuario.UserName
                NombreField.text = usuario.Nombre
                ApellidoPaternoField.text = usuario.ApellidoPaterdo
                ApellidoMaternoField.text = usuario.ApellidoMaterno
                EmailField.text = usuario.Email
                PasswordField.text = usuario.Password
                FechaNacimiento.date = usuario.FechaNacimiento
                SexoField.text = usuario.Sexo
                TelefonoField.text = usuario.Telefono
                CelularField.text = usuario.Celular
                CurpField.text = usuario.Curp
                if ImagenView.image == UIImage(named: "") {
                    ImagenView.image = UIImage(named: "product")
                }
                //else{
                //Convertir imagen de BASE64 a DATA
                //}
            }
        }
    }
    
    @IBAction func BtnImage(_ sender: Any) {
        self.present(imagePiker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ImagenView.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BtnAcciones(_ sender: UIButton) {
        if BtnAcciones.currentTitle == "Agregar" {
        guard let UserName = UserNameField.text, UserName != "" else {
                UserNameField.placeholder = "Ingresa en UserName"
                return
            }
            guard let Nombre = NombreField.text, Nombre != "" else {
                NombreField.placeholder = "Ingresa el nombre"
                return
            }
            guard let ApellidoPaterno = ApellidoPaternoField.text, ApellidoPaterno != "" else {
                ApellidoPaternoField.placeholder = "Ingresa el Apellido Paterno"
                return
            }
            guard let ApellidoMaterno = ApellidoMaternoField.text, ApellidoMaterno != "" else {
                ApellidoMaternoField.placeholder = "Ingresa el Apellido Materno"
                return
            }
            guard let Email = EmailField.text, Email != "" else {
                EmailField.placeholder = "Ingresa el Email"
                return
            }
            guard let Password = PasswordField.text, Password != "" else {
                PasswordField.placeholder = "Ingresa el Password"
                return
            }
            let FechaNacimiento = FechaNacimiento.date
            
            guard let Sexo = SexoField.text, Sexo != "" else {
                SexoField.placeholder = "Ingresa el Sexo"
                return
            }
            guard let Telefono = TelefonoField.text, Telefono != "" else {
                TelefonoField.placeholder = "Ingresa el Telefono"
                return
            }
            guard let Celular = CelularField.text, Celular != "" else {
                CelularField.placeholder = "Ingresa el Celular"
                return
            }
            guard let Curp = CurpField.text, Curp != "" else {
                CurpField.placeholder = "Ingresa el Curp"
                return
            }
            let Imagen = ImagenView.image!
            let imageString : String
            if ImagenView.restorationIdentifier == "product"{
                imageString = ""
            }else{
                let imageData = Imagen.pngData()! as NSData
                imageString = imageData.base64EncodedString(options: .lineLength64Characters)
            }
            usuarioModel = ModelUsuario(IdUsuario: 0, UserName: UserName, Nombre: Nombre, ApellidoPaterdo: ApellidoPaterno, ApellidoMaterno: ApellidoMaterno, Email: Email, Password: Password, FechaNacimiento: FechaNacimiento, Sexo: Sexo, Telefono: Telefono, Celular: Celular, Curp: Curp, Imagen: imageString)
            
            let result = usuarioViewModel.Add(usuario: usuarioModel!)
            
            if result.Correct{
                let alert = UIAlertController(title: "Confirmación", message: "Usuario agregado correctamente", preferredStyle: .alert)
                //let ok = UIAlertAction(title: "OK", style: .default)
                let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                                                { action in
                    self.UserNameField.text = ""
                    self.NombreField.text = ""
                    self.ApellidoPaternoField.text = ""
                    self.ApellidoMaternoField.text = ""
                    self.EmailField.text = ""
                    self.PasswordField.text = ""
                    self.SexoField.text = ""
                    self.TelefonoField.text = ""
                    self.CelularField.text = ""
                    self.CurpField.text = ""
                })
                //alert.addAction(ok)
                alert.addAction(Aceptar)
                self.present(alert, animated: false)
                
            }else{
                
                let alertError = UIAlertController(title: "Error", message: "El producto no se pudo agregar"+result.ErrorMessage, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alertError.addAction(ok)
                self.present(alertError, animated: false)
            }
        }
        
        if BtnAcciones.currentTitle == "Actualizar" {
            guard let UserName = UserNameField.text, UserName != "" else {
                    UserNameField.placeholder = "Ingresa en UserName"
                    return
                }
                guard let Nombre = NombreField.text, Nombre != "" else {
                    NombreField.placeholder = "Ingresa el nombre"
                    return
                }
                guard let ApellidoPaterno = ApellidoPaternoField.text, ApellidoPaterno != "" else {
                    ApellidoPaternoField.placeholder = "Ingresa el Apellido Paterno"
                    return
                }
                guard let ApellidoMaterno = ApellidoMaternoField.text, ApellidoMaterno != "" else {
                    ApellidoMaternoField.placeholder = "Ingresa el Apellido Materno"
                    return
                }
                guard let Email = EmailField.text, Email != "" else {
                    EmailField.placeholder = "Ingresa el Email"
                    return
                }
                guard let Password = PasswordField.text, Password != "" else {
                    PasswordField.placeholder = "Ingresa el Password"
                    return
                }
                let FechaNacimiento = FechaNacimiento.date
                
                guard let Sexo = SexoField.text, Sexo != "" else {
                    SexoField.placeholder = "Ingresa el Sexo"
                    return
                }
                guard let Telefono = TelefonoField.text, Telefono != "" else {
                    TelefonoField.placeholder = "Ingresa el Telefono"
                    return
                }
                guard let Celular = CelularField.text, Celular != "" else {
                    CelularField.placeholder = "Ingresa el Celular"
                    return
                }
                guard let Curp = CurpField.text, Curp != "" else {
                    CurpField.placeholder = "Ingresa el Curp"
                    return
                }
                let Imagen = ImagenView.image!
                let imageString : String
                if ImagenView.restorationIdentifier == "product"{
                    imageString = ""
                }else{
                    let imageData = Imagen.pngData()! as NSData
                    imageString = imageData.base64EncodedString(options: .lineLength64Characters)
                }
                usuarioModel = ModelUsuario(IdUsuario: Int(idUsuario!), UserName: UserName, Nombre: Nombre, ApellidoPaterdo: ApellidoPaterno, ApellidoMaterno: ApellidoMaterno, Email: Email, Password: Password, FechaNacimiento: FechaNacimiento, Sexo: Sexo, Telefono: Telefono, Celular: Celular, Curp: Curp, Imagen: imageString)
                
            let result = usuarioViewModel.Update(IdUpdate: Int(idUsuario!), usuario: usuarioModel!)
                
                if result.Correct{
                    let alert = UIAlertController(title: "Confirmación", message: "Usuario actualizado correctamente", preferredStyle: .alert)
                    //let ok = UIAlertAction(title: "OK", style: .default)
                    let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                                                    { action in
                        self.UserNameField.text = ""
                        self.NombreField.text = ""
                        self.ApellidoPaternoField.text = ""
                        self.ApellidoMaternoField.text = ""
                        self.EmailField.text = ""
                        self.PasswordField.text = ""
                        self.SexoField.text = ""
                        self.TelefonoField.text = ""
                        self.CelularField.text = ""
                        self.CurpField.text = ""
                    })
                    //alert.addAction(ok)
                    alert.addAction(Aceptar)
                    self.present(alert, animated: false)
                    
                }else{
                    
                    let alertError = UIAlertController(title: "Error", message: "El usuario no se pudo agregar"+result.ErrorMessage, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default)
                    alertError.addAction(ok)
                    self.present(alertError, animated: false)
                }
        }
        
    }
}
