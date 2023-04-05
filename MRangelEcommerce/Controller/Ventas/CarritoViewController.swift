//
//  CarritoViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 26/01/23.
//

import UIKit
import SwipeCellKit

class CarritoViewController: UIViewController {

    @IBOutlet weak var TableViewCarrito: UITableView!
    
    let productoViewModel = ProductoViewModel()
    var producto = Producto()
    var idProducto : Int! = nil
    var productos = [Producto]()
    var ventaProductos = [VentaProducto]()
    var ventaProducto = VentaProductoViewModel()
    var idVentaProducto : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewCarrito.delegate = self
        TableViewCarrito.dataSource = self
        
        TableViewCarrito.register(UINib(nibName: "CarritoTableViewCell", bundle: nil), forCellReuseIdentifier: "carritoCell")
        
        loadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func loadData() {
        //if self.idProducto != nil{
        let result = ventaProducto.GetAllCarrito()
            if result.Correct{
            
            ventaProductos = result.Objects as! [VentaProducto]
            
            
            TableViewCarrito.reloadData()
            }
            else{
            //ALERT
            let alertError = UIAlertController(title: "Error", message: "Error al mostrar los productos"+result.ErrorMessage, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alertError.addAction(ok)
            self.present(alertError, animated: false)
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
extension CarritoViewController : UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ventaProductos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carritoCell", for: indexPath) as! CarritoTableViewCell
        cell.Nombrelbl.text = ventaProductos[indexPath.row].Producto.Nombre
        cell.Preciolbl.text = "$ \(String(ventaProductos[indexPath.row].Producto.PrecioUnitario!))"
        cell.Cantidadlbl.text = "Cantidad: \(String(ventaProductos[indexPath.row].Cantidad))"
        
        if ventaProductos[indexPath.row].Producto.Imagen == ""{
            cell.ImagenProducto.image = UIImage(named: "product")
        }else{
            let imageData = Data(base64Encoded: ventaProductos[indexPath.row].Producto.Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            cell.ImagenProducto.image = UIImage(data: imageData!)
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
       // if orientation == .right {
        guard orientation == .right else { return nil }
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
            
        
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                
                
                
                //self.idVentaProducto = self.ventaProductos[indexPath.row].IdVentaProducto
                //let result = self.ventaProducto.DeleteCarrito(IdVentaProducto: self.idVentaProducto!)
               // if result.Correct{
                    //UIAlert
               // }else{
                    //UIAlert
               // }
              self.loadData()
            }
            
            return [deleteAction]
        }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        
        self.idVentaProducto = self.ventaProductos[indexPath.row].IdVentaProducto
        let result = self.ventaProducto.DeleteCarrito(IdVentaProducto: self.idVentaProducto!)
        
           return options
    }
        
   // }
}
