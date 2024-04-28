//
//  CollectionsConvertor.swift
//  Linkwarden
//
//  Created by Abilash S on 27/04/24.
//

import Foundation

class CollectionsConvertor {
    
    func convertCollectionModelToCollection(_ models: [CollectionModel]) -> [Collection] {
        var collections = [Collection]()
        
        models.forEach { model in
            guard let createdDate = DateTimeManager.defaultDateFormatter.dateFormatter.date(from: model.createdDate), let updatedDate = DateTimeManager.defaultDateFormatter.dateFormatter.date(from: model.updatedDate) else { return }
            
            let collection = Collection(collectionID: model.collectionID, name: model.name, description: model.description, color: model.color, parentID: model.parentID, isPublic: model.isPublic, ownerID: model.ownerID, createdDate: createdDate, updatedDate: updatedDate, count: model.count.links)
            
            collections.append(collection)
        }
        
        return collections
    }
}
