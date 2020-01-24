//
//  SecondViewController.swift
//  PageControl
//
//  Created by Marni Anuradha on 12/12/19.
//  Copyright © 2019 Marni Anuradha. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class SecondViewController: UIViewController {

    
    @IBOutlet weak var stackView: UIStackView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var storyLabel: UITextView!
    
  
    
    @IBOutlet weak var videoView: UIView!
    
    var AV:AVPlayerViewController!
    var details:Int!
    var audiotag:Int?
    var audioAV:AVPlayerViewController!
    var storeData = [Media]()
    var  actors = [String]()
    var button:UIButton!
     var allSongTitles = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     story()
        // Do any additional setup after loading the view.
    }
    

        func story(){


             actors = storeData[details].actors!
            
            for a in 0...actors.count-1
            {     let actorLbl = UILabel()
                actorLbl.textAlignment = .center
                actorLbl.text = "\(actors[a])"
                actorLbl.textAlignment = .center
                actorLbl.font = actorLbl.font.withSize(25)
                stackView.addArrangedSubview(actorLbl)
                

            }
    //        let title = storeData[details].title!

            titleLabel.text = storeData[details].title!

            //titleLbl.text = "\(title)"

            let idata = storeData[details].posters!

            let posterIdata = idata[0]
            let imageUrlString = "https://www.brninfotech.com/tws/\(posterIdata)"
            let newUrl = imageUrlString.replacingOccurrences(of: " ", with:"%20")
            let imageUrl = URL(string: newUrl)
            let imageData = try! Data(contentsOf: imageUrl!)
            let images = UIImage(data: imageData)
            imageView.image = images
            storyLabel.text=storeData[details].story ?? "Story is not Avilable"

            AV = AVPlayerViewController()

            let video  = storeData[details].trailers!
            let videoData = video[0]
            let AVUrlString = "https://www.brninfotech.com/tws/\(videoData)"
            
            let AVUrl = AVUrlString.replacingOccurrences(of: " ", with:"%20")


            AV.player = AVPlayer(url: URL(string:AVUrl)!)

            AV.view.frame = CGRect(x: 0, y: 0, width: videoView.frame.width, height: videoView.frame.height)
                videoView.addSubview(AV.view)




            let audio = storeData[details].songs!

            // for loop for Audio Songs
            if(audio.count != 0){
            for a in  0...audio.count-1{

              button = UIButton()
                button.backgroundColor = .gray
                
               
                button.setTitle("Song\(a)", for: UIControl.State.normal)

                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: 40).isActive = true
                button.widthAnchor.constraint(equalToConstant: 300).isActive = true
                stackView.addArrangedSubview(button)
                button.tag = a
                button.addTarget(self, action: #selector(addtarget), for: UIControl.Event.touchUpInside)


            }
            }
            else{
                print("songs not avilable ")
            }
            
       
        }

      //  addtarget functon to button
        
        @objc func addtarget (audioTag:UIButton)
        {
            AV.player?.pause()
             audiotag = audioTag.tag
            let audio = storeData[details].songs!
            let audioData = audio[audiotag!]
            let audioUrlString = "https://www.brninfotech.com/tws/\(audioData)"
            let audioURL = audioUrlString.replacingOccurrences(of: " ", with: "%20")
            print(audioURL)
            let audioPlayer = AVPlayer(url: URL(string: audioURL)!)
            audioAV = AVPlayerViewController()
            audioAV.player = audioPlayer
            audioAV.player?.play()
            present(audioAV, animated: true) {

            }

        }

    @IBAction func onBackBtn(_ sender: UIButton) {
        dismiss(animated: true) {

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
