//
//  FeelQAViewController.swift
//  group_7
//
//  Created by 李长鸿 on 27/02/2024.
//

import UIKit
import SwiftUI
import SDWebImage
import SwiftyJSON

class FeelQAViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var selectedEmojiIndexPath: IndexPath?


    @IBOutlet weak var currentCollectionView: UICollectionView!
    let reuseIdentifier = "avatercell"
    
    lazy var imagesUrlsSource: [String] = {
        if let fileUrl = Bundle.main.url(forResource: "img", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                let json = try JSON(data: data)
                let avatarTypeArray = json["emoji"]["list"].arrayValue
                let sectionNumber = avatarTypeArray.count
                var res: [String] = []
                for avatarTypeValue in avatarTypeArray {
                    let imgUrl = avatarTypeValue["url"].stringValue
                    res.append(imgUrl)
                }
                return res
            } catch {
                print("读取JSON文件失败: \(error.localizedDescription)")
                return []
            }
        } else {
            print("JSON文件不存在")
            return []
        }
    }()
    
    var fullScreenSize :CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullScreenSize = UIScreen.main.bounds.size
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 50, left: 50, bottom: 15, right: 50)
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 30;
        layout.itemSize = CGSizeMake(
          CGFloat(fullScreenSize.width-130)/4,
          CGFloat(fullScreenSize.width-130)/4)
        currentCollectionView.collectionViewLayout = layout
        currentCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        currentCollectionView.delegate = self
        currentCollectionView.dataSource = self
        currentCollectionView.isPagingEnabled = true
        currentCollectionView.backgroundColor = .clear
    }
    
    @IBAction func confirmButtonTapped() {
        // Check if an emoji has been selected
        guard let indexPath = selectedEmojiIndexPath else {
            // Show an alert if no emoji has been selected
            let alert = UIAlertController(title: "Selection Required", message: "Please select an emoji to proceed.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        // Retrieve the selected emoji URL using the selected index path
        let selectedEmojiURL = imagesUrlsSource[indexPath.item]

        // Save the selected emoji URL in UserDefaults
        UserDefaults.standard.set(selectedEmojiURL, forKey: "emoji")    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesUrlsSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        // 设置cell的背景颜色和边框
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.clear.cgColor
        // 设置cell的图片
        _ = UIImageView()
        let imageUrl = imagesUrlsSource[indexPath.item]
        cell.imgUrl = imageUrl
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.cornerRadius = 25
            cell.layer.borderWidth = 6

            // Update the selected emoji index path
            selectedEmojiIndexPath = indexPath
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderColor = UIColor.clear.cgColor
            cell.layer.cornerRadius = 0
            cell.layer.borderWidth = 0

            // Clear the selected emoji index path if it's the one being deselected
            if selectedEmojiIndexPath == indexPath {
                selectedEmojiIndexPath = nil
            }
        }
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
 
extension FeelQAViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 50, bottom: 20, right: 50)
    }
}
