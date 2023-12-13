//
//  DetailSpotViewController.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Amandine Cousin on 05/12/2023.
//

import UIKit
import MapKit

class DetailSpotViewController: UIViewController {
    @IBOutlet weak var spotImage: UIImageView!
    @IBOutlet weak var spotName: UILabel!
    @IBOutlet weak var spotDifficulty: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    var fields: Fields?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(with fields: Fields) {
        self.fields = fields
        self.fields?.surfSpot = mapDestinationToSurfSpot(destinationName: fields.destination)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSpotImage()
        self.setupSpotName()
        self.setupSpotDifficulty()
        self.setupLink()
        self.setupLocation()
        self.setupPeakSeason()
    }
    
    private func setupSpotImage() {
        fields?.photos?.forEach { photo in
            Task {
                await ImageLoader.shared.loadImage(into: spotImage,from: photo.url)
            }
        }
        self.spotImage.layer.cornerRadius = self.spotImage.frame.size.width / 2
    }
    
    private func setupSpotName() {
        self.spotName.text = fields?.destination
    }
    
    private func setupSpotDifficulty() {
        self.spotDifficulty.text = fields?.difficultyLevel?.description
    }
    
    private func setupLink() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openWebsite))
        website.isUserInteractionEnabled = true
        website.addGestureRecognizer(tapGesture)
    }
    
    private func mapDestinationToSurfSpot(destinationName: String?) -> SurfSpot? {
        guard let destinationName = destinationName else { return nil }

        switch destinationName {
        case "Manu Bay":
            return .manuBay
        case "Superbank":
            return .superbank
        case "Playa Chicama":
            return .southernPeru
        case "Rockaway Beach":
            return .rockawayBeach
        case "Skeleton Bay":
            return .skeletonBay
        case "The Bubble":
            return .theBubble
        case "Kitty Hawk":
            return .kittyHawk
        case "Pipeline":
            return .pipeline
        case "Supertubes":
            return .supertubes
        case "Pasta Point":
            return .pastaPoint
        default:
            return nil
        }
    }
    
    private func setupLocation() {
        guard let surfSpot = fields?.surfSpot else { return }

        let coordinates = surfSpot.coordinates
        let location = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        let regionRadius: CLLocationDistance = 1000
        let region = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = fields?.destination
        mapView.addAnnotation(annotation)
    }
    
    private func setupPeakSeason() {
        if let stringBeginDate = fields?.peakSurfSeasonBegins,
           let stringEndDate = fields?.peakSurfSeasonEnds {
            if let beginDate = formatDate(stringBeginDate),
               let endDate = formatDate(stringEndDate) {
                self.startDate.text = beginDate
                self.endDate.text = endDate
            }
        }
    }
    
    @objc private func openWebsite() {
        guard let urlString = fields?.magicSeaweedLink, let url = URL(string: urlString) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
