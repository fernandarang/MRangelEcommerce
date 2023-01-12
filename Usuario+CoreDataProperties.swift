//
//  Usuario+CoreDataProperties.swift
//  
//
//  Created by MacBookMBA5 on 06/01/23.
//
//

import Foundation
import CoreData


extension Usuario{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Usuario> {
        return NSFetchRequest<Usuario>(entityName: "Usuario")
    }

    @NSManaged public var userName: String?
    @NSManaged public var nombre: String?
    @NSManaged public var apellidoPaterno: String?
    @NSManaged public var apellidoMaterno: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var fechaNacimiento: Date?
    @NSManaged public var sexo: String?
    @NSManaged public var telefono: String?
    @NSManaged public var celular: String?
    @NSManaged public var curp: String?
    @NSManaged public var imagen: String?

}
