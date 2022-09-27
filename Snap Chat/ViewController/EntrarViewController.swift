//
//  EntrarViewController.swift
//  Snap Chat
//
//  Created by Wesley Camilo on 15/08/22.
//

import UIKit
import FirebaseAuth
class EntrarViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBAction func entrar(_ sender: Any) {
        if let emailR = self.email.text {
            if let senhaR = self.senha.text {
                let autenticacao = Auth.auth()
                autenticacao.signIn(withEmail: emailR, password: senhaR) { usuario, erro in
                    if erro == nil {
                        if usuario == nil {
                            let alerta = Alerta(titulo: "Dados incorretos", mensagem: "Problemas ao autenticar, tente novamente" )
                            self.present(alerta.getAlerta(), animated: true)
                        }else {
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        }
                    }else {
                        let alerta = Alerta(titulo: "Dados incorretos", mensagem: "Verifique os dados e tente novamente" )
                        self.present(alerta.getAlerta(), animated: true)
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
