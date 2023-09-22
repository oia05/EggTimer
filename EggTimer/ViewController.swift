//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeProgresaView: UIProgressView!
    var requiredTime: Int = 60
    var timeRemaining: Int = 60
    var timer = Timer()
    var player: AVAudioPlayer?
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle ?? "Soft"
        switch hardness {
        case EggHardness.soft.rawValue:
            requiredTime = EggHardness.soft.getRequiredTime()
        case EggHardness.medium.rawValue:
            requiredTime = EggHardness.medium.getRequiredTime()
        case EggHardness.hard.rawValue:
            requiredTime = EggHardness.hard.getRequiredTime()
        default:
            requiredTime = EggHardness.soft.getRequiredTime()
        }
        timeRemaining = requiredTime
        setTimer(timeRemaining: timeRemaining)
        timer.invalidate()
        playSound(fileName: "timer")
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc private func updateTimer() {
        if timeRemaining >= 1 {
            timeRemaining -= 1
            setTimer(timeRemaining: timeRemaining)
        } else {
            setTimer(timeRemaining: timeRemaining)
            timer.invalidate()
        }
    }
    
    private func setTimer(timeRemaining: Int) {
        let title: String
        if timeRemaining == 0 {
            player?.stop()
            playSound(fileName: "finished")
            title = "DONE!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.18, execute: {
                self.titleLabel.text = "How do you like your Eggs?"
                self.timeProgresaView.progress = 0.0
                self.player?.stop()
            })
        } else {
            title = "\(timeRemaining) seconds remaining..."
        }
        titleLabel.text = title
        timeProgresaView.progress = 1.0 -  Float(timeRemaining)/Float(requiredTime)
    }
    
    private func playSound(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else { return }

           do {
               try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
               try AVAudioSession.sharedInstance().setActive(true)
               player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
               guard let player = player else { return }

               player.play()

           } catch let error {
               print(error.localizedDescription)
           }
    }
    
}
