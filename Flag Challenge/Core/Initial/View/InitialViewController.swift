//
//  InitialViewController.swift
//  Flag Challenge
//
//  Created by Anatoliy Ostapenko on 30.01.2025.
//

import UIKit
import SnapKit
import Combine

class InitialViewController: UIViewController {
    // MARK: UI Elements
    private lazy var container: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.distribution = .fillEqually
        container.spacing = 16
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.layer.borderWidth = 1
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return container
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "Some initial welcome text"
        return label
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: Objects
    private var viewModel: InitialViewModel
    weak var coordinator: InitialCoordinatorProtocol?
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Lifecycle
    init(viewModel: InitialViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstarints()
        setupBindings()
    }
    
    // MARK: Bindings
    private func setupBindings() {
        viewModel.$result
            .sink { [weak self] text in
                self?.resultLabel.text = text
            }
            .store(in: &cancellables)
        
        viewModel.gameOver
            .sink { [weak self] _ in
                self?.coordinator?.finishGame()
            }
            .store(in: &cancellables)
    }
    
    // MARK: UI Configuration
    private func setupView() {
        view.backgroundColor = .white
        [container, button].forEach { view.addSubview($0) }
        [titleLabel, resultLabel].forEach { container.addArrangedSubview($0) }
    }
    
    private func setupConstarints() {
        container.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(container.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(container.snp.width)
            make.height.equalTo(60)
        }
    }
    
    // MARK: Actions
    @objc private func btnTapped() {
        coordinator?.startGame()
    }
}
