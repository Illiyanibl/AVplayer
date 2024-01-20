//
//  MVPPresenter.swift
//  AVFoundation_Audio
//
//  Created by Illya Blinov on 20.01.24.
//

import AVFoundation
class MVPPresenter: PresenterProtocol {

    weak var view: ViewProtocol?
    var player = AVAudioPlayer()
    private let trackService: [AudioTrack]
    private var trackNumber: Int = 1
    var buttonState: State

    init(view: ViewProtocol? = nil, trackService: [AudioTrack]) {
        buttonState = .stop
        self.view = view
        self.trackService = trackService
        setupPlayer()
    }

    func switchTrack(direction: Direction){
        switch direction {
        case .forward:
            trackNumber += 1
        case .back:
            trackNumber -= 1
        }
        if trackNumber < 0 { trackNumber = trackService.count - 1}
        if trackNumber > trackService.count - 1 { trackNumber = 0 }
        buttonState = .play
        setupPlayer()
        playOrStop(state: buttonState)
        view?.didChangeState(state: buttonState, track: trackService[trackNumber].name ?? "")

    }

    func playDidTap(stop: Bool = false) {
        if stop {
            buttonState = .play
            player.currentTime = 0.0
        }
        switch buttonState {
        case .stop :
            buttonState = .play
        case .play :
            buttonState = .stop
        }
        playOrStop(state: buttonState)
        view?.didChangeState(state: buttonState, track: trackService[trackNumber].name ?? "")
    }

    func playOrStop(state: State) {
        switch state{
        case .stop :
            player.stop()
        case .play :
            player.play()
        }
    }

    func setupPlayer(){
        do {
            let trackName: String = trackService[trackNumber].name ?? "Queen"
            let trackType: String = trackService[trackNumber].type ?? "mp3"
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: trackName, ofType: trackType)!))
            player.prepareToPlay()
        }
        catch {
            print(error)
        }
    }
}
