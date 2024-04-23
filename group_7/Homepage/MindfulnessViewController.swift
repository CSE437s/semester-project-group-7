import UIKit
import SwiftUI
import Foundation


class Lesson3Cell: UITableViewCell {
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
            lessonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
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
class MindfulnessViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var lessonsTableView: UITableView!
    
    private var lessonItems: [LessonItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadItems()
    }
        
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = VideoViewController3()
        detailVC.data = indexPath.row
        navigationController?.pushViewController(detailVC, animated: true)
    }

    private func setupTableView() {
        lessonsTableView = UITableView(frame: .zero, style: .plain)
        lessonsTableView.separatorStyle = .none
        lessonsTableView.register(Lesson3Cell.self, forCellReuseIdentifier: Lesson3Cell.identifier)
        lessonsTableView.dataSource = self
        lessonsTableView.delegate = self
        lessonsTableView.rowHeight = UITableView.automaticDimension
        lessonsTableView.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 201/255, alpha: 1)
        lessonsTableView.estimatedRowHeight = 200
        view.addSubview(lessonsTableView)
        lessonsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lessonsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            lessonsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lessonsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lessonsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    
    private func loadItems() {
        lessonItems = [
            LessonItem(imageName: UIImage(named: "10")!),
            LessonItem(imageName: UIImage(named: "11")!),
            LessonItem(imageName: UIImage(named: "12")!)
        ]
    }
    
    // UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessonItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Lesson3Cell.identifier, for: indexPath) as? Lesson3Cell else {
            fatalError("Unable to dequeue LessonCell")
        }
        cell.configure(with: lessonItems[indexPath.row].imageName)
        return cell
    }
    
}
