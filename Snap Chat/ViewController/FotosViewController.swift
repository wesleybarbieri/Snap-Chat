//
//  DetalhesSnapViewController.swift
//  Snap Chat
//
//  Created by Wesley Camilo on 16/08/22.
//

import UIKit
import FirebaseStorage

class FotosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var botaoProximo: UIButton!
    
    var imagePicker = UIImagePickerController()
    var IdImagem = NSUUID().uuidString
    
    @IBAction func proximoPasso(_ sender: Any) {
        self.botaoProximo.isEnabled = false
        self.botaoProximo.setTitle("Carregando..", for: .normal)
        
        let armazenamento = Storage.storage().reference()
        let imagens = armazenamento.child("imagens")
        if let imagemSelecionada = imagem.image {
            if let imagemDados = imagemSelecionada.jpegData(compressionQuality: 0.1) {
                imagens.child("\(self.IdImagem).jpg").putData(imagemDados, metadata: nil) { metaDados, erro in
                    if erro == nil {
                        print("Sucesso ao fazer Upload da imagem")
                       if let nomeImagem = metaDados?.dictionaryRepresentation()["name"] as? String {
                            let starsRef = armazenamento.child(nomeImagem)
                            starsRef.downloadURL { url, erro in
                                if let erro = erro {
                                    print(erro)
                                }else {
                                    if let urlString = url {
                                        self.performSegue(withIdentifier: "selecinarUsuarioSegue", sender: urlString.absoluteString)
                                        print(urlString)
                                    }
                                }
                            }
                        }
                        //self.performSegue(withIdentifier: "selecinarUsuarioSegue", sender: nil)
                        self.botaoProximo.isEnabled = false
                        self.botaoProximo.setTitle("Proximo", for: .normal)
                    }else {
                        let alerta = Alerta(titulo: "Erro ao fazer upload do arquivo", mensagem: "Erro ao salvar arquivo, tente novamente mais tarde")
                        self.present(alerta.getAlerta(), animated: true)
                    }
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selecinarUsuarioSegue"{
            let usuarioTablViewController = segue.destination as! UsuariosTableViewController
            usuarioTablViewController.descricao = self.descricao.text!
            usuarioTablViewController.urlImagem = sender as! String
            usuarioTablViewController.idImagem = self.IdImagem
        }
    }
    
    @IBAction func selecionarFoto(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagemRecuperada = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imagem.image = imagemRecuperada
        self.botaoProximo.isEnabled = true
        self.botaoProximo.backgroundColor = UIColor(red: 0.582, green: 0.216, blue: 1.000, alpha: 1)
        imagePicker.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.botaoProximo.isEnabled = false
        self.botaoProximo.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view.
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
