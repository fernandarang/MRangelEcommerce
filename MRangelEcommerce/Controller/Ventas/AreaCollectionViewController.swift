//
//  AreaCollectionViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 13/01/23.
//

import UIKit

//private let reuseIdentifier = "AreaCollectionViewCell"

class AreaCollectionViewController: UICollectionViewController {
    
    let areaViewModel = AreaViewModel()
    var areas = [Area]()
    var idArea : Int? = nil
    
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
        let result = areaViewModel.GetAll()
        if result.Correct{
            areas = result.Objects! as! [Area]
            collectionView.reloadData()
        }
        else{
            //ALERT
            let alertError = UIAlertController(title: "Error", message: "Error al mostrar las areas"+result.ErrorMessage, preferredStyle: .alert)
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
        return areas.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCell", for: indexPath) as! AreaCollectionViewCell
        cell.Nombrelbl.text = areas[indexPath.row].Nombre
        cell.ImagenCell.image = UIImage(named: areas[indexPath.row].Nombre)
        
        // Configure the cell
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.idArea = areas[indexPath.row].IdArea
        self.performSegue(withIdentifier: "DepartamentoSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DepartamentoSegue"{
            let departamentoController = segue.destination as! DepartamentoCollectionViewController
           departamentoController.idArea = self.idArea
            
        }
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
