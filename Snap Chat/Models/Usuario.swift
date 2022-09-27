//
//  Usuario.swift
//  Snap Chat
//
//  Created by Wesley Camilo on 17/08/22.
//

import Foundation

class Usuario {
    var nome: String
    var email: String
    var uid: String
    init(nome: String, email: String, uid: String) {
        self.nome = nome
        self.email = email
        self.uid = uid
        
    }
}
