//
//  GetAllDepaTableViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 05/01/23.
//

import UIKit
import SwipeCellKit

class GetAllDepaTableViewController: UITableViewController {
    
    let departamentoViewModel = DepartamentoViewModel()
    var departamentos = [Departamento]()
    var idDepartamento : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DepartamentoTableViewCell", bundle: nil), forCellReuseIdentifier: "DepartamentoCell")
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
        let result = departamentoViewModel.GetAll()
        if result.Correct{
            departamentos = result.Objects! as! [Departamento]
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
        return departamentos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepartamentoCell", for: indexPath) as! DepartamentoTableViewCell
        //cell.IdDepalbl.text = String(departamentos[indexPath.row].IdDepartamento)
        cell.Nombrelbl.text = departamentos[indexPath.row].Nombre
        cell.IdArealbl.text = String(departamentos[indexPath.row].Area.IdArea)
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
extension GetAllDepaTableViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right {
            
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                
                self.idDepartamento = self.departamentos[indexPath.row].IdDepartamento
                let result = self.departamentoViewModel.Delete(IdDelete: self.idDepartamento!)
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
                
                self.idDepartamento = self.departamentos[indexPath.row].IdDepartamento
                self.performSegue(withIdentifier: "UpdateSegue", sender: self)
            }
            updateAction.image = UIImage (systemName: "highlighter")
            updateAction.backgroundColor = .blue
            return [updateAction]
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "UpdateSegue"{
                let depaController = segue.destination as! DepaViewController
                depaController.idDepartamento = self.idDepartamento
                print("recupero id")
            }
        }}
