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
    
    
    let productoViewModel = ProductoViewModel()
        var productoModel : Producto? = nil
    let imagePiker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let getAll = productoViewModel.GetAll()
        let getById = productoViewModel.GetById(IdGetById: 3)
        //IdProductoField.isHidden = false
        let db = DB.init()
        
        imagePiker.delegate = self
        imagePiker.sourceType = .photoLibrary
        imagePiker.isEditing = false
    }
    
    @IBOutlet weak var imageView: UIButton!
    
    @IBAction func btnImage(_ sender: Any) {
        self.present(imagePiker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //imageView.imagePiker = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddButton(_ sender: UIButton) {
        
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
        
        productoModel = Producto(IdProducto: 0, Nombre: Nombre, PrecioUnitario: Double(PrecioUnitario)!, Stock: Int(Stock)!, Descripcion: Descripcion, Proveedor: Proveedor(IdProveedor: Int(IdProveedor)!, Nombre: "", Telefono: ""), Departamento: Departamento(IdDepartamento: Int(IdDepartamento)!, Nombre: "", Area: Area(IdArea: 0, Nombre: "")))
        
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
    }
    
    @IBAction func UpdateButton(_ sender: UIButton) {
        
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
        guard let IdProducto = IdProductoField.text, IdProducto != "" else{
            IdProductoField.placeholder = "Ingresa el IdProducto"
            return
        }
        
        productoModel = Producto(IdProducto: Int(IdProducto)!, Nombre: Nombre, PrecioUnitario: Double(PrecioUnitario)!, Stock: Int(Stock)!, Descripcion: Descripcion, Proveedor: Proveedor(IdProveedor: Int(IdProveedor)!, Nombre: "", Telefono: ""), Departamento: Departamento(IdDepartamento: Int(IdDepartamento)!, Nombre: "", Area: Area(IdArea: 0, Nombre: "")))
        
        //let result = productoViewModel.Update(producto: productoModel!)
       let result = productoViewModel.Update(producto: productoModel!,IdUpdate: Int(IdProducto)!)
        
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
    
    @IBAction func DeleteButton(_ sender: UIButton) {
        
        guard let IdProducto = IdProductoField.text, IdProducto != "" else{
            IdProductoField.placeholder = "Ingresa el IdProducto"
            return
        }
        
        productoModel = Producto(IdProducto: Int(IdProducto)!, Nombre: "", PrecioUnitario: 0, Stock: 0, Descripcion: "", Proveedor: Proveedor(IdProveedor: 0, Nombre: "", Telefono: ""), Departamento: Departamento(IdDepartamento: 0, Nombre: "", Area: Area(IdArea: 0, Nombre: "")))
        
        //let result = productoViewModel.Update(producto: productoModel!)
       let result = productoViewModel.Delete(producto: productoModel!, IdDelete: Int(IdProducto)!)
        
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

