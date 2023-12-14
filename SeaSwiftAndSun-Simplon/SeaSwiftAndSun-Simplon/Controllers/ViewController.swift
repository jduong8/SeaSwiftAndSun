//
//  ViewController.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Amandine Cousin on 05/12/2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var sections: [SurBreakSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Liste des spots de surf"
        loadData()
//        let vcApple = UIHostingController(rootView: SingInWitAppleView())
//        addChild(vcApple)
//        view.addSubview(vcApple.view)
//        vcApple.didMove(toParent: self)
//        vcApple.view.translatesAutoresizingMaskIntoConstraints = false
//        vcApple.view.topAnchor.constraint(equalTo: self.tableView.bottomAnchor,constant: -20).isActive = true
//        vcApple.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        vcApple.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//        vcApple.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    func loadData() {
        Task {
            do {
                let data = try await APIManager.shared.fetchData(model: Records.self)
                if let records = data.records {
                    self.organizeDataBySurfBreak(records: records)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Erreur lors du chargement des données : \(error)")
            }
        }
    }
}

// MARK: - Filter Records
extension ViewController {
    
    /// Préparation des données
    /// Ici, on regroupe les `Records` en fonction de leur type
    private func organizeDataBySurfBreak(records: [Record]) {
        var groupedRecords = [String: [Record]]()
        
        records.forEach { record in
            record.fields?.surfBreak?.forEach { surfBreak in
                groupedRecords[surfBreak, default: []].append(record)
            }
        }
        sections = groupedRecords.compactMap { SurBreakSection(type: $0.key, records: $0.value) }
    }
}


// MARK: - Handle Data source and delegate of tableview
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // affichage des noms des sections
        return sections[section].type
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // nombre de records par section
        return sections[section].records.count
    }

    // Représentation sous forme de liste.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpotCell", for: indexPath) as? SpotCell else {
            return UITableViewCell()
        }
        let record = sections[indexPath.section].records[indexPath.row]
        if let fields = record.fields {
            cell.setUpCell(fields: fields)
        }
        return cell
    }
}

/// Création d'une structure pour représenter chaque section contenant le type de `Surf Break` et les `Records` correspondants.
struct SurBreakSection {
    var type: String
    var records: [Record]
}
