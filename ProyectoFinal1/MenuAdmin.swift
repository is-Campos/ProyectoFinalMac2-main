//
//  MenuAdmin.swift.
//  ProyectoFinal1.
//
//  Created by Diego Juárez on 25/04/23.
//

import Cocoa

class MenuAdmin: NSViewController {
    

    @IBOutlet weak var vc: ViewController!

    @IBOutlet weak var txtNombreUsuario: NSTextField!
    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var lblIDIncorrecto: NSTextField!
    
    @IBOutlet weak var lblBajaCorrecta: NSTextField!
    
    var idUsuarioActual:Int!
    var idUsuarioAModificar:Int=0
    var idUsuarioAEliminar:Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblIDIncorrecto.isHidden = true
        lblBajaCorrecta.isHidden = true

        let usuarioActual = vc.usuarioLog
        idUsuarioActual = vc.idUsuarioActual
        
        txtNombreUsuario.stringValue = "Bienvenide " + usuarioActual[idUsuarioActual].nombre
    }
    
    @IBAction func irARegistro(_ sender: NSButton) {
        performSegue(withIdentifier: "irARegistrar", sender: self)
    }
    
    @IBAction func eliminarUsuario(_ sender: NSButton) {
        if txtID.stringValue != ""{
            if soloHayNumerosEnTxtID(){
                idUsuarioAEliminar = txtID.integerValue
                if idUsuarioAEliminar != 0 {
                    if idUsuarioActual != idUsuarioAEliminar{
                        if checarExistenciaUsuario(id: idUsuarioAEliminar){
                            vc.usuarioLog.remove(at: idUsuarioAEliminar)
                            lblBajaCorrecta.isHidden=false
                            lblIDIncorrecto.isHidden=true
                        }else{
                            lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                            lblIDIncorrecto.isHidden = false
                            lblBajaCorrecta.isHidden = true
                        }
                    }else{
                        lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                        lblIDIncorrecto.isHidden = false
                        lblBajaCorrecta.isHidden = true
                    }
                }else{
                    lblIDIncorrecto.stringValue = "*El admin no se puede eliminar*"
                    lblIDIncorrecto.isHidden = false
                    lblBajaCorrecta.isHidden = true
                }
            }else{
                lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                lblIDIncorrecto.isHidden = false
                lblBajaCorrecta.isHidden = true
            }
        }else{
            lblIDIncorrecto.stringValue = "*Inserta el ID que quieres eliminar*"
            lblIDIncorrecto.isHidden = false
            lblBajaCorrecta.isHidden = true
        }
        
    }
    
    @IBAction func irAModificar(_ sender: NSButton) {
        if txtID.stringValue != ""{
            if soloHayNumerosEnTxtID(){
                idUsuarioAModificar = txtID.integerValue
                if checarExistenciaUsuario(id: idUsuarioAModificar){
                    performSegue(withIdentifier: "irAModificar", sender: self)
                    lblIDIncorrecto.isHidden = true
                    lblBajaCorrecta.isHidden = true
                    
                }else{
                    lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                    lblIDIncorrecto.isHidden = false
                    lblBajaCorrecta.isHidden = true
                }
            }else{
                lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                lblIDIncorrecto.isHidden = false
                lblBajaCorrecta.isHidden = true
            }
        }else{
            lblIDIncorrecto.stringValue = "*Inserta el ID del usuario a modificar*"
            lblIDIncorrecto.isHidden = false
            lblBajaCorrecta.isHidden = true
        }
    }
    
    
    @IBAction func irAConsultar(_ sender: NSButton) {
        performSegue(withIdentifier: "irAConsultar", sender: self)
    }
    
    func checarExistenciaUsuario(id:Int) -> Bool{
        for UsuarioModelo in vc.usuarioLog {
            if (UsuarioModelo.id == id) {
                return true
            }
        }
        return false
    }
    
    func soloHayNumerosEnTxtID() -> Bool{
        let numericCharacters = CharacterSet.decimalDigits.inverted
        return txtID.stringValue.rangeOfCharacter(from: numericCharacters) == nil
    }
        
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "irAModificar" {
                        
                        (segue.destinationController as! RegistroAdmin).vc = self.vc
                        
                        (segue.destinationController as! RegistroAdmin).vcMenu = self
                        
                        let destinationVC = segue.destinationController as! RegistroAdmin;

                        destinationVC.idDeUsuarioRecibido = idUsuarioActual
                        destinationVC.idUsuarioAModificar = idUsuarioAModificar
                        print("valor id en menu: ",vc.usuarioLog[idUsuarioAModificar].id)
            destinationVC.modificar=true
            
                }else if segue.identifier=="irARegistrar"{
                        
                    (segue.destinationController as! RegistroAdmin).vc = self.vc
                    let destinationVC = segue.destinationController as! RegistroAdmin;
                    destinationVC.modificar=false
                        
                     }else if segue.identifier=="irAConsultar"{
                        (segue.destinationController as! ConsultarUsuario).usuarioLog = vc.usuarioLog
                        (segue.destinationController as! ConsultarUsuario).vcTabla = self.vc
                            }
            }
            
        }
    //

