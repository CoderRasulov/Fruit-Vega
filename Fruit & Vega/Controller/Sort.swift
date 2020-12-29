//
//  Sort.swift
//  Quize Fruit&Vegetables
//
//  Created by Asliddin Rasulov on 1/22/20.
//  Copyright © 2020 Asliddin. All rights reserved.
//

import UIKit

class Sort: UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var sortMenuView: UIView!
    @IBOutlet weak var imageBasket: UIImageView!
    @IBOutlet var checkImage: [UIImageView]!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var correctlabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var arrayImages = imagesArray
    var selectArray : [String]!
    var indexRepeat : Int = -1
    var difference : Bool = true
    var correct : Double = 0.0
    var wrong : Double = 0.0
    var isBack = false
    var checkIndex : [Int] = [-1]
    var time : Int = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer.stop()
        arrayImages.shuffle()
        selectArray = arrayImages
        collectionView.backgroundColor = .none
    }
    @objc func backMenu() {
        isBack = true
        playSoundWith(fileName: "Back", fileExtinsion: "wav")
        dismiss(animated: true, completion: nil)
    }

    func autoScroll () {
        let offSet = collectionView.contentOffset.x + 3
        UIView.animate(withDuration: 0.001, delay: 0, options: .allowUserInteraction, animations: {
            self.collectionView.contentOffset = CGPoint(x: offSet, y: 0)
        }) { (finished) in
            if !self.isBack {
                self.autoScroll()
            }
        }
        if time == 0 {
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
            if correct < (correct + wrong) * 0.7 {
                winImageView.addSubview(markOne)
            } else
            if correct >= (correct + wrong) * 0.7 && correct < (correct + wrong) * 0.9  {
                winImageView.addSubview(markOne)
                winImageView.addSubview(markTwo)
            } else
            if correct >= (correct + wrong) * 0.9 {
                winImageView.addSubview(markOne)
                winImageView.addSubview(markTwo)
                winImageView.addSubview(markThree)
            }
            view.addSubview(winImageView)
            view.addSubview(backWinView)
            playSoundWith(fileName: "Win", fileExtinsion: "mp3")
        }
    }
    @available(iOS 10.0, *)
    @IBAction func sortName(_ sender: UIButton) {
        sortMenuView.isHidden = true
        self.isBack = false
        if sender.tag == 0 {
            difference = true
            imageBasket.image = UIImage(named: "basketFruits")
        } else {
            difference = false
            imageBasket.image = UIImage(named: "basketVegetables")
        }
        checkImage[0].image = UIImage(named: "true")
        checkImage[1].image = UIImage(named: "false")
        collectionView.isHidden = false
        autoScroll()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.time = Int(self.timerLabel.text!)! - 1
            self.timerLabel.text = "\(self.time)"
        }
    }
    func check(word : String) {
        if (difference && fruits.contains(word)) || (!difference && vegetables.contains(word)) {
            correct += 1
            playSoundWith(fileName: "Correct", fileExtinsion: "wav")
            correctlabel.text = "\(Int(correct))"
        } else
        if (difference && !fruits.contains(word)) || (!difference && !vegetables.contains(word)) {
            wrong += 1
            playSoundWith(fileName: "Wrong", fileExtinsion: "wav")
            wrongLabel.text = "\(Int(wrong))"
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        isBack = true
        playSoundWith(fileName: "Back", fileExtinsion: "wav")
        dismiss(animated: true, completion: nil)
    }
}
extension Sort: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImages.count * 100
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sortCell", for: indexPath) as! SortCell
        if indexRepeat >= arrayImages.count - 1 {
            arrayImages.shuffle()
            selectArray! += arrayImages
            indexRepeat = 0
        } else {
            indexRepeat += 1
        }
        cell.imageView.image = UIImage(named: arrayImages[indexRepeat].lowercased())
        cell.nameLabel.text = arrayImages[indexRepeat]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width * 0.7 / 5, height: self.view.frame.size.height * 0.45)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !checkIndex.contains(indexPath.row) {
            playSoundWith(fileName: "Back", fileExtinsion: "wav")
            check(word: selectArray![indexPath.row])
            checkIndex.append(indexPath.row)
        }
    }
}
