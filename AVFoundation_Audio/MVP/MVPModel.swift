//
//  MVPModel.swift
//  AVFoundation_Audio
//
//  Created by Illya Blinov on 20.01.24.
//

struct AudioTrack {
    let name: String?
    let type: String?
}

struct AudioService {
    static let tracks: [AudioTrack] = []
    static func getTracks() -> [AudioTrack] {
        [AudioTrack(name: "Queen", type: "mp3"),
         AudioTrack(name: "Lights And Sounds", type: "mp3"),
         AudioTrack(name: "Weeks From Twenty", type: "mp3"),
         AudioTrack(name: "Sure Thing Falling", type: "mp3"),
         AudioTrack(name: "On My Head", type: "mp3"),
         AudioTrack(name: "City Of Devils", type: "mp3")
        ]
    }
    static func getTrack(num: Int) -> AudioTrack {
        guard num < tracks.count else { return  AudioTrack(name: "Queen", type: "mp3")}
        return tracks[num]
    }

}
