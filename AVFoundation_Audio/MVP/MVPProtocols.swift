//
//  MVPProtocols.swift
//  AVFoundation_Audio
//
//  Created by Illya Blinov on 19.01.24.
//

import Foundation
enum State {
    case play
    case stop
}

enum Direction {
    case forward
    case back
}

protocol PresenterProtocol: AnyObject {
    func playDidTap(stop: Bool)
    func switchTrack(direction: Direction)
}
protocol ViewProtocol: AnyObject {
    func didChangeState(state: State, track: String)
}

