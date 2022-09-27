//
//  ViewController.swift
//  Snap Chat
//
//  Created by Wesley Camilo on 15/08/22.
//

import UIKit
import FirebaseAuth
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let autenticacao = Auth.auth()
        autenticacao.addStateDidChangeListener { autenticacao, usuario in
            if let usuarioLogado = usuario {
                self.performSegue(withIdentifier: "loginAutenticadoSegue", sender: nil)
            }
            
        }
       
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}

