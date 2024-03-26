//
//  AvatarQAViewController.swift
//  group_7
//
//  Created by 李长鸿 on 27/02/2024.
//
 
import UIKit
import SwiftUI
import SDWebImage
import SwiftyJSON

class AvatarQAViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var selectedAvatarIndexPath: IndexPath?

    @IBOutlet weak var currentCollectionView: UICollectionView!
    let reuseIdentifier = "avatercell"
    
    lazy var imagesUrlsSource: (Int, [String]) = {
        if let fileUrl = Bundle.main.url(forResource: "img", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                let json = try JSON(data: data)
                let avatarTypeArray = json["avatar"].arrayValue
                let sectionNumber = avatarTypeArray.count
                var res: [String] = []
                for avatarTypeValue in avatarTypeArray {
                    let imgUrls = avatarTypeValue["list"].arrayValue
                    let urls = imgUrls.map { $0.stringValue }
                    res.append(contentsOf: urls)
                }
                return (sectionNumber, res)
            } catch {
                print("Error reading JSON file: \(error.localizedDescription)")
                return (0, [])
            }
        } else {
            print("JSON file not found")
            return (0, [])
        }
    }()
    
    var fullScreenSize :CGSize!
    
    let rightArrowImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullScreenSize = UIScreen.main.bounds.size
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 15, left: 25, bottom: 15, right: 25)
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSizeMake(
            CGFloat(fullScreenSize.width-60)/3,
            CGFloat(fullScreenSize.width-60)/3)
        currentCollectionView.collectionViewLayout = layout
        currentCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        currentCollectionView.delegate = self
        currentCollectionView.dataSource = self
        currentCollectionView.isPagingEnabled = true
        currentCollectionView.backgroundColor = .clear
        
        setupArrowIndicator()
    }
    
    func setupArrowIndicator() {
        // Configure the arrow image
        rightArrowImageView.image = UIImage(systemName: "arrow.right") // Use a system image or your own
        rightArrowImageView.tintColor = .gray // Set the color
        rightArrowImageView.contentMode = .scaleAspectFit
        
        // Add the arrow image view to the view
        view.addSubview(rightArrowImageView)
        
        // Set constraints or frame
        rightArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightArrowImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20), // 20 points from the trailing edge
            rightArrowImageView.centerYAnchor.constraint(equalTo: currentCollectionView.centerYAnchor), // Centered vertically in line with the collection view
            rightArrowImageView.widthAnchor.constraint(equalToConstant: 30), // Width of the arrow
            rightArrowImageView.heightAnchor.constraint(equalToConstant: 30) // Height of the arrow
        ])
    }
    
    @IBAction func nextButtonTapped() {
        // Check if an avatar has been selected
         guard let indexPath = selectedAvatarIndexPath else {
             // Show an alert if no avatar has been selected
             showAlert(withMessage: "Please select an avatar to proceed.")
             return
         }

         // Calculate the index in the flat URL array
         let index = indexPath.section * 9 + indexPath.row  // Assuming each section has exactly 9 items

         // Ensure the index is within bounds of the URLs array
         guard imagesUrlsSource.1.indices.contains(index) else {
             showAlert(withMessage: "Error retrieving the avatar URL.")
             return
         }

         // Retrieve the selected URL using the calculated index
         let selectedAvatarURL = imagesUrlsSource.1[index]

         // Save the selected avatar URL in UserDefaults
         UserDefaults.standard.set(selectedAvatarURL, forKey: "SelectedAvatarURL")
    }
    
    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Selection Required", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        // 设置cell的背景颜色和边框
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.clear.cgColor
        let index = indexPath.section*9 + indexPath.item
        NSLog("section = \(indexPath.section) index = \(index)")
        let imageUrl = imagesUrlsSource.1[index]
        cell.imgUrl = imageUrl
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderColor = UIColor.clear.cgColor
            cell.layer.cornerRadius = 0
            cell.layer.borderWidth = 0
        }
        
        // Clear the selected avatar if it's the one being deselected
        if selectedAvatarIndexPath == indexPath {
            selectedAvatarIndexPath = nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.cornerRadius = 25
            cell.layer.borderWidth = 6
            cell.layer.masksToBounds = true
            
            // Track the selected avatar
            selectedAvatarIndexPath = indexPath
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return imagesUrlsSource.0
    }
}
 
