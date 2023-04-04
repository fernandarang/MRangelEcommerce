//
//  Venta.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 24/01/23.
//

import Foundation

struct Venta{
    var IdVenta : Int
    var Total : Double
    var Fecha : Date
    //Propiedad de navegacion
    var IdUsuario : Usuario
    var IdMetodoPago : MetodoPago
    
    init(IdVenta: Int, Total: Double, Fecha: Date, IdUsuario: Usuario, IdMetodoPago: MetodoPago) {
        self.IdVenta = IdVenta
        self.Total = Total
        self.Fecha = Fecha
        self.IdUsuario = IdUsuario
        self.IdMetodoPago = IdMetodoPago
    }
    //init() {
       // self.IdVenta = 0
      //  self.Total = 0
       // self.Fecha = Date.now
        //self.IdUsuario = MRangelEcommerce.Usuario(Int(objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!)
       // self.IdMetodoPago = MRangelEcommerce.MetodoPago(IdMetodoPago: 0, Metodo: "")
    //}
    
}

