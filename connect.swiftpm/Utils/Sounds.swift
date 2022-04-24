//
//  SoundPlayer.swift
//  
//
//  Created by Gustavo Kumasawa on 23/04/22.
//

import AVFoundation

class SoundPlayer {
    var audioPlayer: AVAudioPlayer?

    init(sound: Sounds) {
        let (soundName, soundType) = SoundPlayer.getSound(for: sound)

        if let soundURL = Bundle.main.url(
            forResource: soundName,
            withExtension: soundType
        ) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                guard let player = audioPlayer else {
                    return
                }
                player.prepareToPlay()
                player.volume = 1
            } catch {
                print("error initializing SoundPlayer")
            }
            
            do{
                try AVAudioSession.sharedInstance().setCategory(
                    .playback,
                    mode: .default,
                    options: [.mixWithOthers]
                )
                try AVAudioSession.sharedInstance().setActive(true)
            }
            catch {
                print ("oops")
            }
        }
    }

    func play() {
        guard let player = audioPlayer else {
            return
        }

        player.play()
    }

    func stop() {
        guard let player = audioPlayer else {
            return
        }

        player.stop()
    }

    private static func getSound(for type: Sounds) -> (String, String) {
        switch type {
        case .connection:
            return ("connection", "mp3")
        case .cut:
            return ("cut", "mp3")
        case .tap:
            return ("tap", "mp3")
        case .zoomIn:
            return ("zoomIn", "mp3")
        case .zoomOut:
            return ("zoomOut", "mp3")
        }
    }

    enum Sounds {
        case connection
        case cut
        case tap
        case zoomIn
        case zoomOut
    }
}

