//
//  ViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 27/12/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var PrecioUnitarioField: UITextField!
    @IBOutlet weak var NombreField: UITextField!
    @IBOutlet weak var StockField: UITextField!
    @IBOutlet weak var IdProveedorField: UITextField!
    @IBOutlet weak var IdDepartamentoField: UITextField!
    @IBOutlet weak var DescripcionField: UITextField!
    @IBOutlet weak var IdProductoField: UITextField!
    
    @IBOutlet weak var AddButton: UIButton!
    
    @IBOutlet weak var UpdateButton: UIButton!
    let productoViewModel = ProductoViewModel()
        var productoModel : Producto? = nil
    let imagePiker = UIImagePickerController()
    var idProducto : Int? = nil
    //let imageString : String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let getAll = productoViewModel.GetAll()
        //let getById = productoViewModel.GetById(IdGetById: 3)
        //IdProductoField.isHidden = false
        let db = DB.init()
        
        imagePiker.delegate = self
        imagePiker.sourceType = .photoLibrary
        imagePiker.isEditing = false
        validar()
    }
    
    func validar(){
           if idProducto == nil{
               AddButton.setTitle("Agregar", for: .normal) //Mostrar boton que indique Agregar
               //Mostar el formulario vacio
               imageView.image = UIImage(named: "product")
           }else
           {
               AddButton.setTitle("Actualizar", for: .normal)// Mostar buton que inque Actualizar
               let result = productoViewModel.GetById(IdGetById: idProducto!) //Uso del GetById
               if result.Correct{
                   let producto = result.Object as! Producto //Mostar el formulario precargado
                   NombreField.text = producto.Nombre
                   PrecioUnitarioField.text = String(producto.PrecioUnitario)
                   StockField.text = String(producto.Stock)
                   IdProveedorField.text = String(producto.Proveedor.IdProveedor)
                   IdDepartamentoField.text = String(producto.Departamento.IdDepartamento)
                   DescripcionField.text = producto.Descripcion
                   
                   if imageView.image == UIImage(named: "") {
                   imageView.image = UIImage(named: "product")
                   }else{
                     //Convertir imagen de BASE64 a DATA
                   }
                   
               }else{
                   
               }
           }
       }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func btnImage(_ sender: Any) {
        self.present(imagePiker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func AddButton(_ sender: UIButton) {
        
        if AddButton.currentTitle == "Agregar"{
            guard let Nombre = NombreField.text, Nombre != "" else {
                NombreField.placeholder = "Ingresa el nombre"
                return
            }
            guard let PrecioUnitario = PrecioUnitarioField.text, PrecioUnitario != "" else{
                PrecioUnitarioField.placeholder = "Ingresa el Precio"
                return
            }
            guard let Stock = StockField.text, Stock != "" else{
                StockField.placeholder = "Ingresa el Stock"
                return
            }
            guard let IdProveedor = IdProveedorField.text, IdProveedor != "" else{
                IdProveedorField.placeholder = "Ingresa el IdProveedor"
                return
            }
            guard let IdDepartamento = IdDepartamentoField.text, IdDepartamento != "" else{
                IdDepartamentoField.placeholder = "Ingresa el IdDepartamento"
                return
            }
            guard let Descripcion = DescripcionField.text, Descripcion != "" else{
                DescripcionField.placeholder = "Ingresa la Descripcion"
                return
            }
            let image = imageView.image!
            let imageString : String
                    if imageView.restorationIdentifier == "product"{
                        imageString = ""
                    }else{
                        let imageData = image.pngData()! as NSData
                        imageString = imageData.base64EncodedString(options: .lineLength64Characters)
                    }
            
            productoModel = Producto(IdProducto: 0, Nombre: Nombre, PrecioUnitario: Double(PrecioUnitario)!, Stock: Int(Stock)!, Descripcion: Descripcion, Imagen: imageString, Proveedor: Proveedor(IdProveedor: Int(IdProveedor)!, Nombre: "", Telefono: ""), Departamento: Departamento(IdDepartamento: Int(IdDepartamento)!, Nombre: "", Area: Area(IdArea: 0, Nombre: "")))
            
            let result = productoViewModel.Add(producto: productoModel!)
            
            if result.Correct{
                let alert = UIAlertController(title: "Confirmación", message: "Producto agregado correctamente", preferredStyle: .alert)
                //let ok = UIAlertAction(title: "OK", style: .default)
                let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                   { action in
                    self.NombreField.text = ""
                    self.PrecioUnitarioField.text = ""
                    self.StockField.text = ""
                    self.IdProveedorField.text = ""
                    self.IdDepartamentoField.text = ""
                    self.DescripcionField.text = ""
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
        }else{
        }
        if AddButton.currentTitle == "Actualizar" {
            guard let Nombre = NombreField.text, Nombre != "" else {
                NombreField.placeholder = "Ingresa el nombre"
                return
            }
            guard let PrecioUnitario = PrecioUnitarioField.text, PrecioUnitario != "" else{
                PrecioUnitarioField.placeholder = "Ingresa el Precio"
                return
            }
            guard let Stock = StockField.text, Stock != "" else{
                StockField.placeholder = "Ingresa el Stock"
                return
            }
            guard let IdProveedor = IdProveedorField.text, IdProveedor != "" else{
                IdProveedorField.placeholder = "Ingresa el IdProveedor"
                return
            }
            guard let IdDepartamento = IdDepartamentoField.text, IdDepartamento != "" else{
                IdDepartamentoField.placeholder = "Ingresa el IdDepartamento"
                return
            }
            guard let Descripcion = DescripcionField.text, Descripcion != "" else{
                DescripcionField.placeholder = "Ingresa la Descripcion"
                return
            }
           // let idProducto = IdProductoField.text!
               // IdProductoField.placeholder = "Ingresa el IdProducto"
               // return
            
            let image = imageView.image!
            let imageString : String
                    if imageView.restorationIdentifier == "product"{
                        imageString = ""
                    }else{
                        let imageData = image.pngData()! as NSData
                        imageString = imageData.base64EncodedString(options: .lineLength64Characters)
                    }
            
            productoModel = Producto(IdProducto: Int(idProducto!), Nombre: Nombre, PrecioUnitario: Double(PrecioUnitario)!, Stock: Int(Stock)!, Descripcion: Descripcion, Imagen: imageString, Proveedor: Proveedor(IdProveedor: Int(IdProveedor)!, Nombre: "", Telefono: ""), Departamento: Departamento(IdDepartamento: Int(IdDepartamento)!, Nombre: "", Area: Area(IdArea: 0, Nombre: "")))
            
            //let result = productoViewModel.Update(producto: productoModel!)
           let result = productoViewModel.Update(producto: productoModel!,IdUpdate: Int(idProducto!))
            
            if result.Correct{
                let alert = UIAlertController(title: "Confirmación", message: "Producto actualizado correctamente", preferredStyle: .alert)
                //let ok = UIAlertAction(title: "OK", style: .default)
                let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                   { action in
                    self.NombreField.text = ""
                    self.PrecioUnitarioField.text = ""
                    self.StockField.text = ""
                    self.IdProveedorField.text = ""
                    self.IdDepartamentoField.text = ""
                    self.DescripcionField.text = ""
                    self.IdProductoField.text = ""
                })
                //alert.addAction(ok)
                alert.addAction(Aceptar)
                self.present(alert, animated: false)
                
            }else{
                
                let alertError = UIAlertController(title: "Error", message: "El producto no se pudo actualizar"+result.ErrorMessage, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alertError.addAction(ok)
                self.present(alertError, animated: false)
            }
        }
    }
    
    @IBAction func UpdateButton(_ sender: UIButton) {
        
       
    }
   
    
    @IBAction func DeleteButton(_ sender: UIButton) {
        
        guard let IdProducto = IdProductoField.text, IdProducto != "" else{
            IdProductoField.placeholder = "Ingresa el IdProducto"
            return
        }
        
        productoModel = Producto(IdProducto: Int(IdProducto)!, Nombre: "", PrecioUnitario: 0, Stock: 0, Descripcion: "", Imagen: "", Proveedor: Proveedor(IdProveedor: 0, Nombre: "", Telefono: ""), Departamento: Departamento(IdDepartamento: 0, Nombre: "", Area: Area(IdArea: 0, Nombre: "")))
        
        //let result = productoViewModel.Update(producto: productoModel!)
       let result = productoViewModel.Delete(IdDelete: Int(IdProducto)!)
        
        if result.Correct{
            let alert = UIAlertController(title: "Confirmación", message: "Producto actualizado correctamente", preferredStyle: .alert)
            //let ok = UIAlertAction(title: "OK", style: .default)
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
               { action in
                
                self.IdProductoField.text = ""
            })
            //alert.addAction(ok)
            alert.addAction(Aceptar)
            self.present(alert, animated: false)
            
        }else{
            
            let alertError = UIAlertController(title: "Error", message: "El producto no se pudo actualizar"+result.ErrorMessage, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alertError.addAction(ok)
            self.present(alertError, animated: false)
        }
    }
    
    
}

