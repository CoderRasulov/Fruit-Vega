//
//  Quize.swift
//  Quize Fruit&Vegetables
//
//  Created by Asliddin Rasulov on 1/20/20.
//  Copyright © 2020 Asliddin. All rights reserved.
//

import UIKit

class Quize: UIViewController {


    @IBOutlet var backViews: [UIView]!
    @IBOutlet var images: [UIImageView]!
    @IBOutlet var pushImages: [UIButton]!
    @IBOutlet weak var nameLabel : UILabel!
    
    var null = 0
    var winCount = 0
    var answar : String = ""
    var arrayImages = imagesArray
    var arrayNames = imagesArray
    var falseAnswars : Int = 0
    var four = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer.stop()
        arrayNames.shuffle()
        fourImages()
    }
    func fourImages() {
        answar = arrayNames[0]
        if answar == "CHERRIES" || answar == "GRAPES" || answar == "BELL PEPPERS" {
            nameLabel.text = "Where are the "
        } else {
            nameLabel.text = "Where is the "
        }
        nameLabel.text = nameLabel.text! + answar.lowercased() + "?"
        arrayNames.remove(at: 0)
        checkArrays()
        for i in 0..<backViews!.count {
            backViews[i].layer.borderColor = UIColor.white.cgColor
            pushImages[i].setBackgroundImage(nil, for: .normal)
            images[i].image = UIImage(named: four[i].lowercased())
        }
    }
    func checkArrays() {
        for _ in 0...3 {
            let randomIndex = Int(arc4random_uniform(UInt32(arrayImages.count)))
            four.append(arrayImages[randomIndex])
            arrayImages.remove(at: randomIndex)
        }
        for i in 0..<four.count {
            if four[i] == answar {
                null = 1; break
            } else {
                null = 0
            }
        }
        if null == 0 {
            four.removeAll()
            arrayImages = imagesArray
            checkArrays()
        }
    }
    @IBAction func imageTapped(_ sender: UIButton) {
        for i in 0..<four.count {
            if images[i].tag == sender.tag {
                if four[i] == answar {
                    playSoundWith(fileName: "Correct", fileExtinsion: "wav")
                    winCount += 1;
                    four.removeAll()
                    arrayImages = imagesArray
                    if winCount == imagesArray.count {
                        let winImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
                        let backWinView = UIButton(frame: CGRect(x: 10, y: 10, width: view.frame.width * 0.1, height: view.frame.height * 0.2))
                        backWinView.setImage(UIImage(named: "backFromSort"), for: .normal)
                        backWinView.addTarget(self, action: #selector(backMenu), for: .touchUpInside)
                        winImageView.image = UIImage(named: "win")
                        winImageView.contentMode = .scaleAspectFill
                        let markOne = UIImageView(frame: CGRect(x: view.frame.width * 0.4, y: view.frame.height * 0.1, width: view.frame.width * 0.2, height: view.frame.width * 0.2))
                        markOne.image = UIImage(named: "stars")
                        let markTwo = UIImageView(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.2, width: view.frame.width * 0.15, height: view.frame.width * 0.15))
                        markTwo.image = UIImage(named: "stars")
                        let markThree = UIImageView(frame: CGRect(x: view.frame.width * 0.65, y: view.frame.height * 0.2, width: view.frame.width * 0.15, height: view.frame.width * 0.15))
                        markThree.image = UIImage(named: "stars")
                        playSoundWith(fileName: "Stars", fileExtinsion: "mp3")
                        if falseAnswars > 3 {
                            winImageView.addSubview(markOne)
                        } else
                        if falseAnswars >= 2 && falseAnswars <= 3 {
                            winImageView.addSubview(markOne)
                            winImageView.addSubview(markTwo)
                        } else
                        if falseAnswars <= 1 {
                            winImageView.addSubview(markOne)
                            winImageView.addSubview(markTwo)
                            winImageView.addSubview(markThree)
                        }
                        view.addSubview(winImageView)
                        view.addSubview(backWinView)
                        playSoundWith(fileName: "Win", fileExtinsion: "mp3")
                    } else {
                        fourImages()
                    }
                } else {
                    sender.setBackgroundImage(UIImage(named: "nonono"), for: .normal)
                    playSoundWith(fileName: "Wrong", fileExtinsion: "wav")
                    falseAnswars += 1
                }
            }
        }
    }
    @objc func backMenu() {
        playSoundWith(fileName: "Back", fileExtinsion: "wav")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func back(_ sender: UIButton) {
        playSoundWith(fileName: "Back", fileExtinsion: "wav")
        dismiss(animated: true, completion: nil)
    }    
}

