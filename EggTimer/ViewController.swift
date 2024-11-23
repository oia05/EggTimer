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
    var time: Float = -1.0
    var timer: Timer!
    let timeStep: Float = 1.0
    var player: AVAudioPlayer!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBAction func softEggPressed(_ sender: UIButton) {
        startTimer(hardness: .soft)
    }
    
    @IBAction func mediumEggPressed(_ sender: UIButton) {
        startTimer(hardness: .medium)
    }
    
    @IBAction func hardEggPressed(_ sender: UIButton) {
        startTimer(hardness: .hard)
    }
    
    private func startTimer(hardness: EggHardness) {
        invalidateTimer()
        titleLabel.text = hardness.getName()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {timer in
            self.updateTimer(hardness: hardness)
        })
    }
    
    private func updateTimer(hardness: EggHardness) {
        self.time += timeStep
        if(self.time > hardness.rawValue) {
            titleLabel.text = "Done!"
            playAlarm()
            invalidateTimer()
        } else {
            progressView.progress = time/hardness.rawValue
        }
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
        time = 0.0
        progressView.progress = 0.0
    }
    
    private func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        guard url != nil else { return }
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
