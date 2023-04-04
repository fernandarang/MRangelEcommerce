//
//  ProductoCollectionViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 18/01/23.
//

import UIKit
import SQLite3

//private let reuseIdentifier = "Cell"

class ProductoCollectionViewController: UICollectionViewController{
    
    let productoViewModel = ProductoViewModel()
    var productos = [Producto]()
    var idArea : Int? = nil
    var idDepartamento : Int? = nil
    var idProducto : Int? = nil
    var nombre : String? = nil
    var producto = Producto()
    var ventaProducto = VentaProducto()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView.register(UINib(nibName: "ProductoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductoCell")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func loadData() {
        if idDepartamento == nil {
            let result = productoViewModel.GetByNombre(nombre: self.nombre!)
            if result.Correct{
                productos = result.Objects! as! [Producto]
                collectionView.reloadData()
            }else{
                //ALERT
                let alertError = UIAlertController(title: "Error", message: "Error al mostrar los departamentos"+result.ErrorMessage, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alertError.addAction(ok)
                self.present(alertError, animated: false)
            }
        }else{
            let result = productoViewModel.GetByIdProducto(idDepartamento: self.idDepartamento!)
            if result.Correct{
                productos = result.Objects! as! [Producto]
                collectionView.reloadData()
            }
            else{
                //ALERT
                let alertError = UIAlertController(title: "Error", message: "Error al mostrar los departamentos"+result.ErrorMessage, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alertError.addAction(ok)
                self.present(alertError, animated: false)
            }
        }
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return productos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductoCell", for: indexPath) as! ProductoCollectionViewCell
        cell.Nombrelbl.text = productos[indexPath.row].Nombre
        cell.Descripcionlbl.text = productos[indexPath.row].Descripcion
        if productos[indexPath.row].Imagen == ""{
            cell.ImageProduct.image = UIImage(named: "product")
        }else{
            let imageData = Data(base64Encoded: productos[indexPath.row].Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            cell.ImageProduct.image = UIImage(data: imageData!)
        }
        cell.AgregarBtn.addTarget(self, action: #selector(comprar), for: .touchUpInside)
        cell.AgregarBtn.tag = indexPath.row
        // Configure the cell
        
        return cell
    }
    @objc func comprar (sender : UIButton){
        let producto = self.productos[sender.tag].IdProducto
        print("Producto con posición \(sender.tag) y id \(producto)")
        addCarrito(idProducto: producto)
    }
    
    func addCarrito (idProducto : Int) -> Result{
       // var ventaProducto : VentaProducto
        var result = Result()
        let context = DB.init()
        let query = "INSERT INTO VentaProducto(Cantidad,IdProducto) VALUES (1,\(idProducto))"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_int(statement, 1, Int32(ventaProducto.Cantidad))
                sqlite3_bind_int(statement, 2, Int32(ventaProducto.Producto.IdProducto))
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                }else{
                    result.Correct = false
                }
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.idProducto = productos[indexPath.row].IdProducto
        self.performSegue(withIdentifier: "DetalleSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetalleSegue"{
            let detalleController = segue.destination as! DetalleViewController
            detalleController.idProducto = self.idProducto
            
            // MARK: UICollectionViewDelegate
            
            /*
             // Uncomment this method to specify if the specified item should be highlighted during tracking
             override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
             return true
             }
             */
            
            /*
             // Uncomment this method to specify if the specified item should be selected
             override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
             return true
             }
             */
            
            /*
             // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
             override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
             return false
             }
             
             override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
             return false
             }
             
             override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
             
             }
             */
            
        }
    }
}
