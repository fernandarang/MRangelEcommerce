//
//  GetAllTableViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 30/12/22.
//

import UIKit
import SwipeCellKit

class GetAllTableViewController: UITableViewController {

    let productoViewModel = ProductoViewModel()
        var productos = [Producto]()
    var idProducto : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProductoTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductoCell")
                loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func Options(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .actionSheet)
        let addAction = UIAlertAction(title: "Agregar Producto", style: .default) { (_) in
                    self.performSegue(withIdentifier: "AgregarSegue", sender: self)
        }
        let pdfAction = UIAlertAction(title: "Lista de productos - PDF ", style: .default) { _ in
                    self.performSegue(withIdentifier: "pdfSegue", sender: self)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                actionSheet.addAction(addAction)
                actionSheet.addAction(pdfAction)
                actionSheet.addAction(cancel)
                
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func loadData() {
            let result = productoViewModel.GetAll()
            if result.Correct{
                productos = result.Objects! as! [Producto]
                tableView.reloadData()
            }
            else{
                //ALERT
                let alertError = UIAlertController(title: "Error", message: "Error al mostrar los productos"+result.ErrorMessage, preferredStyle: .alert)
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
        return productos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductoCell", for: indexPath) as! ProductoTableViewCell
        cell.Nombrelbl.text = productos[indexPath.row].Nombre
        cell.PrecioUnitariolbl.text = String(productos[indexPath.row].PrecioUnitario)
        cell.Stocklbl.text = String(productos[indexPath.row].Stock)
        cell.IdProveedor.text = String(productos[indexPath.row].Proveedor.IdProveedor)
        cell.IdDepartamentolbl.text = String(productos[indexPath.row].Departamento.IdDepartamento)
        cell.Descripcionlbl.text = productos[indexPath.row].Descripcion
        
        if productos[indexPath.row].Imagen == ""{
        cell.ImageProduct.image = UIImage(named: "product")
        }else{
            let imageData = Data(base64Encoded: productos[indexPath.row].Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            cell.ImageProduct.image = UIImage(data: imageData!)
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


extension GetAllTableViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right {
            
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                
                self.idProducto = self.productos[indexPath.row].IdProducto
                let result = self.productoViewModel.Delete(IdDelete: self.idProducto!)
                if result.Correct{
                    //UIAlert
                }else{
                    //UIAlert
                }
                self.loadData()
            }
            
            deleteAction.image = UIImage(systemName: "trash")
            
            return [deleteAction]
        }else{
            
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                self.idProducto = self.productos[indexPath.row].IdProducto
                self.performSegue(withIdentifier: "UpdateSegue", sender: self)
            }
            updateAction.image = UIImage (systemName: "highlighter")
            updateAction.backgroundColor = .blue
            return [updateAction]
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "UpdateSegue"{
                let productoController = segue.destination as! ViewController
                productoController.idProducto = self.idProducto
                print("recupero id")
            }
        }
    
}
