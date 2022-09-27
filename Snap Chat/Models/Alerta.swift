//
//  Alerta.swift
//  Snap Chat
//
//  Created by Wesley Camilo on 16/08/22.
//

import Foundation
import UIKit

class Alerta {
    var titulo: String
    var mensagem: String
    init(titulo: String, mensagem: String){
        self.titulo = titulo
        self.mensagem = mensagem
    }
    func getAlerta () -> UIAlertController {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaocancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(acaocancelar)
        return alerta
    }
}
