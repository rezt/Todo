//
//  Data.swift
//  Todo
//
//  Created by Piotr Ćwiertnia on 07/09/2021.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
