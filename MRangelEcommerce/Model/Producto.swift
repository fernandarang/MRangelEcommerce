//
//  Producto.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 28/12/22.
//

import Foundation

struct Producto{
    var IdProducto : Int
    var Nombre : String
    var PrecioUnitario : Double
    var Stock : Int
    var Descripcion : String
    
    //Propiedades de Navegacion
    var Proveedor : Proveedor
    var Departamento : Departamento
}
