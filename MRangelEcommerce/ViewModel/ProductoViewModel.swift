//
//  ProductoViewModel.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 28/12/22.
//

import Foundation
import SQLite3

class ProductoViewModel{
    let productoModel : Producto? = nil
        
        func Add(producto : Producto) -> Result{
                    
            var result = Result()
            let context = DB.init()
            let query = "INSERT INTO Producto(Nombre,PrecioUnitario,Stock,IdProveedor,IdDepartamento,Descripcion) VALUES(?,?,?,?,?,?)"
            var statement : OpaquePointer? = nil
            do{
                if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                    sqlite3_bind_text(statement, 1, (producto.Nombre as NSString).utf8String, -1, nil)
                    sqlite3_bind_double(statement, 2, producto.PrecioUnitario)
                    sqlite3_bind_int(statement, 3, Int32(producto.Stock))
                    sqlite3_bind_int(statement, 4, Int32(producto.Proveedor.IdProveedor))
                    sqlite3_bind_int(statement, 5, Int32(producto.Departamento.IdDepartamento))
                    sqlite3_bind_text(statement, 6, (producto.Descripcion as NSString).utf8String, -1, nil)
                    
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
            return result
        }
    
    func Update(producto : Producto, IdUpdate : Int) -> Result{
            var result = Result()
            let context = DB.init()
            let query = "UPDATE Producto SET Nombre =?, PrecioUnitario=?,Stock=?, IdProveedor=?,IdDepartamento=?,Descripcion=? WHERE IdProducto = \(IdUpdate)"
            
            var statement : OpaquePointer? = nil
            do{
                if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                    //sqlite3_bind_int(statement, 0, Int32(producto.IdProducto))
                    sqlite3_bind_text(statement, 1, (producto.Nombre as NSString).utf8String, -1, nil)
                    sqlite3_bind_double(statement, 2, producto.PrecioUnitario)
                    sqlite3_bind_int(statement, 3, Int32(producto.Stock))
                    sqlite3_bind_int(statement, 4, Int32(producto.Proveedor.IdProveedor))
                    sqlite3_bind_int(statement, 5, Int32(producto.Departamento.IdDepartamento))
                    sqlite3_bind_text(statement, 6, (producto.Descripcion as NSString).utf8String, -1, nil)
                    
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
            return result
        }
    
    func Delete(producto: Producto, IdDelete : Int) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "DELETE FROM Producto WHERE IdProducto = \(IdDelete)"
        
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                sqlite3_bind_int(statement, 0, Int32(producto.IdProducto))
                
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
        return result
    }
    
    func GetAll() -> Result{
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdProducto,Nombre,PrecioUnitario,Stock,IdProveedor,IdDepartamento, Descripcion FROM Producto"
        
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    let producto = Producto(IdProducto: Int(sqlite3_column_int(statement, 0)), Nombre: String(cString: sqlite3_column_text(statement, 1)), PrecioUnitario: Double(sqlite3_column_double(statement, 2)), Stock: Int(sqlite3_column_int(statement, 3)), Descripcion: String(cString: sqlite3_column_text(statement, 6)), Proveedor: Proveedor(IdProveedor: Int(sqlite3_column_int(statement, 4)), Nombre: "", Telefono: ""), Departamento: Departamento(IdDepartamento: Int(sqlite3_column_int(statement, 5)), Nombre: "", Area: Area(IdArea: 0, Nombre: "")))
                    
                    result.Objects?.append(producto)
                }
                result.Correct = true
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
            
        }
        return result
    }
    
    func GetById(IdGetById : Int) -> Result{
        
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdProducto,Nombre,PrecioUnitario,Stock,IdProveedor,IdDepartamento, Descripcion FROM Producto WHERE IdProducto = \(IdGetById)"
        
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    let producto = Producto(IdProducto: Int(sqlite3_column_int(statement, 0)), Nombre: String(cString: sqlite3_column_text(statement, 1)), PrecioUnitario: Double(sqlite3_column_double(statement, 2)), Stock: Int(sqlite3_column_int(statement, 3)), Descripcion: String(cString: sqlite3_column_text(statement, 6)), Proveedor: Proveedor(IdProveedor: Int(sqlite3_column_int(statement, 4)), Nombre: "", Telefono: ""), Departamento: Departamento(IdDepartamento: Int(sqlite3_column_int(statement, 5)), Nombre: "", Area: Area(IdArea: 0, Nombre: "")))
                    
                    result.Objects?.append(producto)
                }
                result.Correct = true
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
            
        }
        return result
    }
}
    

