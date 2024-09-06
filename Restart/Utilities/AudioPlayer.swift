//
//  AudioPlayer.swift
//  Restart
//
//  Created by gizem demirtas on 12.08.2024.
//

import Foundation
import AVFoundation //iOS , MacOS, watchOS, VE tvOS üzerinde zaman tabanlı görsel-işitsel medya ile çalışmak için tam özellikli bir çerçevedir. Bu çerçeveyi kullanarak filmleri, ses dosyalarını kolayca oynatabilir ve düzenleyebilir ve herhangi bir uygulamaya güçlü medya işlevselliği ekleyebiliriz.

var audioPlayer: AVAudioPlayer?

func playSound (sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Could not play the sound file.")
        }
    }
    
}

