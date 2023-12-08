//
//  Utils.swift
//  ToDoApp
//
//  Created by Владислав Лесовой on 07.12.2023.
//

import Foundation
struct Priority: Identifiable{
    var id: Int
    var name: String
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
