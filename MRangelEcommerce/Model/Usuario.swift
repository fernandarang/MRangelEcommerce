//
//  Usuario.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 06/01/23.
//

import Foundation

struct ModelUsuario{
    var IdUsuario : Int
    var UserName : String
    var Nombre : String
    var ApellidoPaterdo : String
    var ApellidoMaterno : String
    var Email : String
    var Password : String
    var FechaNacimiento : Date
    var Sexo : String
    var Telefono : String
    var Celular : String
    var Curp : String
    var Imagen : String
    
    init(IdUsuario: Int, UserName: String, Nombre: String, ApellidoPaterdo: String, ApellidoMaterno: String, Email: String, Password: String, FechaNacimiento: Date, Sexo: String, Telefono: String, Celular: String, Curp: String, Imagen: String) {
        self.IdUsuario = IdUsuario
        self.UserName = UserName
        self.Nombre = Nombre
        self.ApellidoPaterdo = ApellidoPaterdo
        self.ApellidoMaterno = ApellidoMaterno
        self.Email = Email
        self.Password = Password
        self.FechaNacimiento = FechaNacimiento
        self.Sexo = Sexo
        self.Telefono = Telefono
        self.Celular = Celular
        self.Curp = Curp
        self.Imagen = Imagen
    }
    
    init(){
        self.IdUsuario = 0
        self.UserName = ""
        self.Nombre = ""
        self.ApellidoPaterdo = ""
        self.ApellidoMaterno = ""
        self.Email = ""
        self.Password = ""
        self.FechaNacimiento = Date.now
        self.Sexo = ""
        self.Telefono = ""
        self.Celular = ""
        self.Curp = ""
        self.Imagen = ""
        
    }
}
