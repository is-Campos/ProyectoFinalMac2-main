//
//  ConsultarUsuario.swift
//  ProyectoFinal1
//
//  Created by ISSC_412_2023 on 02/05/23.
//

import Cocoa

class ConsultarUsuario: NSViewController {
    
    //TODO: Checar qpd con id

    @IBOutlet var vcTabla: ViewController!
    @objc dynamic var usuarioLog:[UsuarioModelo] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func cerrarViewController(_ sender: NSButton) {
        dismiss(self)
    }
    
    
}
