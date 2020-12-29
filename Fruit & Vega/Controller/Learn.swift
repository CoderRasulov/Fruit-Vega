//
//  LearnViewController.swift
//  Quize Fruit&Vegetables
//
//  Created by Asliddin Rasulov on 1/17/20.
//  Copyright © 2020 Asliddin. All rights reserved.
//

import UIKit
import AVFoundation


class Learn: UIViewController  {    
    
    @IBOutlet weak var backward: UIButton!
    @IBOutlet weak var forward: UIButton!
    @IBOutlet weak var collectionView : UICollectionView!
    
    let showAlert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
    let speechSynthesizer = AVSpeechSynthesizer()
    var ward = 0
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        audioPlayer.stop()
        let speechUtterance = AVSpeechUtterance(string: imagesArray[ward])
        DispatchQueue.main.async {
            self.speechSynthesizer.speak(speechUtterance)
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        playSoundWith(fileName: "Back", fileExtinsion: "wav")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func forward(_ sender: UIButton) {
        playSoundWith(fileName: "Back", fileExtinsion: "wav")
        
        if ward == imagesArray.count - 1 {
            ward = -1
        }
        
        ward += 1
        
        let speechUtterance = AVSpeechUtterance(string: imagesArray[ward])
        DispatchQueue.main.async {
            self.speechSynthesizer.speak(speechUtterance)
        }
        
        collectionView.reloadData()
    }
    
    @IBAction func backward(_ sender: UIButton) {
        playSoundWith(fileName: "Back", fileExtinsion: "wav")
        
        if ward == 0 {
            ward = imagesArray.count
        }
        
        ward -= 1
        
        let speechUtterance = AVSpeechUtterance(string: imagesArray[ward])
        DispatchQueue.main.async {
            self.speechSynthesizer.speak(speechUtterance)
        }
        
        collectionView.reloadData()
    }
}

extension Learn: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.size.width, height: collectionView.frame.size.height
        )
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "learnCell", for: indexPath) as! LearnCell
        cell.imageView.image = UIImage(named: imagesArray[ward].lowercased())
        cell.nameLabel.text = imagesArray[ward]
        return cell
    }
    
}
