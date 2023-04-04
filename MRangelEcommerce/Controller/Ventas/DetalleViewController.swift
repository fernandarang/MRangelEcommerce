//
//  DetalleViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 23/01/23.
//

import UIKit

class DetalleViewController: UIViewController {
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var BtnAgregar: UIButton!
    @IBOutlet weak var cantidadTxt: UITextField!
    
    let productoViewModel = ProductoViewModel()
    var productos = [Producto]()
    var ventaProductoModel = VentaProducto()
    var producto = Producto()
    var idProducto : Int! = nil
    //var produc = ["hola","hello","hi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
        
        TableView.register(UINib(nibName: "DetalleTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        loadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    
    
    @IBAction func AgregarBtn(_ sender: UIButton) {
        
    }
   
    func loadData() {
        
            let result = productoViewModel.GetByIdProductos(IdGetById: idProducto)
            if result.Correct{
            
            productos = result.Objects as! [Producto]
            
            
            TableView.reloadData()
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

extension DetalleViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetalleTableViewCell
        cell.Nombrelbl.text = productos[indexPath.row].Nombre
        cell.Preciolbl.text = "$ \(String(productos[indexPath.row].PrecioUnitario))"
        cell.Descripcionlbl.text = productos[indexPath.row].Descripcion
        
        if productos[indexPath.row].Imagen == ""{
        cell.ImagenView.image = UIImage(named: "product")
        }else{
            let imageData = Data(base64Encoded: productos[indexPath.row].Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            cell.ImagenView.image = UIImage(data: imageData!)
        }
        return cell
    }
    
}
