//
//  ViewController.swift
//  PageControl
//
//  Created by Marni Anuradha on 12/12/19.
//  Copyright © 2019 Marni Anuradha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button:UIButton!
    var titleLbl:UILabel!
    var buttonArry:[UIButton] = []
    var lblArry:[UILabel] = []
    var convertedData = [Media]()

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func loadBtnTap(_ sender: UIButton) {
        convertedData = mediaData()
         
         
         // lops for remove posters
         
         for y in buttonArry{
             
             y.removeFromSuperview()
         }
         // lops for remove titles

         for x in lblArry{
             
             x.removeFromSuperview()
         }
        
         // lops for WholeData
         
         for i in 0...convertedData.count-1
         {
             
             stackView.spacing = 20
             
             let idata = convertedData[i].posters!
             let posterIdata = idata[0]
             let imageUrlString = "https://www.brninfotech.com/tws/\(posterIdata)"
             let newUrl = imageUrlString.replacingOccurrences(of: " ", with:"%20")
             let imageUrl = URL(string: newUrl)
             let imageData = try! Data(contentsOf: imageUrl!)
             let images = UIImage(data: imageData)
             
             // button for posters
             
             button = UIButton()
             button.setImage(images as? UIImage, for: UIControl.State.normal)
             button.translatesAutoresizingMaskIntoConstraints = false
             button.heightAnchor.constraint(equalToConstant: 200).isActive = true
             button.widthAnchor.constraint(equalToConstant: 300).isActive = true
             button.backgroundColor = .green
             buttonArry.append(button)
             button.tag = i
             stackView.addArrangedSubview(button)
             button.addTarget(self, action: #selector(addTargetTobtn), for: UIControl.Event.touchUpInside)
             
             // label for titles

             let lblData = convertedData[i].title!
             titleLbl = UILabel()
             titleLbl.text = "\(lblData)"
             titleLbl.textAlignment = .center
             titleLbl.font = titleLbl.font.withSize(25)
             lblArry.append(titleLbl)
             stackView.addArrangedSubview(titleLbl)

             print(titleLbl.text!)
             
             
         }
        
    }
    
    
       // addTargetTobtn func for button
       
       @objc func addTargetTobtn(data:UIButton){
           let sVC = self.storyboard?.instantiateViewController(withIdentifier: "sVC") as! SecondViewController
           
                sVC.details = data.tag
          
           sVC.storeData = self.convertedData
           
           present(sVC, animated: true) {
               
           }
       }
    
    
    func mediaData()->[Media]
    {
        var decoderData:[Media]!
        
        var URLReqObj:URLRequest!
        var dataTaskObj:URLSessionDataTask!
        URLReqObj = URLRequest(url: URL(string:"https://www.brninfotech.com/tws/MovieDetails2.php?mediaType=movies")!)
        
        dataTaskObj = URLSession.shared.dataTask(with: URLReqObj, completionHandler:{(data,connDetails,err)in
            print("got data from server")
            
            do{
                
                let decoder = JSONDecoder()
                decoderData = try decoder.decode([Media].self, from: data!)
                
               
            }
            catch{
                
                print("somthing went wrong")
            }
            
            
        })
        
        
        
        
        dataTaskObj.resume()
        
        while decoderData == nil {
        }
        return decoderData

    }

}

