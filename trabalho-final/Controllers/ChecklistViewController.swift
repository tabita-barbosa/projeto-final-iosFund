//
//  ChecklistViewController.swift
//  trabalho-final
//
//  Created by Tabita Barbosa on 21/05/23.
//

import Foundation
import UIKit

enum ChecklistType {
    case airbus
    case boeing
}

class ChecklistViewController: UIViewController {
    
    var items = [ChecklistModel]()
    var type: ChecklistType
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: ChecklistType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupView()
    }
    
    func setupView() {
        navigationItem.title = "Checklist"
        navigationItem.backAction?.title = "voltar"
        self.setupHierarchy()
        self.setupConstraints()
        self.checklistPopulate(type: self.type)
        self.checklistTable.delegate = self
        self.checklistTable.dataSource = self
    }
    
    func checklistPopulate(type: ChecklistType) {
        switch type {
        case .airbus:
            self.items.append(ChecklistModel.init(checklistType: "Cockpit Preparation",
                                                  checklistItem: ["Seat belts",
                                                                  "Adirs",
                                                                  "Parking Brakes"]))
            self.items.append(ChecklistModel.init(checklistType: "Before Start",
                                                  checklistItem: ["Parking Brake",
                                                                  "Windows",
                                                                  "Beacon"]))
            self.items.append(ChecklistModel.init(checklistType: "After Start",
                                                  checklistItem: ["Anti Ice",
                                                                  "ECAM Status",
                                                                  "Rudder Trim"]))
            self.items.append(ChecklistModel.init(checklistType: "Taxi",
                                                  checklistItem: ["Flight Control",
                                                                  "Radar & PWS",
                                                                  "ECAM Memo"]))
            self.items.append(ChecklistModel.init(checklistType: "Approach & Landing",
                                                  checklistItem: ["Seat Belts",
                                                                  "Cabin Crew",
                                                                  "ECAM Memo"]))
            self.items.append(ChecklistModel.init(checklistType: "After Landing",
                                                  checklistItem: ["Radar & PWS"]))
            self.items.append(ChecklistModel.init(checklistType: "Parking",
                                                  checklistItem: ["Park Break or Chocks",
                                                                  "Engines",
                                                                  "Wing Lights",
                                                                  "Fuel Pumps"]))
            self.items.append(ChecklistModel.init(checklistType: "Securing the Aircraft",
                                                  checklistItem: ["Oxygen", "Emer Exit LT", "EFBs", "Batteries"]))
        case .boeing:
            self.items.append(ChecklistModel.init(checklistType: "Pre Flight",
                                                  checklistItem: ["Parking Brakes",
                                                                  "Battery Switch",
                                                                  "APU Generator",
                                                                  "APU Master Knob",
                                                                  "External Power",
                                                                  "Landing Gear",
                                                                  "Flaps Lever",
                                                                  "Speedbrakes Lever",
                                                                  "Engine Pump Controls",
                                                                  "Fuel Pump Switches",
                                                                  "Engine Instruments",
                                                                  "Anti-Ice Controls",
                                                                  "Window Heating",
                                                                  "Altitude Setting",
                                                                  "IFR Clearance",
                                                                  "Fuel Quantity",
                                                                  "Beacon Lighting"]))
            self.items.append(ChecklistModel.init(checklistType: "Before Startup",
                                                  checklistItem: ["Seat belt sign",
                                                                  "Fuel quantity",
                                                                  "Engine throttle",
                                                                  "Engine area",
                                                                  "Auto-Breake setting"]))
            self.items.append(ChecklistModel.init(checklistType: "Engine Startup",
                                                  checklistItem: ["APU Master Knob Start",
                                                                  "APU Generator",
                                                                  "Engine EEC Modes",
                                                                  "Engine Starter Knob",
                                                                  "Engine Fuel Controls",
                                                                  "Engine Generators L1, R1",
                                                                  "APU Master Knob",
                                                                  "APU Generator",
                                                                  "External Power",
                                                                  "Auto-Breake setting"]))
            self.items.append(ChecklistModel.init(checklistType: "Before Taxi",
                                                  checklistItem: ["Parking Brakes",
                                                                  "Fuel Quantity",
                                                                  "Taxi Lights",
                                                                  "Navigation Lights",
                                                                  "Instrument Displays",
                                                                  "Taxi Clearence"]))
            self.items.append(ChecklistModel.init(checklistType: "Taxi",
                                                  checklistItem: ["Flight Directors",
                                                                  "Parking Brakes"]))
        }

        self.checklistTable.reloadData()
    }
    
    private lazy var checklistTable: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.allowsMultipleSelection = true
        return table
    }()
}

extension ChecklistViewController {
    func setupHierarchy() {
        view.addSubview(self.checklistTable)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.checklistTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.checklistTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24.0),
            self.checklistTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.checklistTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12.0),
            self.checklistTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ChecklistViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].checklistItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = items[indexPath.section].checklistItem[indexPath.row]
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor(named: "lightBlue")
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = .white
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].checklistType
    }
}
