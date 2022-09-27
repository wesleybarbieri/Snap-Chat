//
//  DetalhesSnapViewController.swift
//  Snap Chat
//
//  Created by Wesley Camilo on 18/08/22.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
class DetalhesSnapViewController: UIViewController {
    var snap = Snap()
    var tempo = 11
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var detalhes: UILabel!
    @IBOutlet weak var contador: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detalhes.text = "Carregando..."
        let url = URL(string: snap.urlImagem)
        imagem.sd_setImage(with: url) { imagem, erro , cache, url in
            
            if erro == nil{
                self.detalhes.text = self.snap.descricao
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    self.tempo = self.tempo - 1
                    self.contador.text = String(self.tempo)
                    if self.tempo == 0 {
                        timer.invalidate()
                        self.dismiss(animated: true,completion: nil)
                    }
                }
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        let autenticacao = Auth.auth()
        if let idUsuarioLogado = autenticacao.currentUser?.uid{
            let database = Database.database().reference()
            let usuario = database.child("usuarios")
            let snaps = usuario.child(idUsuarioLogado).child("snaps")
            snaps.child(snap.identificador).removeValue()
            
            let storege = Storage.storage().reference()
            let imagens = storege.child("imagens")
            imagens.child("\(snap.idImagem).jpg").delete { erro in
                if erro == nil {
                    print("imagem deletada com sucesso")
                }else {
                    print("erro ao excluir imagem")
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
