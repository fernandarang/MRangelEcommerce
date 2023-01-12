//
//  GetAllUsuarioTableViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 09/01/23.
//

import UIKit
import SwipeCellKit

class GetAllUsuarioTableViewController: UITableViewController {
    
    let usuarioViewModel = UsuarioViewModel()
        var usuarios = [ModelUsuario]()
    var idUsuario : Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "UsuarioTableViewCell", bundle: nil), forCellReuseIdentifier: "UsuarioCell")
                loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func loadData() {
            let result = usuarioViewModel.GetAll()
            if result.Correct{
                usuarios = result.Objects! as! [ModelUsuario]
                tableView.reloadData()
            }
            else{
                //ALERT
                let alertError = UIAlertController(title: "Error", message: "Error al mostrar los usuarios"+result.ErrorMessage, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alertError.addAction(ok)
                self.present(alertError, animated: false)
            }
        }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usuarios.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsuarioCell", for: indexPath) as! UsuarioTableViewCell
        cell.UserNamelbl.text = usuarios[indexPath.row].UserName
        cell.Nombrelbl.text = usuarios[indexPath.row].Nombre
        cell.ApellidoPaternolbl.text = usuarios[indexPath.row].ApellidoPaterdo
        cell.ApellidoMaterno.text = usuarios[indexPath.row].ApellidoMaterno
        cell.Emaillbl.text = usuarios[indexPath.row].Email
        cell.Passwordlbl.text = usuarios[indexPath.row].Password
        //cell.FechaNacimientolbl.date = UIDatePicker
        cell.Sexolbl.text = usuarios[indexPath.row].Sexo
        cell.Telefonolbl.text = usuarios[indexPath.row].Telefono
        cell.Celularlbl.text = usuarios[indexPath.row].Celular
        cell.Curplbl.text = usuarios[indexPath.row].Curp
        if usuarios[indexPath.row].Imagen == ""{
        cell.ImagenView.image = UIImage(named: "product")
        }else{
            let imageData = Data(base64Encoded: usuarios[indexPath.row].Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            cell.ImagenView.image = UIImage(data: imageData!)
        }
        cell.delegate = self
        
        
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension GetAllUsuarioTableViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right {
            
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                
                self.idUsuario = self.usuarios[indexPath.row].IdUsuario
                let result = self.usuarioViewModel.Delete(IdDelete: self.idUsuario!)
                if result.Correct{
                    
                }else{
                   
                }
                self.loadData()
            }
            
            deleteAction.image = UIImage(systemName: "trash")
            
            return [deleteAction]
        }else{
            
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                self.idUsuario = self.usuarios[indexPath.row].IdUsuario
                self.performSegue(withIdentifier: "UpdateSegue", sender: self)
            }
            updateAction.image = UIImage (systemName: "highlighter")
            updateAction.backgroundColor = .blue
            return [updateAction]
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "UpdateSegue"{
                let usuarioController = segue.destination as! UsuarioViewController
                usuarioController.idUsuario = self.idUsuario
                //print("recupero id")
            }
        }
    
}
