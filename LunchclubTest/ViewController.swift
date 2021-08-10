//
//  ViewController.swift
//  LunchclubTest
//
//  Created by Alexander Ge on 06/08/2021.
//

import Contacts
import UIKit

protocol ViewControllerDelegate: class {
    func didSelectContact(_ contact: LCContact)
}

class ViewController: UIViewController {
    
    weak var delegate: ViewControllerDelegate?
    
    private let contactStore = CNContactStore()
    private let requestPerformer = ContactRequestPerformer()
    
    private var contacts: [LCContact] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ContactCell.self, forCellWithReuseIdentifier: "ContactCell")
        cv.backgroundColor = .white
        return cv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        DispatchQueue.global().async { [weak self] in
            self?.requestPerformer.requestAllContacts { [weak self] (contacts) in
                self?.contacts = contacts ?? []
            }
        }
//
//        switch CNContactStore.authorizationStatus(for: .contacts) {
//        case .notDetermined:
//            contactStore.requestAccess(for: .contacts) { [weak self] (success, error) in
//                guard error == nil else {
//                    print(error?.localizedDescription)
//                    return
//                }
//                if success {
//                    var contacts = [CNContact]()
//                    // upload all contacts
//                    let req = CNContactFetchRequest(keysToFetch: [
//                            CNContactFamilyNameKey as CNKeyDescriptor,
//                            CNContactGivenNameKey as CNKeyDescriptor
//                        ])
//                    try! self?.contactStore.enumerateContacts(with: req) {
//                        contact, stop in
//                        contacts.append(contact)
//                        print(contact) // in real life, probably populate an array
//                    }
//                    for contact in contacts {
//                        // upload
//                    }
//                }
//            }
//        case .restricted, .denied:
//            break
//        case .authorized:
//            break
//        }
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
            return UICollectionViewCell()
        }
        
        cell.bind(contacts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectContact(contacts[indexPath.row])
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 50)
    }
}

