import UIKit
import SwiftUI
import Foundation

class OtherCell: UITableViewCell {
    static let identifier = "otherCell"
    private let lessonImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(lessonImageView)
        contentView.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 201/255, alpha: 1)
        lessonImageView.contentMode = .scaleAspectFit
        lessonImageView.clipsToBounds = true
        lessonImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lessonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            lessonImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            lessonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lessonImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            lessonImageView.heightAnchor.constraint(equalToConstant: 100), // Adjust as needed
        ])
    }

    
    func configure(with image: UIImage?) {
        lessonImageView.image = image
    }
}



// Home Page View Controller
class MusicViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {
    
    private var recommendedCollectionView: UICollectionView!
    private var lessonsTableView: UITableView!
    private var textView: UITextView!
    private var textView2: UITextView!
    
    private var recommendedItems: [RecommendedItem] = []
    private var lessonItems: [LessonItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        recommendedCollectionView.dataSource = self
//        recommendedCollectionView.delegate = self
        setupCollectionView()
        setupTextView()
        setupTableView()
        loadItems()
    }
    
    private func setupCollectionView() {
             
        let recommendedLayout = UICollectionViewFlowLayout()
        recommendedLayout.scrollDirection = .horizontal
        recommendedLayout.itemSize = CGSize(width: 150, height: 150) // Set this to your desired size
        recommendedLayout.minimumInteritemSpacing = 0 // Space between items
        recommendedLayout.minimumLineSpacing = 10 // Line spacing - space between rows if the scroll is vertical
        
        recommendedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: recommendedLayout)
        recommendedCollectionView.showsHorizontalScrollIndicator = false
        recommendedCollectionView.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 201/255, alpha: 1)
        recommendedCollectionView.register(RecommendedCell.self, forCellWithReuseIdentifier: RecommendedCell.identifier)
        recommendedCollectionView.dataSource = self
        recommendedCollectionView.delegate = self
        recommendedCollectionView.layer(radius: 20, borderWidth: 1, borderColor: .clear)
        
        view.addSubview(recommendedCollectionView)
        recommendedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recommendedCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80), // Adjust this constant so the collection view doesn't overlap with the top content.
            recommendedCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor), // Left padding
            recommendedCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor), // Right padding
            recommendedCollectionView.heightAnchor.constraint(equalToConstant: 200), // Height of the collection view
        ])
    }
    
    private func setupTextView() {
        textView = UITextView()
        textView.text = "Recommend for you"
        textView.isEditable = false
        textView.isSelectable = false
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.font = UIFont.boldSystemFont(ofSize: 16)
        textView.isScrollEnabled = false
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 20),
        ])
            
        textView2 = UITextView()
        textView2.text = "Other Sounds & Music"
        textView2.isEditable = false
        textView2.isSelectable = false
        textView2.textColor = .black
        textView2.translatesAutoresizingMaskIntoConstraints = false
        textView2.backgroundColor = .clear
        textView2.font = UIFont.boldSystemFont(ofSize: 16)
        textView2.isScrollEnabled = false
        
        view.addSubview(textView2)
        
        NSLayoutConstraint.activate([
            textView2.topAnchor.constraint(equalTo: recommendedCollectionView.bottomAnchor, constant: 20),
            textView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView2.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = AudioViewController()
        detailVC.data = indexPath.row
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = VideoViewController2()
        detailVC.data = indexPath.row
        navigationController?.pushViewController(detailVC, animated: true)
    }

    private func setupTableView() {
        lessonsTableView = UITableView(frame: .zero, style: .plain)
        lessonsTableView.separatorStyle = .none
        lessonsTableView.register(OtherCell.self, forCellReuseIdentifier: OtherCell.identifier)
        lessonsTableView.dataSource = self
        lessonsTableView.delegate = self
        lessonsTableView.rowHeight = UITableView.automaticDimension
        lessonsTableView.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 201/255, alpha: 1)
        lessonsTableView.estimatedRowHeight = 200
        view.addSubview(lessonsTableView)
        lessonsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lessonsTableView.topAnchor.constraint(equalTo: textView2.bottomAnchor, constant: 10),
            lessonsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lessonsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lessonsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func loadItems() {
        recommendedItems = [
            RecommendedItem(imageName: UIImage(named: "instrument sounds")!),
            RecommendedItem(imageName: UIImage(named: "nature sounds")!),
            RecommendedItem(imageName: UIImage(named: "white:pink noises")!)
        ]
        
        lessonItems = [
            LessonItem(imageName: UIImage(named: "15")!),
            LessonItem(imageName: UIImage(named: "14")!),
            LessonItem(imageName: UIImage(named: "13")!)
        ]
    }
    
    // UICollectionViewDataSource and UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedCell.identifier, for: indexPath) as? RecommendedCell else {
            fatalError("Unable to dequeue RecommendedCell")
        }
        cell.configure(with: recommendedItems[indexPath.item].imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Adjust the size of the item based on your layout requirements
        return CGSize(width: view.frame.size.width * 0.5, height: 150)
    }
    
    // UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessonItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherCell.identifier, for: indexPath) as? OtherCell else {
            fatalError("Unable to dequeue LessonCell")
        }
        cell.configure(with: lessonItems[indexPath.row].imageName)
        return cell
    }
    
}
