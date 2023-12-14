//
//  AddSpotView.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Mahdia Amriou on 14/12/2023.
//

import SwiftUI

struct AddSpotView: View {
    @State private var spotName = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Spot Details")) {
                        TextField("Spot Name", text: $spotName)
                        // Ajoutez d'autres champs pour les détails du nouveau spot
                    }
                }

                Button(action: {
                    Task {
                        // Appeler la fonction pour ajouter un nouveau spot
                        await addNewSpot()
                    }
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 200, height: 50)
                        .overlay(
                            Text("Add Spot")
                                .foregroundColor(.white)
                                .font(.title)
                        )
                }
                .padding()
            }
            .navigationTitle("Add Spot")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Erreur"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func addNewSpot() async {
        do {
            // Créez un modèle de données pour le nouveau spot
            let newSpot = Record(id: nil, createdTime: nil, fields: Fields(
                difficultyLevel: 0,
                destination: nil,
                magicSeaweedLink: nil,
                photos: nil,
                peakSurfSeasonBegins: nil,
                destinationStateCountry: nil,
                peakSurfSeasonEnds: nil,
                influencers: nil,
                surfBreak: nil,
                address: nil
            ))

            // Appeler la fonction pour ajouter le nouveau spot
            try await APIManager.shared.addSpot(newSpot)

            // Réinitialisez les champs après l'ajout réussi
            spotName = ""

            // Affichez un message de succès
            alertMessage = "Spot ajouté avec succès!"
            showingAlert = true
        } catch {
            // Affichez un message d'erreur en cas d'échec
            alertMessage = "Erreur lors de l'ajout du spot"
            showingAlert = true
        }
    }
}

struct AddSpotView_Previews: PreviewProvider {
    static var previews: some View {
        AddSpotView()
    }
}
