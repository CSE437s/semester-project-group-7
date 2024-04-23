import UIKit
import SwiftUI
import Foundation

// Models
struct RecommendedItem {
    let imageName: UIImage
}

struct LessonItem {
    let imageName: UIImage
}

// Custom Collection View Cell for Recommended Items
class RecommendedCell: UICollectionViewCell {
    static let identifier = "RecommendedCell"
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func configure(with image: UIImage?) {
        imageView.image = image
    }
}

// Custom Table View Cell for Lessons
class LessonCell: UITableViewCell {
    static let identifier = "LessonCell"
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
        lessonImageView.contentMode = .scaleAspectFill
        lessonImageView.clipsToBounds = true
        lessonImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lessonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            lessonImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            lessonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lessonImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            lessonImageView.heightAnchor.constraint(equalToConstant: 150), // Adjust as needed
        ])
    }

    
    func configure(with image: UIImage?) {
        lessonImageView.image = image
    }
}

// Home Page View Controller
class HomePageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {
    
    private var recommendedCollectionView: UICollectionView!
    private var lessonsTableView: UITableView!
    
    private var recommendedItems: [RecommendedItem] = []
    private var lessonItems: [LessonItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        recommendedCollectionView.dataSource = self
//        recommendedCollectionView.delegate = self
        
        setupCollectionView()
        setupTableView()
        setupSubviews()
        loadItems()
        view.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 201/255, alpha: 1)
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
            recommendedCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 160), // Adjust this constant so the collection view doesn't overlap with the top content.
            recommendedCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor), // Left padding
            recommendedCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor), // Right padding
            recommendedCollectionView.heightAnchor.constraint(equalToConstant: 200), // Height of the collection view
        ])
    }

    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = AudioViewController()
        detailVC.data = indexPath.row
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = VideoViewController()
        detailVC.data = indexPath.row
        navigationController?.pushViewController(detailVC, animated: true)
    }

    private func setupTableView() {
        lessonsTableView = UITableView(frame: .zero, style: .plain)
        lessonsTableView.separatorStyle = .none
        lessonsTableView.register(LessonCell.self, forCellReuseIdentifier: LessonCell.identifier)
        lessonsTableView.dataSource = self
        lessonsTableView.delegate = self
        lessonsTableView.rowHeight = UITableView.automaticDimension
        lessonsTableView.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 201/255, alpha: 1)
        lessonsTableView.estimatedRowHeight = 200
        view.addSubview(lessonsTableView)
        lessonsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lessonsTableView.topAnchor.constraint(equalTo: recommendedCollectionView.bottomAnchor, constant: 10),
            lessonsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lessonsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lessonsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupSubviews() {
        // Profile ImageView setup
        let profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(named: "monkey")
        view.addSubview(profileImageView)
        
        // Settings Button setup
        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(named: "settings"), for: .normal)
        view.addSubview(settingsButton)
        
        // Header Label setup
        let headerLabel = UILabel()
        headerLabel.text = "Good morning, Eri"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 28)
        headerLabel.textColor = .black
        view.addSubview(headerLabel)
        
        // Auto Layout for subviews
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Profile ImageView constraints
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            
            // Settings Button constraints
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            settingsButton.widthAnchor.constraint(equalToConstant: 24),
            settingsButton.heightAnchor.constraint(equalToConstant: 24),
            
            // Header Label constraints
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),

            
            recommendedCollectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
            recommendedCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recommendedCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recommendedCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
        ])
    }
    
    private func loadItems() {
        recommendedItems = [
            RecommendedItem(imageName: UIImage(named: "instrument sounds")!),
            RecommendedItem(imageName: UIImage(named: "nature sounds")!),
            RecommendedItem(imageName: UIImage(named: "white:pink noises")!)
        ]
        
        lessonItems = [
            LessonItem(imageName: UIImage(named: "meditation")!),
            LessonItem(imageName: UIImage(named: "music 1")!),
            LessonItem(imageName: UIImage(named: "journal")!)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LessonCell.identifier, for: indexPath) as? LessonCell else {
            fatalError("Unable to dequeue LessonCell")
        }
        cell.configure(with: lessonItems[indexPath.row].imageName)
        return cell
    }
    
}
