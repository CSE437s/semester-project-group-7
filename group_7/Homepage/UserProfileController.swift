//
//  User Controller.swift
//  group_7
//
//  Created by Byeongjun Oh on 3/20/24.
//

import Foundation
import UIKit
import SwiftUI
import SwiftUICharts
import HealthKit

class UserProfileController: UIViewController{
    
    @IBOutlet weak var EnergyLevel: UIImageView!
    @IBOutlet weak var feeling: UIImageView!
    @IBOutlet weak var monkey: UIImageView!
    @IBOutlet weak var dedication: UIImageView!
    @IBOutlet weak var activity: UIImageView!
    @IBOutlet weak var somethingnew: UIImageView!
    @IBOutlet weak var point: UIImageView!
    
    @IBOutlet weak var monkeycircle: UIView!
    private let healthStore = HKHealthStore()
       private var healthKitPermissionsGranted = false
       
       private lazy var scrollView: UIScrollView = {
           let scrollView = UIScrollView()
           scrollView.translatesAutoresizingMaskIntoConstraints = false
           return scrollView
       }()
       
       private lazy var closeButton: UIButton = {
           let button = UIButton()
           button.setTitle("x", for: .normal)
           button.setTitleColor(.black, for: .normal)
           button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
           button.widthAnchor.constraint(equalToConstant: 50).isActive = true
           button.heightAnchor.constraint(equalToConstant: 50).isActive = true
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()
       
       private lazy var containerView: UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       private lazy var textBox: UIView = {
           let view = UIView()
           view.backgroundColor = .lightGray
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       private lazy var textView: UITextView = {
           let textView = UITextView()
           textView.text = "Text View"
           textView.font = .boldSystemFont(ofSize: 15)
           textView.textColor = .black
           textView.translatesAutoresizingMaskIntoConstraints = false
           return textView
       }()
       
       private lazy var subTextView: UITextView = {
           let textView = UITextView()
           textView.text = "Sub Text"
           textView.font = .systemFont(ofSize: 9)
           textView.textColor = .black
           textView.translatesAutoresizingMaskIntoConstraints = false
           return textView
       }()
       
       private lazy var swichButton: UISwitch = {
           let switchButton = UISwitch()
           switchButton.translatesAutoresizingMaskIntoConstraints = false
           return switchButton
       }()
       
       @objc func appBecameActive() {
           checkAndRequestHealthKitAuthorizationIfNeeded()
       }
       
       override func viewDidLoad() {
           super.viewDidLoad()
           setupViews()
           
           NotificationCenter.default.addObserver(
               self,
               selector: #selector(appBecameActive),
               name: UIApplication.didBecomeActiveNotification,
               object: nil
           )
       }
       
       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           checkAndRequestHealthKitAuthorizationIfNeeded()
       }
       
       override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
           NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
       }

       override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           setupDottedBorders()
       }

       private func setupViews() {
           setupContainerView()
           setupTextBox()
           setupTextView()
           setupSubTextView()
           setupSwitchButton()
           setupScrollView()
           setupCloseButton()
           setupIconsBackground()
           setupImage()
       }
       
       private func setupImage() {
           let energy = UIImageView(frame: CGRectMake(6.5, 3, 50, 50))
           energy.image = UIImage(named: "low-battery")
           EnergyLevel.addSubview(energy)
           EnergyLevel.bringSubviewToFront(energy)
           
           let emotion = UIImageView(frame: CGRectMake(6.5, 4, 50, 50))
           emotion.image = UIImage(named: "sad")
           feeling.addSubview(emotion)
           
           let time = UIImageView(frame: CGRectMake(6.5, 3, 50, 50))
           time.image = UIImage(named: "clock")
           dedication.addSubview(time)
           
           let note = UIImageView(frame: CGRectMake(6.5, 3, 50, 50))
           note.image = UIImage(named: "music-note")
           activity.addSubview(note)
           
           let stress = UIImageView(frame: CGRectMake(6.5, 3, 50, 50))
           stress.image = UIImage(named: "stress-management")
           somethingnew.addSubview(stress)
           
           let finger = UIImageView(frame: CGRectMake(6.5, 3, 50, 50))
           finger.image = UIImage(named: "point")
           point.addSubview(finger)
       }

       private func setupIconsBackground() {
           let iconViews = [monkeycircle]
           iconViews.forEach { imageView in
               guard let imageView = imageView else { return }
               imageView.backgroundColor = .white
               imageView.layer.cornerRadius = imageView.frame.height / 2
               imageView.clipsToBounds = true
               imageView.layer.borderColor = UIColor.orange.cgColor
               imageView.layer.borderWidth = 2.0
           }

   //        // Additional setup for the monkey UIImageView if needed
   //        monkey.layer.cornerRadius = monkey.frame.height / 2
   //        monkey.clipsToBounds = true
   //        monkey.layer.borderColor = UIColor.orange.cgColor
   //        monkey.layer.borderWidth = 2.0
       }

       private func setupDottedBorders() {
           let viewsWithDottedBorder = [EnergyLevel, feeling, dedication, activity, somethingnew, point]
           viewsWithDottedBorder.forEach { view in
               if let view = view {
                   addDottedBorder(to: view)
               }
           }
       }

       private func addDottedBorder(to view: UIView) {
           let borderColor = UIColor.orange.cgColor
           let borderWidth: CGFloat = 2.0
           let dottedLinePattern: [NSNumber] = [4, 4]

           let shapeLayer = CAShapeLayer()
           shapeLayer.strokeColor = borderColor
           shapeLayer.lineWidth = borderWidth
           shapeLayer.fillColor = UIColor.white.cgColor
           shapeLayer.lineDashPattern = dottedLinePattern
           let path = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.height/2)
           shapeLayer.path = path.cgPath
           
           view.layer.insertSublayer(shapeLayer, at: 0)
       }
       
       private func setupContainerView() {
           view.addSubview(containerView)
           NSLayoutConstraint.activate([
               containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               containerView.topAnchor.constraint(equalTo: point.bottomAnchor, constant: 20),
               containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
           containerView.backgroundColor = .clear
           containerView.isHidden = true
       }
       
       private func setupTextBox() {
           containerView.addSubview(textBox)
           NSLayoutConstraint.activate([
               textBox.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
               textBox.topAnchor.constraint(equalTo: containerView.topAnchor),
               textBox.heightAnchor.constraint(equalToConstant: 80),
               textBox.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)])
           textBox.backgroundColor = .white
       }
       
       private func setupTextView() {
           textView.isEditable = false
           textBox.addSubview(textView)
           NSLayoutConstraint.activate([
               textView.topAnchor.constraint(equalTo: textBox.topAnchor),
               textView.leadingAnchor.constraint(equalTo: textBox.leadingAnchor),
               textView.trailingAnchor.constraint(equalTo: textBox.trailingAnchor),
               textView.heightAnchor.constraint(equalToConstant: 30)])
           textView.backgroundColor = .clear
       }
       
       private func setupSubTextView() {
           subTextView.isEditable = false
           textBox.addSubview(subTextView)
           NSLayoutConstraint.activate([
               subTextView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 4),
               subTextView.leadingAnchor.constraint(equalTo: textBox.leadingAnchor),
               subTextView.trailingAnchor.constraint(equalTo: textBox.trailingAnchor),
               subTextView.bottomAnchor.constraint(equalTo: textBox.bottomAnchor)])
           subTextView.backgroundColor = .clear
       }
       
       private func setupSwitchButton() {
           textBox.addSubview(swichButton)
           swichButton.isHidden = true
           NSLayoutConstraint.activate([
            swichButton.topAnchor.constraint(equalTo: textBox.topAnchor, constant: 20),
               swichButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
       }
       
       private func setupScrollView() {
           containerView.addSubview(scrollView)
           NSLayoutConstraint.activate([
               scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               scrollView.topAnchor.constraint(equalTo: textBox.bottomAnchor, constant: 20),
               scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
           scrollView.backgroundColor = UIColor(red: 255, green: 248, blue: 201, alpha: 1)
       }

       private func setupCloseButton() {
           containerView.addSubview(closeButton)
           NSLayoutConstraint.activate([
               closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -5),
               closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)])
       }

       @objc private func closeButtonTapped() {
           containerView.isHidden = true
           swichButton.isHidden = true
       }
       
       @IBAction func Dailymission(_ sender: UIButton) {
           containerView.isHidden = false
           swichButton.isHidden = false
           textView.text = "Daily Mission"
           print("click1")
       }
       
       @IBAction func MyFavourite(_ sender: UIButton) {
           containerView.isHidden = false
           textView.text = "My Favorite"
           print("click2")
       }
       @IBAction func MyAnalysis(_ sender: UIButton) {
           containerView.isHidden = false
           textView.text = "My Analysis"
           subTextView.text = "Discover how you're feeling today and over the past few weeks. The more honest and frequent your input, the more accurate the results will be!"
           
           if healthKitPermissionsGranted {
               let graphController = UIHostingController(rootView: ProfileView())
               
               addChild(graphController)
               scrollView.addSubview(graphController.view)
               graphController.didMove(toParent: self)
               graphController.view.frame = CGRect(x:0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
               graphController.view.backgroundColor = UIColor(red: 255, green: 248, blue: 201, alpha: 1)
           } else {
               textView.text = "Permissions Needed"
               subTextView.text = "Please grant HealthKit permissions to access this feature."
           }
           
           print("click3")
       }
       
       @IBAction func MyAchievements(_ sender: UIButton) {
           containerView.isHidden = false
           textView.text = "My Achievements"
           
           print("click4")
       }
       
       private func presentHealthKitPermissionsView() {
           DispatchQueue.main.async { [weak self] in
               let swiftUIView = HealthKitPermissions()
               let hostingController = UIHostingController(rootView: swiftUIView)
               hostingController.modalPresentationStyle = .fullScreen
               self?.present(hostingController, animated: true, completion: nil)
           }
       }
       
       private func checkAndRequestHealthKitAuthorizationIfNeeded() {
           guard HKHealthStore.isHealthDataAvailable() else {
               print("Health data is not available on this device.")
               return
           }
           
           let typesToRead: Set<HKObjectType> = [
               HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
               HKObjectType.electrocardiogramType(),
               HKObjectType.quantityType(forIdentifier: .electrodermalActivity)!,
               HKObjectType.quantityType(forIdentifier: .bodyTemperature)!,
               HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
               HKObjectType.quantityType(forIdentifier: .height)!
           ]
           
           let undeterminedTypes = typesToRead.filter { healthStore.authorizationStatus(for: $0) == .notDetermined }
           
   //        healthStore.requestAuthorization(toShare: [], read: typesToRead) { [weak self] success, error in
   //            DispatchQueue.main.async {
   //                guard success else {
   //                    print("HealthKit authorization failed with error: \(error?.localizedDescription ?? "Unknown error")")
   //                    return
   //                }
   //
   //                let ungrantedTypes = typesToRead.filter { type in
   //                    self?.healthStore.authorizationStatus(for: type) != .sharingAuthorized
   //                }
   //
   //                if ungrantedTypes.isEmpty {
   //                    print("All necessary permissions granted.")
   //                    self?.healthKitPermissionsGranted = true
   //                }
   //            }
   //        }

           if !undeterminedTypes.isEmpty {
               presentHealthKitPermissionsView()
           } else {
               print("All required HealthKit permissions were already granted or denied.")
               self.healthKitPermissionsGranted = true
           }
       }
   }

struct ProfileView: View {
    //@State private var fetchedData: String = ""
    @State private var bodyTemperatureData: [StressScoreData] = [
        StressScoreData(value: 36.6, label: "M"),
        StressScoreData(value: 37.1, label: "Tu"),
        StressScoreData(value: 37.5, label: "W"),
        StressScoreData(value: 36.8, label: "Th"),
        StressScoreData(value: 36.7, label: "F"),
        StressScoreData(value: 37.2, label: "Sa"),
        StressScoreData(value: 36.9, label: "Su")
    ]
    private let healthStore = HKHealthStore()
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Stress Score: Rest")
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 1)

                    if bodyTemperatureData.isEmpty {
                        Text("No data available")
                            .foregroundStyle(.black)
                            .padding()
                    } else {
                        if bodyTemperatureData.count >= 2 {
                            HStack {
                                Spacer()
                                LineChartView(data: bodyTemperatureData.map { $0.value }, title: "Body Temperature", legend: "Last 7 Days")
                                    .frame(height: 250)
                                Spacer()
                            }

                            HStack {
                               Spacer()
                               ForEach(bodyTemperatureData, id: \.self) { data in
                                   Text(data.label)
                                       .frame(maxWidth: 20, alignment: .center)
                               }
                               Spacer()
                           }
                        } else {
                            Text("Insufficient data points for line chart")
                                .padding()
                        }
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(20)
            .padding()
            .onAppear {
//                fetchTemp()
            }
        }

        private func fetchTemp() {
            guard let tempType = HKSampleType.quantityType(forIdentifier: .bodyTemperature) else {
                return
            }

            let calendar = Calendar.current
            let endDate = Date()
            let startDate = calendar.date(byAdding: .day, value: -7, to: endDate)!

            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)

            let query = HKSampleQuery(sampleType: tempType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, results, error in
                guard let samples = results as? [HKQuantitySample], error == nil else {
                    print("Error fetching temperature samples: \(String(describing: error))")
                    return
                }

                DispatchQueue.main.async {
                    self.bodyTemperatureData = samples.map { sample in
                        let value = sample.quantity.doubleValue(for: .degreeFahrenheit())
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "E"
                        return StressScoreData(value: value, label: dateFormatter.string(from: sample.startDate))
                    }
                }
            }

            healthStore.execute(query)
        }

    private func fetchHeight() {
        let heightType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        let query = HKSampleQuery(sampleType: heightType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            if let result = results?.first as? HKQuantitySample{
                //self.fetchedData += "Height => \(result.quantity)"
                let sample: Double = result.quantity.doubleValue(for: .meter())
                bodyTemperatureData.append(StressScoreData(value: sample, label: ""))
                print("Height => \(result.quantity)")
                print(sample)
            }else{
                bodyTemperatureData.append(StressScoreData(value: 0, label: ""))
            }
        }
        self.healthStore.execute(query)
    }
    
    private func fetchWalkingSpeed() {
        let walkingType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingSpeed)!
        let query = HKSampleQuery(sampleType: walkingType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            if let result = results?.first as? HKQuantitySample{
                //self.fetchedData += "Walking Speed => \(result.quantity)"
                let speed = HKUnit.meter().unitDivided(by: HKUnit.second())
                let sample: Double = result.quantity.doubleValue(for: speed)
                bodyTemperatureData.append(StressScoreData(value: sample, label: ""))
                print("Walking Speed => \(result.quantity)")
                print(sample)
            }else{
                bodyTemperatureData.append(StressScoreData(value: 0, label: ""))
            }
        }
        self.healthStore.execute(query)
    }
    
    private func fetchtbvp() {
        let heartrateType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRateVariabilitySDNN)!
        let query = HKSampleQuery(sampleType: heartrateType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            if let result = results?.first as? HKQuantitySample{
                let sample: Double = result.quantity.doubleValue(for: .second())*100
                bodyTemperatureData.append(StressScoreData(value: sample, label: ""))
                print("Heart Rate Variablity => \(result.quantity)")
                print(sample)
            }else{
                bodyTemperatureData.append(StressScoreData(value: 0, label: ""))
                print("OOPS didnt get Heart Rate Variablity\nResults => \(String(describing: results)), error => \(String(describing: error))")
            }
        }
        self.healthStore.execute(query)
    }
    
    private func fetchecg() {
        let ecgType = HKSampleType.electrocardiogramType()
        let query = HKSampleQuery(sampleType: ecgType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            if let result = results?.first as? HKQuantitySample{
//                let sample: Double = result.quantity.doubleValue(for: .second())*100
//                bodyTemperatureData.append(StressScoreData(value: sample, label: ""))
                print("ECG => \(result.quantity)")
//                print(sample)
            }else{
//                bodyTemperatureData.append(StressScoreData(value: 0, label: ""))
                print("OOPS didnt get ECG\nResults => \(String(describing: results)), error => \(String(describing: error))")
            }
        }
        self.healthStore.execute(query)
    }
    
    private func fetcheda() {
        let edaType = HKSampleType.quantityType(forIdentifier: .electrodermalActivity)!
        let query = HKSampleQuery(sampleType: edaType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            if let result = results?.first as? HKQuantitySample{
//                let sample: Double = result.quantity.doubleValue(for: .second())*100
//                bodyTemperatureData.append(StressScoreData(value: sample, label: ""))
                print("EDA => \(result.quantity)")
//                print(sample)
            }else{
//                bodyTemperatureData.append(StressScoreData(value: 0, label: ""))
                print("OOPS didnt get EDA\nResults => \(String(describing: results)), error => \(String(describing: error))")
            }
        }
        self.healthStore.execute(query)
    }
    
    struct StressScoreData: Hashable {
        let value: Double
        let label: String
    }
    
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
}
