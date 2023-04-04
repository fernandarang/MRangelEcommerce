//
//  VentaProductoViewModel.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 24/01/23.
//

import Foundation
import SQLite3

class VentaProductoViewModel{
    
    let productoModel : Producto? = nil
    let productoController = ProductoCollectionViewController()
    
    func GetAllCarrito () -> Result{
        var result = Result()
        let context = DB.init()
        let query = "SELECT VentaProducto.IdVentaProducto, Producto.Nombre as NombreProducto, Producto.PrecioUnitario, VentaProducto.Cantidad,Producto.Imagen FROM VentaProducto INNER JOIN Producto ON VentaProducto.IdProducto = Producto.IdProducto"
        
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var ventaProducto = VentaProducto()
                    ventaProducto.IdVentaProducto = Int(sqlite3_column_int(statement, 0))
                    ventaProducto.Producto.Nombre =  String(cString: sqlite3_column_text(statement, 1))
                    ventaProducto.Producto.PrecioUnitario = Double(sqlite3_column_int(statement, 2))
                    ventaProducto.Cantidad = Int(sqlite3_column_int(statement, 3))
                    if sqlite3_column_text(statement, 4) != nil{
                        ventaProducto.Producto.Imagen = String(cString: sqlite3_column_text(statement, 4))
                                        }else
                                        {
                                            ventaProducto.Producto.Imagen = ""
                                        }
                  
                    result.Objects?.append(ventaProducto)
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

    func DeleteCarrito (IdVentaProducto : Int) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "DELETE FROM VentaProducto WHERE IdVentaProducto = \(IdVentaProducto)"
        
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                sqlite3_bind_int(statement, 1, Int32(exactly: IdVentaProducto)!)
                
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
    
    
   
    
    
    func UpdateCantidad() ->Result {
        let result = Result()
        
        
        return result
    }
    
    
    
    
    func validacionCarrito (idProducto : Int){
        if idProducto == nil{
            productoController.addCarrito(idProducto: idProducto)
        }else{
            //UpdateCantidad()
        }
    }
    
}
