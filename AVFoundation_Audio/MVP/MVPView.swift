//
//  MVPView.swift
//  AVFoundation_Audio
//
//  Created by Illya Blinov on 20.01.24.
//

import UIKit
class MVPView: UIViewController, ViewProtocol {

    lazy var playButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Play"), for: .normal)
        button.addTarget(nil, action: #selector(playTouch), for: .touchDown)
        return button
    }()
    lazy var backButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Back"), for: .normal)
        button.addTarget(nil, action: #selector(backButtonTouch), for: .touchDown)
        return button
    }()
    lazy var forwardButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Forward"), for: .normal)
        button.addTarget(nil, action: #selector(forwardButtonTouch), for: .touchDown)
        return button
    }()
    lazy var stopButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Stop"), for: .normal)
        button.addTarget(nil, action: #selector(stopTouch), for: .touchDown)
        return button
    }()
    lazy var trackLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "..."
        if #available(iOS 15.0, *) {
            label.textColor = .systemMint
        } else {
            label.textColor = .white
        }
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    func didChangeState(state: State, track: String) {
        switch state {
        case .play :
            playButton.setImage(UIImage(named: "Pause"), for: .normal)
            trackLabel.text = track
            trackLabel.isHidden = false
        case .stop :
            playButton.setImage(UIImage(named: "Play"), for: .normal)
        }
    }

    private let presenter: PresenterProtocol

    init(presenter: PresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        setupView()
        setupConstraints()
    }

    func setupView() {
        view.backgroundColor = .black
        addButtons(buttons: [playButton, backButton, forwardButton, stopButton])
        view.addSubview(trackLabel)
    }

    @objc func playTouch(){
        presenter.playDidTap(stop: false)
    }
    @objc func stopTouch(){
        presenter.playDidTap(stop: true)
    }
    @objc func backButtonTouch(){
        presenter.switchTrack(direction: .back)
    }
    @objc func forwardButtonTouch(){
        presenter.switchTrack(direction: .forward)
    }

    func setupConstraints(){
        let indent: CGFloat = 120
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.widthAnchor.constraint(equalToConstant: 60),
            trackLabel.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
            trackLabel.centerYAnchor.constraint(equalTo: playButton.centerYAnchor, constant: -indent),
            backButton.centerXAnchor.constraint(equalTo: playButton.centerXAnchor, constant: -indent),
            backButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            backButton.heightAnchor.constraint(equalTo: playButton.heightAnchor),
            backButton.widthAnchor.constraint(equalTo: playButton.widthAnchor),
            forwardButton.centerXAnchor.constraint(equalTo: playButton.centerXAnchor, constant: indent),
            forwardButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            forwardButton.heightAnchor.constraint(equalTo: playButton.heightAnchor),
            forwardButton.widthAnchor.constraint(equalTo: playButton.widthAnchor),
            stopButton.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
            stopButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor, constant: indent),
            stopButton.heightAnchor.constraint(equalTo: playButton.heightAnchor),
            stopButton.widthAnchor.constraint(equalTo: playButton.widthAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MVPView {
    func addButtons(buttons: [UIButton] ){
        buttons.forEach() { view.addSubview($0)}
    }
}
