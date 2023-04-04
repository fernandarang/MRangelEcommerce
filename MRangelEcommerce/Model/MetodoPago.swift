//
//  MetodoPago.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 24/01/23.
//

import Foundation

struct MetodoPago {
    var IdMetodoPago : Int
    var Metodo : String
    
    init(IdMetodoPago: Int, Metodo: String) {
        self.IdMetodoPago = IdMetodoPago
        self.Metodo = Metodo
    }
    init(){
        self.IdMetodoPago = 0
        self.Metodo = ""
    }
}
