//
//  CadastroViewController.swift
//  Snap Chat
//
//  Created by Wesley Camilo on 15/08/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class CadastroViewController: UIViewController {

    @IBOutlet weak var emal: UITextField!
    @IBOutlet weak var nomeCompleto: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var repetirSenha: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    @IBAction func criarConta(_ sender: Any) {
        if let emailR = self.emal.text {
            if let nomeCompletoR = self.nomeCompleto.text {
                if let senhaR = self.senha.text {
                    if let repetirSenhaR = self.repetirSenha.text {
                        if senhaR == repetirSenhaR {
                            if nomeCompletoR != "" {
                                let autenticacao = Auth.auth()
                                autenticacao.createUser(withEmail: emailR, password: senhaR) { usuario, erro in
                                    if erro == nil {
                                        if usuario == nil {
                                            let alerta = Alerta(titulo: "Dados incorretos", mensagem: "Problemas ao autenticar, tente novamente")
                                            self.present(alerta.getAlerta(), animated: true)
                                        } else {
                                            let database = Database.database().reference()
                                            let usuarios = database.child("usuarios")
                                            let usuariosDados = ["nome": nomeCompletoR, "email": emailR]
                                            usuarios.child((usuario?.user.uid)!).setValue(usuariosDados)
                                            self.performSegue(withIdentifier: "cadastroLoginSegue", sender: nil)
                                        }
                                    }else {
                                        /*
                                         ERROR_INVALID_EMAIL
                                         ERROR_WEAK_PASSWORD
                                         ERROR_EMAIL_ALREADY_IN_USE
                                         */
                                        let erroR = erro! as NSError
                                        let codigoErro = erroR.userInfo["FIRAuthErrorUserInfoNameKey"]
                                        let erroTexto = codigoErro as! String
                                        var mensagemErro = ""
                                        switch erroTexto{
                                        case "ERROR_INVALID_EMAIL" :
                                            mensagemErro = "E-mail inválido, digite um e-mail válido"
                                            break
                                        case  "ERROR_WEAK_PASSWORD"  :
                                            mensagemErro = "Senha precisa ter no minimo 6 caracteres, com letras e numeros"
                                            break
                                        case "ERROR_EMAIL_ALREADY_IN_USE" :
                                            mensagemErro = "Esse e-mail ja existe, utilize outro e-mail"
                                            break
                                        default:
                                            mensagemErro = "Dados digitados estão incorretos"
                                        }
                                        let alerta = Alerta(titulo: "Dados incorretos", mensagem: mensagemErro )
                                        self.present(alerta.getAlerta(), animated: true)
                                        
                                    }
                                        
                                    
                                }
                            }else {
                                let alerta = Alerta(titulo: "Dados incorretos", mensagem: "Digite o nome para efetuar o cadastro")
                                self.present(alerta.getAlerta(), animated: true)
                            }
                        }else {
                            let alerta = Alerta(titulo: "Dados incorretos", mensagem: "Äs senhas náo sáo iguais, digite a senha novamente")
                            self.present(alerta.getAlerta(), animated: true)
                        }
                    }
                }
            }
        }
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
