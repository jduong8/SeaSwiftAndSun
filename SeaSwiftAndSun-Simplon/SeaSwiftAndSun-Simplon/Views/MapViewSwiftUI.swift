//
//  MapViewSwiftUI.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Thibault GODEFROY on 14/12/2023.
//

import SwiftUI
import MapKit

struct MapViewSwiftUI: View {

    @StateObject private var viewModel = MapViewModel()

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

#Preview {
    MapViewSwiftUI()
}
