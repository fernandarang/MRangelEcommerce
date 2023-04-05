//
//  PDF2ViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 04/04/23.
//

import UIKit
import PDFKit

class PDF2ViewController: UIViewController {
    
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var documentData : Data?
    
    private let pdfViews : PDFView = {
            let pdfVIew = PDFView(frame: .zero)
            return pdfVIew
        }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pdfViews)
        
        if let data = documentData {
            pdfViews.translatesAutoresizingMaskIntoConstraints = false
            pdfViews.autoScales = true
            pdfViews.pageBreakMargins = UIEdgeInsets.init(top: 20, left: 8, bottom: 32, right: 8)
            pdfViews.document = PDFDocument(data: data)
            pdfViews.frame = view.bounds
        }
        
        NSLayoutConstraint.activate([
            pdfViews.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pdfViews.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pdfViews.widthAnchor.constraint(equalToConstant: 390),
            pdfViews.heightAnchor.constraint(equalToConstant: 610)
        ])
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareAction))
        navigationItem.rightBarButtonItem = shareButton
        //navigationItem.backBarButtonItem = shareButton
        //self.toolbarItems?.append(shareButton)

    }
    
    @objc func shareAction(){
        if let dt = documentData {
                    let vc = UIActivityViewController(
                      activityItems: [dt],
                      applicationActivities: []
                    )
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        vc.popoverPresentationController?.barButtonItem = shareButton
                    }
                    self.present(vc, animated: true, completion: nil)
                }
    }
    
//    @IBAction func shareButton(_ sender: Any) {
//        if let dt = documentData {
//                    let vc = UIActivityViewController(
//                      activityItems: [dt],
//                      applicationActivities: []
//                    )
//                    if UIDevice.current.userInterfaceIdiom == .pad {
//                        vc.popoverPresentationController?.barButtonItem = shareButton
//                    }
//                    self.present(vc, animated: true, completion: nil)
//                }
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
