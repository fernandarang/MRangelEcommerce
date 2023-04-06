//
//  PDFViewController.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 03/04/23.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {

    
    var pdfData : Data?
    var productoViewModel = ProductoViewModel()
    var productos = [Producto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func generatePDF(_ sender: Any) {
        pdfLoadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? PDF2ViewController {
                vc.documentData = pdfData
            }
        }
    
    func pdfLoadData(){
        let result = productoViewModel.GetAll()
        if result.Correct{
            productos = result.Objects! as! [Producto]
            let pdfData = generatePdfData(productos: productos)
            self.pdfData = pdfData
            self.performSegue(withIdentifier: "PDFSegue", sender: self)
        }
    }
    
    
    func generatePdfData(productos : [Producto]) -> Data {
        let pdfMetaData = [
            kCGPDFContextCreator: "mrangelecommerce",
            kCGPDFContextAuthor: "Fernanda Rangel",
            kCGPDFContextTitle: "Lista de Productos"
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageRect = CGRect(x: 10, y: 10, width: 595.2, height: 841.8)
        let graphicsRenderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = graphicsRenderer.pdfData { (context) in
            context.beginPage()
            
            let initialCursor: CGFloat = 32
            
             var cursor = context.addCenteredText(fontSize: 32, weight: .bold, text: "Lista de Productos", cursor: initialCursor, pdfSize: pageRect.size)
            
            cursor+=42 // Add white space after the Title
            
            for producto in productos {
                            cursor = generateProductoText(producto: producto, context: context, cursorY: cursor, pdfSize: pageRect.size)
                        }
                    }
                    return data
        }
    
    func generateProductoText(producto: Producto, context: UIGraphicsPDFRendererContext, cursorY: CGFloat, pdfSize: CGSize) -> CGFloat {
            var cursor = cursorY
            let leftMargin: CGFloat = 74
            
            
        if let Nombre = producto.Nombre {
                cursor = context.addSingleLineText(fontSize: 14, weight: .bold, text:  Nombre, indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: .underline, annotationColor: .black)
                cursor+=6
            
            if let descripcion = producto.Descripcion {
                    cursor = context.addMultiLineText(fontSize: 11, weight: .thin, text: "Descripcion: \(descripcion)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize)
                    cursor+=2
                }
                
            if let Precio = producto.PrecioUnitario{
                cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Precio Unitario: $\(Precio)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
                cursor+=2
            }
            if let Stock = producto.Stock{
                cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Stock: \(Stock)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
                cursor+=2
            }
            if let Proveedor = producto.Proveedor?.Nombre{
                cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Proveedor: \(Proveedor)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
                cursor+=2
            }
            if let Departamento = producto.Departamento?.Nombre{
                cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Departamento: \(Departamento)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
                cursor+=2
            }
                cursor+=8
            }
            
            return cursor
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
extension UIGraphicsPDFRendererContext{
    func addCenteredText(fontSize: CGFloat,
                             weight: UIFont.Weight,
                             text: String,
                             cursor: CGFloat,
                             pdfSize: CGSize) -> CGFloat {
            
            let textFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
            let pdfText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: textFont])
            
            let rect = CGRect(x: pdfSize.width/2 - pdfText.size().width/2, y: cursor, width: pdfText.size().width, height: pdfText.size().height)
            pdfText.draw(in: rect)
            
            return self.checkContext(cursor: rect.origin.y + rect.size.height, pdfSize: pdfSize)
        }
    func addSingleLineText(fontSize: CGFloat,
                               weight: UIFont.Weight,
                               text: String,
                               indent: CGFloat,
                               cursor: CGFloat,
                               pdfSize: CGSize,
                               annotation: PDFAnnotationSubtype?,
                               annotationColor: UIColor?) -> CGFloat {
            
            let textFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
            let pdfText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: textFont])
            
            let rect = CGRect(x: indent, y: cursor, width: pdfSize.width - 2*indent, height: pdfText.size().height)
            pdfText.draw(in: rect)
            
            if let annotation = annotation {
                let annotation = PDFAnnotation(
                    bounds: CGRect.init(x: indent, y: rect.origin.y + rect.size.height, width: pdfText.size().width, height: 10),
                    forType: annotation,
                    withProperties: nil)
                annotation.color = annotationColor ?? .black
                annotation.draw(with: PDFDisplayBox.artBox, in: self.cgContext)
            }
            
            return self.checkContext(cursor: rect.origin.y + rect.size.height, pdfSize: pdfSize)
        }
        
        func addMultiLineText(fontSize: CGFloat,
                              weight: UIFont.Weight,
                              text: String,
                              indent: CGFloat,
                              cursor: CGFloat,
                              pdfSize: CGSize) -> CGFloat {
            
            let textFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            paragraphStyle.lineBreakMode = .byWordWrapping

            let pdfText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: textFont])
            let pdfTextHeight = pdfText.height(withConstrainedWidth: pdfSize.width - 2*indent)
            
            let rect = CGRect(x: indent, y: cursor, width: pdfSize.width - 2*indent, height: pdfTextHeight)
            pdfText.draw(in: rect)

            return self.checkContext(cursor: rect.origin.y + rect.size.height, pdfSize: pdfSize)
        }
        
        func checkContext(cursor: CGFloat, pdfSize: CGSize) -> CGFloat {
            if cursor > pdfSize.height - 100 {
                self.beginPage()
                return 40
            }
            return cursor
        }
}
extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
    
        return ceil(boundingBox.height)
    }
}







