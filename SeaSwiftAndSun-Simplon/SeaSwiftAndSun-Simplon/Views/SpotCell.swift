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
            Task {
                await ImageLoader.shared.loadImage(into: spotImage,from: photo.url)
            }
        })
    }
}
