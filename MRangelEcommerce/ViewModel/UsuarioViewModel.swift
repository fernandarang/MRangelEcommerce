//
//  UsuarioViewModel.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 06/01/23.
//

import UIKit
import CoreData

class UsuarioViewModel {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func Add(usuario : ModelUsuario) -> Result{
        
        var result = Result()
        
        do{
            let context = appDelegate.persistentContainer.viewContext
            let entidad = NSEntityDescription.entity(forEntityName: "Usuario", in: context)
            let usuarioCoreData = NSManagedObject(entity: entidad!, insertInto: context)
            
            usuarioCoreData.setValue(usuario.UserName, forKey: "userName")
            usuarioCoreData.setValue(usuario.Nombre, forKey: "nombre")
            usuarioCoreData.setValue(usuario.ApellidoPaterdo, forKey: "apellidoPaterno")
            usuarioCoreData.setValue(usuario.ApellidoMaterno, forKey: "apellidoMaterno")
            usuarioCoreData.setValue(usuario.Email, forKey: "email")
            usuarioCoreData.setValue(usuario.Password, forKey: "password")
            usuarioCoreData.setValue(usuario.FechaNacimiento, forKey: "fechaNacimiento")
            usuarioCoreData.setValue(usuario.Sexo, forKey: "sexo")
            usuarioCoreData.setValue(usuario.Telefono, forKey: "telefono")
            usuarioCoreData.setValue(usuario.Celular, forKey: "celular")
            usuarioCoreData.setValue(usuario.Curp, forKey: "curp")
            usuarioCoreData.setValue(usuario.Imagen, forKey: "imagen")
            
            try! context.save()
            result.Correct = true
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
    func Update(IdUpdate : Int, usuario : ModelUsuario) -> Result{
            var result = Result()
            let context = appDelegate.persistentContainer.viewContext
            let entidad = NSEntityDescription.entity(forEntityName: "Usuario", in: context)
            let request : NSFetchRequest<Usuario> = Usuario.fetchRequest()
            request.entity = entidad
            let predicate = NSPredicate(format: "SELF = \(IdUpdate)")
            request.predicate = predicate
            do{
                var results = try! context.fetch(request)
               
                    let objUpdate = results[0] as NSManagedObject
                    let usuarioCoreData = NSManagedObject(entity: entidad!, insertInto: context)
                    
                    usuarioCoreData.setValue(usuario.UserName, forKey: "userName")
                    usuarioCoreData.setValue(usuario.Nombre, forKey: "nombre")
                    usuarioCoreData.setValue(usuario.ApellidoPaterdo, forKey: "apellidoPaterno")
                    usuarioCoreData.setValue(usuario.ApellidoMaterno, forKey: "apellidoMaterno")
                    usuarioCoreData.setValue(usuario.Email, forKey: "email")
                    usuarioCoreData.setValue(usuario.Password, forKey: "password")
                    usuarioCoreData.setValue(usuario.FechaNacimiento, forKey: "fechaNacimiento")
                    usuarioCoreData.setValue(usuario.Sexo, forKey: "sexo")
                    usuarioCoreData.setValue(usuario.Telefono, forKey: "telefono")
                    usuarioCoreData.setValue(usuario.Celular, forKey: "celular")
                    usuarioCoreData.setValue(usuario.Curp, forKey: "curp")
                    usuarioCoreData.setValue(usuario.Imagen, forKey: "imagen")
                    
                    try objUpdate.managedObjectContext?.save()
                result.Correct = true
                
                //try! context.save()
                
            }catch let error{
                result.Correct = false
                result.Ex = error
                result.ErrorMessage = error.localizedDescription
            }
            return result
        }
        
    func Delete(IdDelete : Int) -> Result {
        var result = Result()
        let context = appDelegate.persistentContainer.viewContext
        let entidad = NSEntityDescription.entity(forEntityName: "Usuario", in: context)
        let request : NSFetchRequest<Usuario> = Usuario.fetchRequest()
        request.entity = entidad
        let predicate = NSPredicate(format: "SELF = \(IdDelete)")
        request.predicate = predicate
        do{
            var results = try! context.fetch(request)
            if results.isEmpty{
                result.Correct = true
            }else {
                let objDelete = results[0] as NSManagedObject
                context.delete(objDelete)
            }
            
            try! context.save()
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
        func GetById(IdUsuario : Int) -> Result {
            var result = Result()
            let context = appDelegate.persistentContainer.viewContext
            let entidad = NSEntityDescription.entity(forEntityName: "Usuario", in: context)
            let request : NSFetchRequest<Usuario> = Usuario.fetchRequest()
            request.entity = entidad
            let predicate = NSPredicate(format: "SELF = \(IdUsuario)")
            request.predicate = predicate
            do {
                let usuarios = try context.fetch(request)
                result.Object = [ModelUsuario]()
                for objUsuario in usuarios as [NSManagedObject] {
                    var usuario = ModelUsuario()
                    usuario.IdUsuario = Int(objUsuario.objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!
                    usuario.UserName = objUsuario.value(forKey: "userName") as! String
                    usuario.Nombre = objUsuario.value(forKey: "nombre") as! String
                    usuario.ApellidoPaterdo = objUsuario.value(forKey: "apellidoPaterno") as! String
                    usuario.ApellidoMaterno = objUsuario.value(forKey: "apellidoMaterno") as! String
                    usuario.Email = objUsuario.value(forKey: "email") as! String
                    usuario.Password = objUsuario.value(forKey: "password") as! String
                    usuario.FechaNacimiento = objUsuario.value(forKey: "fechaNacimiento") as! Date
                    usuario.Sexo = objUsuario.value(forKey: "sexo") as! String
                    usuario.Telefono = objUsuario.value(forKey: "telefono") as! String
                    usuario.Celular = objUsuario.value(forKey: "celular") as! String
                    usuario.Curp = objUsuario.value(forKey: "curp") as! String
                    usuario.Imagen = objUsuario.value(forKey: "imagen") as! String
                    
                    result.Object = usuario
                }
                result.Correct = true
            } catch {
                result.Correct = false
                result.Ex = error
                result.ErrorMessage = error.localizedDescription            }
            return result
        }
        
        func GetAll() -> Result {
            var result = Result()
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
            do {
                let usuarios = try context.fetch(request)
                result.Objects = [ModelUsuario]()
                for objUsuario in usuarios as! [NSManagedObject] {
                    var usuario = ModelUsuario()
                    usuario.IdUsuario = Int(objUsuario.objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!
                    usuario.UserName = objUsuario.value(forKey: "userName") as! String
                    usuario.Nombre = objUsuario.value(forKey: "nombre") as! String
                    usuario.ApellidoPaterdo = objUsuario.value(forKey: "apellidoPaterno") as! String
                    usuario.ApellidoMaterno = objUsuario.value(forKey: "apellidoMaterno") as! String
                    usuario.Email = objUsuario.value(forKey: "email") as! String
                    usuario.Password = objUsuario.value(forKey: "password") as! String
                    usuario.FechaNacimiento = objUsuario.value(forKey: "fechaNacimiento") as! Date
                    usuario.Sexo = objUsuario.value(forKey: "sexo") as! String
                    usuario.Telefono = objUsuario.value(forKey: "telefono") as! String
                    usuario.Celular = objUsuario.value(forKey: "celular") as! String
                    usuario.Curp = objUsuario.value(forKey: "curp") as! String
                    usuario.Imagen = objUsuario.value(forKey: "imagen") as! String
                    
                    result.Objects?.append(usuario)
                }
                result.Correct = true
            } catch let error {
               
            }
            return result
        }
        
    }
    
    

