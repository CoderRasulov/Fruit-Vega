//
//  LearnCell.swift
//  Quize Fruit&Vegetables
//
//  Created by Asliddin Rasulov on 1/17/20.
//  Copyright © 2020 Asliddin. All rights reserved.
//

import UIKit
import AVFoundation

class LearnCell: UICollectionViewCell, AVSpeechSynthesizerDelegate {
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
        
    let speechSynthesizer = AVSpeechSynthesizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        speechSynthesizer.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        speechSynthesizer.stopSpeaking(at: .word)
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        animation()
        let speechUtterance = AVSpeechUtterance(string: nameLabel.text!)
        DispatchQueue.main.async {
            self.speechSynthesizer.speak(speechUtterance)
        }
    }
    func animation() {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.toValue = 1.2
        pulse.duration = 0.6
        pulse.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulse.autoreverses = true
        imageView.layer.add(pulse, forKey: nil)
    }
}

