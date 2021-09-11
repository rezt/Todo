//
//  Item.swift
//  Todo
//
//  Created by Piotr Ćwiertnia on 07/09/2021.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
