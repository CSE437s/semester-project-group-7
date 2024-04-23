//
//  AudioViewcontroller.swift
//  group_7
//
//  Created by Byeongjun Oh on 3/31/24.
//
//
import Foundation
import UIKit
import AVFoundation

class AudioViewController: UIViewController {
    var players: [AVAudioPlayer] = []
    var sliders: [UISlider] = []
    var data: Int?
    var isPlaying = false
    
    lazy var playButton: UIButton = {
        let playButton = UIButton(type: .custom)
        playButton.frame = CGRect(x: view.frame.width/2-25, y:view.frame.height-100, width: 50, height: 50)
        playButton.setImage(UIImage(named: "playbutton"), for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return playButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Nature")
        
        let textLabel = UILabel(frame: CGRect(x:100, y:150, width: 200, height: 200))
        textLabel.text = "Relaxing\nNature\nSounds"

        var soundNmaes: [String] = []
        var backgroundColor = UIColor(red: 160/255, green: 190/255, blue: 223/255, alpha: 1)
        var borderColor: CGColor?
        
        if let receivedData = data {
            if receivedData == 0 {
                textLabel.textColor = .white
                backgroundImage.image = UIImage(named: "piano")
                textLabel.text = "Relaxing\nInstrument\nSounds"
                soundNmaes = ["Rain", "Wind", "Thunder", "Ocean wave", "Birdsong"]
                backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
                borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
                textLabel.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
                textLabel.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
            }
            else if receivedData == 1 {
                textLabel.textColor = .white
                backgroundImage.image = UIImage(named: "Nature")
                textLabel.text = "Relaxing\nNature\nSounds"
                soundNmaes = ["Rain", "Wind", "Thunder", "Ocean wave", "Birdsong"]
                backgroundColor = UIColor(red: 160/255, green: 190/255, blue: 223/255, alpha: 1)
                borderColor = UIColor(red: 160/255, green: 190/255, blue: 223/255, alpha: 1).cgColor
                textLabel.layer.borderColor = UIColor(red: 24/255, green: 52/255, blue: 123/255, alpha: 1).cgColor
                textLabel.backgroundColor = UIColor(red: 24/255, green: 52/255, blue: 123/255, alpha: 1)
            }
            else if receivedData == 2 {
                textLabel.textColor = .white
                backgroundImage.image = UIImage(named: "whitepink")
                textLabel.text = "Relaxing\nWhite Pink\nNoises"
                soundNmaes = ["Rain", "Wind", "Thunder", "Ocean wave", "Birdsong"]
                backgroundColor = UIColor(red: 240/255, green: 179/255, blue: 174/255, alpha: 1)
                borderColor = UIColor(red: 240/255, green: 179/255, blue: 174/255, alpha: 1).cgColor
                textLabel.layer.borderColor = UIColor(red: 229/255, green: 127/255, blue: 118/255, alpha: 1).cgColor
                textLabel.backgroundColor = UIColor(red: 229/255, green: 127/255, blue: 118/255, alpha: 1)
            }
        }
                
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
                
        
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        //textLabel.backgroundColor = .clear
//        textLabel.layer(radius: textLabel.frame.height/2, borderWidth: 2, borderColor: .blue)
        
        
        let numberOfCircles = 3
        let gapBetweenCircles: CGFloat = 10

        for i in (0..<numberOfCircles).reversed() { // Reverse the loop to add the largest circle first
            let circleView = UIView()
            let expansion = (CGFloat(i) * gapBetweenCircles * 2) + textLabel.frame.width
            circleView.frame = CGRect(
                x: textLabel.center.x - (expansion / 2),
                y: textLabel.center.y - (expansion / 2),
                width: expansion,
                height: expansion
            )

            circleView.backgroundColor = backgroundColor // Change as desired
            circleView.layer.cornerRadius = expansion / 2
            circleView.layer.borderWidth = 2
            circleView.layer.borderColor = borderColor
            circleView.clipsToBounds = true

           
            self.view.insertSubview(circleView, belowSubview: textLabel)
        }

    
        textLabel.layer.cornerRadius = textLabel.frame.width / 2
        textLabel.layer.borderWidth = 2
        
        textLabel.clipsToBounds = true

        textLabel.font = .boldSystemFont(ofSize: 20)
        textLabel.clipsToBounds = true
        view.addSubview(textLabel)
        
        let sliderHeight: CGFloat = 30
        let sliderWidth: CGFloat = 200
        let sliderSpacing: CGFloat = 50
        let sliderCount = 5
        let totalSliderWidth = sliderWidth * CGFloat(sliderCount) + sliderSpacing * CGFloat(sliderCount - 1)
        let startY = (view.frame.height - sliderHeight) / 2
        
        for index in 0..<sliderCount {
            let slider = UISlider(frame: CGRect(x: (sliderHeight+sliderSpacing)*CGFloat(index) - sliderSpacing-20, y: startY+50, width: sliderWidth, height: sliderHeight))
            slider.minimumValue = 0
            slider.maximumValue = 1
            slider.value = 0.5
            slider.layer(radius: sliderHeight/2, borderWidth: 1, borderColor: .lightGray)
            slider.addTarget(self, action: #selector(sliderValueChange(_:)), for: .valueChanged)
            slider.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
            slider.backgroundColor = .clear
            slider.tintColor = textLabel.backgroundColor
            view.addSubview(slider)
            sliders.append(slider)
        }
        
        for(index, soundName) in soundNmaes.enumerated() {
            let label = UILabel(frame: CGRect(x: (index*80), y: Int(startY+sliderWidth)-40, width: 70, height: 20))
            label.text = soundName
            label.textColor = textLabel.backgroundColor
            label.textAlignment = .center
            label.backgroundColor = .white
            label.font = UIFont.systemFont(ofSize: 9)
            label.layer(radius: 10, borderWidth: 1, borderColor: .lightGray)
            view.addSubview(label)
        }

        view.addSubview(playButton)
        
        playAllPlayers()
    }
    
    func playAudio(url: URL, volume: Float) {
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.volume = volume
            player.prepareToPlay()
            players.append(player)
        } catch let error {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    @objc func sliderValueChange(_ sender: UISlider) {
        let index = sliders.firstIndex(of: sender)!
        let volume = sender.value
        
        guard index < players.count else {return}
        let player = players[index]
        player.volume = volume
        print("Index : ", index)
        print("Volume : ", volume)
    }
    
    @objc func playButtonTapped() {
        if isPlaying {
            for player in players {
                player.stop()
            }
            playButton.setImage(UIImage(named: "pause"), for:.normal)
        }
        else {
            for player in players {
                player.play()
            }
            playButton.setImage(UIImage(named: "playbutton"), for: .normal)
        }
        isPlaying.toggle()
    }
    func playAllPlayers() {
        // Load and play Raindrop.mp3
        if let url1 = Bundle.main.url(forResource: "Rain", withExtension: "mp3") {
            self.playAudio(url: url1, volume: sliders[0].value) // Utilize the playAudio method
            print("Playing Rain")
        } else {
            print("Rain file not found")
        }
        
        // Load and play wind.mp3
        if let url2 = Bundle.main.url(forResource: "Wind", withExtension: "mp3") {
            self.playAudio(url: url2, volume: sliders[1].value) // Utilize the playAudio method
            print("Playing Wind")
        } else {
            print("Wind file not found")
        }
        // Load and play thunder.mp3
        if let url3 = Bundle.main.url(forResource: "Thunder", withExtension: "mp3") {
            self.playAudio(url: url3, volume: sliders[2].value) // Utilize the playAudio method
            print("Playing Thunder")
        } else {
            print("Thunder file not found")
        }
        // Load and play oceanwave.mp3
        if let url4 = Bundle.main.url(forResource: "Ocean wave", withExtension: "mp3") {
            self.playAudio(url: url4, volume: sliders[3].value) // Utilize the playAudio method
            print("Playing Ocean wave")
        } else {
            print("Ocean wave file not found")
        }
        
        // Load and play Bird.mp3
        if let url5 = Bundle.main.url(forResource: "Birdsong", withExtension: "mp3") {
            self.playAudio(url: url5, volume: sliders[4].value) // Utilize the playAudio method
            print("Playing Birdsong")
        } else {
            print("Birdsong file not found")
        }
    }
}
