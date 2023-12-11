//
//  SpotCell.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Amandine Cousin on 05/12/2023.
//

import UIKit

class SpotCell: UITableViewCell {

    @IBOutlet weak var spotImage: UIImageView!
    @IBOutlet weak var spotName: UILabel!
    @IBOutlet weak var spotLocation: UILabel!
    @IBOutlet weak var spotDifficulty: UILabel!

    /// Configure la cellule avec les informations de spot de surf.
    ///
    /// Cette méthode configure la cellule avec les détails du spot de surf fournis dans l'objet `fields`. 
    /// Elle met à jour les éléments d'interface utilisateur tels que les labels pour le nom, l'emplacement et le niveau de difficulté du spot. Elle charge également les images du spot de manière asynchrone.
    ///
    /// - Parameter fields: L'objet `Fields` contenant les informations du spot de surf à afficher dans la cellule.
    ///
    /// - Note: `fields.photos` est une collection d'objets photo. Cette méthode démarre une tâche asynchrone pour chaque photo afin de charger et d'afficher la première image disponible. Si aucune image n'est disponible ou en cas d'erreur de chargement, une image par défaut est affichée.
    func setUpCell(fields: Fields) {
        self.spotName.text = fields.destination
        self.spotLocation.text = fields.destinationStateCountry
        self.spotDifficulty.text = fields.difficultyLevel?.description
        fields.photos?.forEach({ photo in
            Task { [weak self] in
                await self?.loadSpotImage(from: photo.url)
            }
        })
    }

    /// Charge et affiche une image de spot de surf à partir d'une URL donnée de manière asynchrone.
    ///
    /// Cette méthode tente de charger une image depuis une URL spécifiée.
    /// Si le chargement réussit, l'image est affichée dans l'élément `spotImage` de la cellule.
    /// En cas d'échec, une image par défaut est affichée.
    /// Le chargement de l'image se fait de manière asynchrone pour ne pas bloquer le thread principal.
    ///
    /// - Parameter urlString: L'URL sous forme de chaîne de caractères de l'image à charger. Peut être `nil`.
    ///
    /// - Note: Si `urlString` est `nil` ou si l'URL ne peut pas être formée, la méthode définit l'image de `spotImage` sur une image par défaut. Les erreurs de réseau ou de décodage d'image entraînent également l'affichage de l'image par défaut.
    private func loadSpotImage(from urlString: String?) async {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            spotImage.image = UIImage(systemName: "photo")
            return
        }

        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.spotImage.image = image
                }
            }
        } catch {
            print("Erreur lors du chargement de l'image: \(error)")
            DispatchQueue.main.async { [weak self] in
                self?.spotImage.image = UIImage(systemName: "photo")
            }
        }
    }
}
