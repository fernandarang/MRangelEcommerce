//
//  BusquedaViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 18/01/23.


import UIKit

class BusquedaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var AreaCollectionView: UICollectionView!
    
    @IBOutlet weak var productoField: UITextField!
    
    @IBOutlet weak var buscarBtn: UIButton!
    
    let productoViewModel = ProductoViewModel()
    let areaViewModel = AreaViewModel()
    let productoModel = Producto()
    var areas = [Area]()
    var productos = [Producto]()
    var idArea : Int? = nil
    var nombre : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AreaCollectionView.delegate = self
        AreaCollectionView.dataSource = self
        self.AreaCollectionView.register(UINib(nibName: "AreaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AreaCell")
        loadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buscarBtn(_ sender: UIButton) {
        guard let nombre = productoField.text, nombre != "" else {
            productoField.placeholder = "Busca un producto.."
            return
        }
       // let result = productoViewModel.GetByNombre(nombre: nombre)
        self.nombre = nombre
       performSegue(withIdentifier: "BusquedaSegue", sender: self)
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
extension BusquedaViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func loadData() {
        let result = areaViewModel.GetAll()
        if result.Correct{
            areas = result.Objects! as! [Area]
            AreaCollectionView.reloadData()
        }
        else{
            //ALERT
            let alertError = UIAlertController(title: "Error", message: "Error al mostrar las areas"+result.ErrorMessage, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alertError.addAction(ok)
            self.present(alertError, animated: false)
        }
        
    }
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return areas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCell", for: indexPath) as! AreaCollectionViewCell
        cell.Nombrelbl.text = areas[indexPath.row].Nombre
        cell.ImagenCell.image = UIImage(named: areas[indexPath.row].Nombre!)
        
        // Configure the cell
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     self.idArea = areas[indexPath.row].IdArea
    self.performSegue(withIdentifier: "DepartamentoSegue", sender: self)
     }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DepartamentoSegue"{
            let departamentoController = segue.destination as! DepartamentoCollectionViewController
            departamentoController.idArea = self.idArea
        }
        if segue.identifier == "BusquedaSegue"{
            let productoController = segue.destination as! ProductoCollectionViewController
            productoController.nombre = self.nombre
        }
        
    }
    

        
    }
