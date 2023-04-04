//
//  DepaViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 06/01/23.
//
import UIKit
import iOSDropDown
//import Foundation

class DepaViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var NombreField: DropDown!
    @IBOutlet weak var IdAreaField: DropDown!
    @IBOutlet weak var AccionBtn: UIButton!
    
    let departamentoViewModel = DepartamentoViewModel()
    var departamentoModel : Departamento? = nil
    var idDepartamento : Int? = nil
    
    let areaViewModel = AreaViewModel()
    var areaModel : Area? = nil
    var idArea : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = DB.init()
        validar()
        
        NombreField.optionArray = [String]()
        NombreField.optionIds = [Int]()
        IdAreaField.optionArray = [String]()
        IdAreaField.optionIds = [Int]()
        
        LoadData()
        NombreField.didSelect { selectedText, index, id in
            self.LoadDataDepartamento(id)
        }
        
        IdAreaField.didSelect { selectedText, index, id in
            self.idArea = id
        }
    }
    
    func LoadData(){
        let result = areaViewModel.GetAll()
            if result.Correct{
                for area in result.Objects as! [Area]{
                    NombreField.optionArray.append(area.Nombre)
                    NombreField.optionIds?.append(area.IdArea)
                }
            }
        }
        func LoadDataDepartamento(_ IdArea : Int){
            let result = departamentoViewModel.GetByIdDepartamento(idArea: IdArea)
            if result.Correct{
                IdAreaField.optionArray = [String]()
                IdAreaField.optionIds = [Int]()
                for departamento in result.Objects as! [Departamento]{
                    IdAreaField.optionArray.append(departamento.Nombre)
                    IdAreaField.optionIds?.append(departamento.IdDepartamento)
                }
            }
        }
    
    
    
    
    func validar(){
        if idDepartamento == nil{
            AccionBtn.setTitle("Agregar", for: .normal) //Mostrar boton que indique Agregar
            //Mostar el formulario vacio
        }else
        {
            AccionBtn.setTitle("Actualizar", for: .normal)// Mostar buton que inque Actualizar
            let result = departamentoViewModel.GetById(IdGetById: idDepartamento!) //Uso del GetById
            if result.Correct{
                let departamento = result.Object as! Departamento //Mostar el formulario precargado
                NombreField.text = departamento.Nombre
                IdAreaField.text = String(departamento.Area.IdArea)
            }else{
                
            }
        }
    }
    
    
    @IBAction func AccionBtn(_ sender: UIButton) {
        if AccionBtn.currentTitle == "Agregar"{
            guard let Nombre = NombreField.text, Nombre != "" else {
                NombreField.placeholder = "Ingresa el Nombre"
                return
            }
            guard let IdArea = IdAreaField.text, IdArea != "" else{
                IdAreaField.placeholder = "Ingresa el ID del Area"
                return
            }
            
            departamentoModel = Departamento(IdDepartamento: 0, Nombre: Nombre, Area: Area(IdArea: Int(IdArea)!, Nombre: ""))
            
            let result = departamentoViewModel.AddDepa(departamento: departamentoModel!)
            
            if result.Correct{
                let alert = UIAlertController(title: "Confirmación", message: "Departamento agregado correctamente", preferredStyle: .alert)
                //let ok = UIAlertAction(title: "OK", style: .default)
                let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                   { action in
                    self.NombreField.text = ""
                    self.IdAreaField.text = ""
                })
                //alert.addAction(ok)
                alert.addAction(Aceptar)
                self.present(alert, animated: false)
                
            }else{
                
                let alertError = UIAlertController(title: "Error", message: "El departamento no se pudo agregar"+result.ErrorMessage, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alertError.addAction(ok)
                self.present(alertError, animated: false)
            }
        }
        if AccionBtn.currentTitle == "Actualizar"{
            guard let Nombre = NombreField.text, Nombre != "" else {
                NombreField.placeholder = "Ingresa el Nombre"
                return
            }
            guard let IdArea = IdAreaField.text, IdArea != "" else{
                IdAreaField.placeholder = "Ingresa el ID del Area"
                return
            }
            
            departamentoModel = Departamento(IdDepartamento: Int(idDepartamento!), Nombre: Nombre, Area: Area(IdArea: Int(IdArea)!, Nombre: ""))
            
            let result = departamentoViewModel.UpdateDepa(departamento: departamentoModel!, IdUpdate: Int(idDepartamento!))
            
            if result.Correct{
                let alert = UIAlertController(title: "Confirmación", message: "Departamento actualizado correctamente", preferredStyle: .alert)
                //let ok = UIAlertAction(title: "OK", style: .default)
                let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                   { action in
                    self.NombreField.text = ""
                    self.IdAreaField.text = ""
                })
                //alert.addAction(ok)
                alert.addAction(Aceptar)
                self.present(alert, animated: false)
                
            }else{
                
                let alertError = UIAlertController(title: "Error", message: "El departamento no se pudo actualizar"+result.ErrorMessage, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alertError.addAction(ok)
                self.present(alertError, animated: false)
            }
        }
    }
    
    
    
}
