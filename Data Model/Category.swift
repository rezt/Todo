//
//  Category.swift
//  Todo
//
//  Created by Piotr Ćwiertnia on 11/09/2021.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
