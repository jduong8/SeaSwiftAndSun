//
//  MapViewSwiftUI.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Thibault GODEFROY on 14/12/2023.
//

import SwiftUI
import MapKit

struct MapViewSwiftUI: View {

    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: viewModel.surfSpotAnnotations) { annotation in
            MapAnnotation(coordinate: annotation.coordinate) {
                VStack {
                    Image(systemName: "mappin.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Text(annotation.name)
                        .font(.caption)
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.async {
                viewModel.checkIfLocationServicesIsEnabled()
                viewModel.initializeSurfSpotMarkers()
            }
        }
    }
}

class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

    private var locationManager: CLLocationManager?

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.866667, longitude: 2.333333),
        span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15)
    )

    @Published var surfSpotAnnotations: [SurfSpotAnnotation] = []

    func initializeSurfSpotMarkers() {
        surfSpotAnnotations = SurfSpot.allCases.map { spot in
            let coordinate = CLLocationCoordinate2D(latitude: spot.coordinates.latitude, longitude: spot.coordinates.longitude)
            return SurfSpotAnnotation(name: "\(spot.rawValue)", coordinate: coordinate)
        }
    }


    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            // Demander l'autorisation seulement si le statut n'est pas encore déterminé
            if locationManager?.authorizationStatus == .notDetermined {
                locationManager?.requestWhenInUseAuthorization()
            }
        } else {
            print("Affichez une alerte pour leur indiquer que la localisation est désactivée et leur demander de l'activer.")
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async { [weak self] in
            self?.checkLocationAuthorization()
        }
    }

    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
            case .notDetermined:
                // Ne rien faire, attendre que l'utilisateur réponde à la demande d'autorisation
                break
            case .restricted, .denied:
                // Gérer les cas où l'accès est restreint ou refusé
                print("Accès à la localisation restreint ou refusé.")
            case .authorizedAlways, .authorizedWhenInUse:
                // Mettre à jour la région ici si nécessaire
                break
            @unknown default:
                print("Statut d'autorisation inconnu.")
        }
    }
}

#Preview {
    MapViewSwiftUI()
}
