//
//  Departamento.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 28/12/22.
//

import Foundation

struct Departamento{
    var IdDepartamento : Int
    var Nombre : String
    //Propiedad de navegaqcion
    var Area : Area
    
    init(IdDepartamento: Int, Nombre: String, Area: Area) {
        self.IdDepartamento = IdDepartamento
        self.Nombre = Nombre
        self.Area = Area
    }
    init(){
        self.IdDepartamento = 0
        self.Nombre = ""
        self.Area = MRangelEcommerce.Area(IdArea: 0, Nombre: "")
    }
}
