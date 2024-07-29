//
//  FisherGradeList.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//





import Foundation
import RealmSwift

class FisherGradeList: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String = ""

    @Persisted var gradeList = RealmSwift.List<FisherGradeElement>()
}

class FisherGradeElement: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var note = ""
    @Persisted var grade = ""
    @Persisted var color: ColorObject?
    @Persisted var image: Data?
}




class ColorObject: Object {
    @Persisted var red: Double?
    @Persisted var green: Double?
    @Persisted var blue: Double?
    @Persisted var alpha: Double?
}
