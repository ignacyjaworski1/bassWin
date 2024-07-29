//
//  Trophy.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//



import SwiftUI
import RealmSwift



class Trophy: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var imageData: Data?
    @Persisted var theme: String?
    @Persisted var notion: String?
    @Persisted var longtitude: Double?
    @Persisted var latitude: Double?
}



