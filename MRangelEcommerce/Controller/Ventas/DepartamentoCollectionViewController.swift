//
//  DepartamentoCollectionViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 16/01/23.
//

import UIKit

//private let reuseIdentifier = "Cell"

class DepartamentoCollectionViewController: UICollectionViewController {
    
    
    let departamentoViewModel = DepartamentoViewModel()
    var departamentos = [Departamento]()
    var idArea : Int? = nil
    var idDepartamento : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView.register(UINib(nibName: "AreaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AreaCell")
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func loadData() {
        let result = departamentoViewModel.GetByIdDepartamento(idArea: self.idArea!)
        if result.Correct{
            departamentos = result.Objects! as! [Departamento]
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
        return departamentos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCell", for: indexPath) as! AreaCollectionViewCell
        cell.Nombrelbl.text = departamentos[indexPath.row].Nombre
        cell.ImagenCell.image = UIImage(systemName: "photo")
        
        // Configure the cell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.idDepartamento = departamentos[indexPath.row].IdDepartamento
        self.performSegue(withIdentifier: "ProductoSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductoSegue"{
            let productoController = segue.destination as! ProductoCollectionViewController
            productoController.idDepartamento = self.idDepartamento
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
