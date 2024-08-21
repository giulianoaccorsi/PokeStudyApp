//
//  AudioPlayer.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 17/06/24.
//

import Foundation
import AVFoundation
import OggDecoder

class AudioPlayer: ObservableObject {
    var player: AVAudioPlayer?

    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance()
                .setCategory(
                    .playback,
                    mode: .default,
                    options: []
                )
            try AVAudioSession.sharedInstance()
                .setActive(true)
        } catch {}
    }

    func playSound(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let tempFileURL = FileManager.default.temporaryDirectory.appendingPathComponent("tempAudio.ogg")
                try data.write(to: tempFileURL)

                let decoder = OGGDecoder()
                decoder.decode(tempFileURL) { savedWavUrl in
                    guard let savedWavUrl = savedWavUrl else {
                        return
                    }

                    do {
                        self.player = try AVAudioPlayer(contentsOf: savedWavUrl)
                        self.player?.prepareToPlay()
                        self.player?.play()
                    } catch {}
                }
            } catch {}
        }.resume()
    }
}
