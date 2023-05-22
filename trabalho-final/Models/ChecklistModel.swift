//
//  ChecklistModel.swift
//  trabalho-final
//
//  Created by Tabita Barbosa on 21/05/23.
//

import Foundation

class ChecklistModel {
    var checklistType: String
    var checklistItem: [String]
    var isChecked: Bool = false
    
    init (checklistType: String, checklistItem: [String]) {
        self.checklistType = checklistType
        self.checklistItem = checklistItem
    }
}
