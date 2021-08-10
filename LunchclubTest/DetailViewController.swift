//
//  DetailViewController.swift
//  LunchclubTest
//
//  Created by Alexander Ge on 06/08/2021.
//

import UIKit

class DetailViewController: UIViewController {
    private let nameLabel: UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberLabel: UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(contact: LCContact) {
        super.init(nibName: nil, bundle: nil)
        nameLabel.text = (contact.first ?? "") + " " + (contact.last ?? "")
        numberLabel.text = contact.number
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nameLabel)
        view.addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            numberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16)
        ])
    }
}
