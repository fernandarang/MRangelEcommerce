//
//  VentaProducto.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 24/01/23.
//

import Foundation

struct VentaProducto{
    var IdVentaProducto : Int
    var Cantidad : Int
    // Propiedad de navegacion
    var Producto : Producto
    
    
    init(IdVentaProducto: Int, Cantidad: Int, Producto: Producto) {
        self.IdVentaProducto = IdVentaProducto
        self.Cantidad = Cantidad
        self.Producto = Producto
    }
    
    
    init(){
        self.IdVentaProducto = 0
        self.Cantidad = 0
        self.Producto = MRangelEcommerce.Producto(IdProducto: 0, Nombre: "", PrecioUnitario: 0, Stock: 0, Descripcion: "", Imagen: "", Proveedor: Proveedor(IdProveedor: 0, Nombre: "", Telefono: ""), Departamento: Departamento(IdDepartamento: 0, Nombre: "", Area: Area(IdArea: 0, Nombre: "")))
    }
}
