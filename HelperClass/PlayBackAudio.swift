//
//  PlayBackAudio.swift
//  Zol
//
//  Created by apple on 01/11/22.
//

import Foundation
import AVFoundation
import AVFAudio

class PlayViewModel {
    private var audioPlayer: AVAudioPlayer!
    static let instance = PlayViewModel()
    func play() {
        let sound = Bundle.main.path(forResource: "ding-idea-40142", ofType: "mp3")
        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        self.audioPlayer.play()
    }
}
