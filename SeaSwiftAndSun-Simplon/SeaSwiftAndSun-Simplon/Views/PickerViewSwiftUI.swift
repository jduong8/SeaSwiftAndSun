//
//  PickerViewSwiftUI.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Thibault GODEFROY on 14/12/2023.
//

import SwiftUI
import UIKit

struct PickerViewSwiftUI: View {

    @State private var selectedOption = PickerOption.list

    var body: some View {
        Picker("Select an option", selection: $selectedOption) {
            ForEach(PickerOption.allCases, id: \.self) {
                       Text($0.rawValue)
                   }
               }
               .pickerStyle(.segmented)
        
        if selectedOption == .list {
            ListView()
        } else {
            MapViewSwiftUI()
        }
    }
}

enum PickerOption: String, CaseIterable {
    case list = "Liste"
    case map = "Carte"
}

struct ListView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        guard let listVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "NavigationController") as? NavigationController else {
            fatalError("Unable to instantiate NavigationController")
        }
        return listVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}


#Preview {
    PickerViewSwiftUI()
}
