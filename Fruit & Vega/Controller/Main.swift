//
//  ViewController.swift
//  Quize Fruit&Vegetables
//
//  Created by Asliddin Rasulov on 1/16/20.
//  Copyright © 2020 Asliddin. All rights reserved.
//

import UIKit
import AVFoundation

var audioPlayer : AVAudioPlayer!

func playSoundWith(fileName: String, fileExtinsion: String) -> Void {
    
    let audioSourceURL = Bundle.main.path(forResource: fileName, ofType: fileExtinsion)
    
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioSourceURL!))
    } catch {
        print(error)
    }
    audioPlayer.play()
}


class Main: UIViewController {

    @IBOutlet weak var questionAnimation: UIImageView!
    @IBOutlet weak var notaAnimation: UIImageView!
    @IBOutlet weak var sunAnimation: UIImageView!
    
    var animation : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        playSoundWith(fileName: "Menu", fileExtinsion: "mp3")
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionAnimation.transform = CGAffineTransform.identity
        notaAnimation.transform = CGAffineTransform.identity
        sunAnimation.transform = CGAffineTransform.identity
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if self.animation == 0 {
                UIView.animate(withDuration: 1, animations: {
                    self.questionAnimation.transform = CGAffineTransform(scaleX: 1, y: 0.8)
                    self.notaAnimation.transform = CGAffineTransform(scaleX: 1, y: 0.8)
                    self.sunAnimation.transform = CGAffineTransform(scaleX: 1, y: 0.8)
                    self.animation = 1
                })
            } else {
                UIView.animate(withDuration: 1, animations: {
                    self.questionAnimation.transform = CGAffineTransform(scaleX: 0.8, y: 1)
                    self.notaAnimation.transform = CGAffineTransform(scaleX: 0.8, y: 1)
                    self.sunAnimation.transform = CGAffineTransform(scaleX: 0.8, y: 1)
                    self.animation = 0
                })
            }
        }
    }
}

