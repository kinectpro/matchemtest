//
//  ViewController.swift
//  MatchEmUpGameTest
//
//  Created by Денис Марков on 2/27/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit
import CoreLocation

fileprivate let imagesCount = 8
fileprivate let defaultCoordinates = "47.6918452,-122.2226413"
fileprivate let locationDefaultsKey = "location"
fileprivate let cellIdentifer = "cardCellReuseIdentifier"
fileprivate let cellNibName = "CollectionViewCell"

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var startGameButton: UIButton! {
        didSet {
            startGameButton.addTarget(self, action: #selector(startGameButtonDidTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var restartGameButton: UIButton!
    
    var locationManager: CLLocationManager!
    var currentLocationString: String?
    var gameStarted = false
    var images: [String] = []
    var cardsImages: [String] = []
    var firstSelectedCellImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        currentLocationString = UserDefaults.standard.value(forKey: locationDefaultsKey) as? String
        loadPhotos()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellNibName, bundle: nil), forCellWithReuseIdentifier: cellIdentifer)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if !gameStarted {
                currentLocationString = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
                UserDefaults.standard.set(currentLocationString, forKey: locationDefaultsKey)
                loadPhotos()
            }
        }
    }
    
    func loadPhotos() {
        var location = defaultCoordinates
        if let userLocation = currentLocationString {
            location = userLocation
        }
        RestAPI().getRestaurants(location: location, callback: { (isOk, places) in
            guard isOk, let places = places else {
                return
            }
            for place in places {
                guard self.images.count < imagesCount else { break }
                if let imageReference = place.photos?.first?.photo_reference {
                    self.images.append(imageReference)
                }
            }
            self.collectionView.reloadData()
        })
    }
    
    func prepareCardsToGame() {
        var cards: [String] = []
        cards.append(contentsOf: images)
        cards.append(contentsOf: images)
        cardsImages = cards.shuffled()
    }
    
    @objc func startGameButtonDidTap() {
        gameStarted = true
        prepareCardsToGame()
        collectionView.reloadData()
        startGameButton.isHidden = true
    }
}

extension ViewController:  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifer, for: indexPath) as! CollectionViewCell
        if indexPath.row < cardsImages.count {
            cell.setUpCell(imageReference: cardsImages[indexPath.row])
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if cardsImages.count > indexPath.row {
            let selectedImage = cardsImages[indexPath.row]
            
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let cellWidth = (collectionViewWidth - 10) / 2
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

