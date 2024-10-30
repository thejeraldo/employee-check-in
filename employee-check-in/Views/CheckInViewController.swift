//
//  CheckInViewController.swift
//  employee-check-in
//
//  Created by Jerald Allen Abille on 10/30/24.
//

import UIKit
import SwiftUI

@objc class CheckInViewController: UIViewController {
    
    // MARK: - Init
    
    init() {
        let checkInView = CheckInView()
        hostingController = .init(rootView: checkInView)
        super.init(nibName: nil, bundle: nil)
        self.hostingController.rootView.hostingController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    private var hostingController: UIHostingController<CheckInView>
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }

}
