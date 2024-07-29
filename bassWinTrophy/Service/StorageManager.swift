//
//  StorageManager.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//


import SwiftUI
import RealmSwift


class StorageManager {
    
    static let shared = StorageManager()
    
    private init(){}
    
    let realm = try! Realm()

    
    @ObservedResults(FisherGradeList.self) var customGradeLists
    @ObservedResults(Trophy.self) var prizes
    
    func getMOCK() -> Trophy {
        let mock = Trophy()
        mock.imageData = UIImage(named: "logo")?.pngData()
        mock.theme = "123"
        mock.notion = "12312 13 123 123 123 12 31 231 23123 123 12 312 3"
        return mock
    }
    
    
    func deleteAllData() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            print("Ошибка при удалении данных из Realm: \(error.localizedDescription)")
        }
    }
    
    
    func deletePrize(trophy: Trophy) {
        do {
            let trophyRef = ThreadSafeReference(to: trophy)
            guard let trophy = realm.resolve(trophyRef) else { return }
            
            try realm.write {
                realm.delete(trophy)
            }
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func saveTrophy(photo: UIImage?, weight: String, notion: String, lon: Double?, lat: Double?) {
        guard let photo = photo else { return }
        guard let imageData = photo.jpegData(compressionQuality: 1.0) else { return }

        let prize = Trophy()
        prize.imageData = imageData
        prize.theme = weight
        prize.notion = notion
        prize.longtitude = lon
        prize.latitude = lat

        try! realm.write {
            realm.add(prize)
        }
    }
    
    func createNewCustomGradeList(name: String, list: [FisherGradeElement]) {

        let newGradeCategory = FisherGradeList()
        newGradeCategory.name = name
        
        for element in list {
            newGradeCategory.gradeList.append(element)
        }
        
        $customGradeLists.append(newGradeCategory)
    }
    
    func updateCustomGradeList(id: ObjectId, name: String, list: [FisherGradeElement]) {
        guard let gradeListToUpdate = realm.object(ofType: FisherGradeList.self, forPrimaryKey: id) else {
            print("GradeList not found")
            return
        }

        try! realm.write {
            gradeListToUpdate.name = name

            let elementsToDelete = RealmSwift.List<FisherGradeElement>()
            elementsToDelete.append(objectsIn: gradeListToUpdate.gradeList)
            realm.delete(elementsToDelete)

            for element in list {
                let newElement = FisherGradeElement()
                newElement.note = element.note
                newElement.image = element.image
                newElement.color = element.color
                newElement.grade = element.grade

                gradeListToUpdate.gradeList.append(newElement)
            }
        }
    }
}
