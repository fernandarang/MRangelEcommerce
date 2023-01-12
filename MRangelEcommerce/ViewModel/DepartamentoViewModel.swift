//
//  DepartamentoViewModel.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 05/01/23.
//

import Foundation
import SQLite3

class DepartamentoViewModel{
    let departamentoModel : Departamento? = nil
    
    func AddDepa(departamento : Departamento) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "INSERT INTO Departamento(Nombre,IdArea)VALUES(?,?)"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_text(statement, 1, (departamento.Nombre as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 2, Int32(departamento.Area.IdArea))
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                }else{
                    result.Correct = false
                }
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    func UpdateDepa(departamento : Departamento, IdUpdate :Int) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "UPDATE Departamento SET Nombre = ?,IdArea = ? WHERE IdDepartamento = \(IdUpdate)"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_text(statement, 1, (departamento.Nombre as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 2, Int32(departamento.Area.IdArea))
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                }else{
                    result.Correct = false
                }
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    func Delete(IdDelete : Int) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "DELETE FROM Departamento WHERE IdDepartamento = \(IdDelete)"
        
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                sqlite3_bind_int(statement, 1, Int32(exactly: IdDelete)!)
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                }else{
                    result.Correct = false
                }
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
            
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    func GetAll() -> Result{
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdDepartamento,Nombre,IdArea FROM Departamento"
        
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var departamento = Departamento()
                    departamento.IdDepartamento = Int(sqlite3_column_int(statement, 0))
                    departamento.Nombre =  String(cString: sqlite3_column_text(statement, 1))
                    departamento.Area.IdArea = Int(sqlite3_column_int(statement, 2))
    
                    result.Objects?.append(departamento)
                }
                result.Correct = true
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
            
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    func GetById(IdGetById : Int) -> Result{
        
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdDepartamento,Nombre,IdArea FROM Departamento WHERE IdDepartamento = \(IdGetById)"
        
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                result.Object = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var departamento = Departamento()
                    departamento.IdDepartamento = Int(sqlite3_column_int(statement, 0))
                    departamento.Nombre =  String(cString: sqlite3_column_text(statement, 1))
                    departamento.Area.IdArea = Int(sqlite3_column_int(statement, 2))
                    
                    result.Object = departamento
                }
                result.Correct = true
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
            
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
}
