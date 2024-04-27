//
//  TagsConvertor.swift
//  Linkwarden
//
//  Created by Abilash S on 25/04/24.
//

import Foundation

class TagsConvertor {
    
    func convertTagsModelToTags(_ models: [TagsModel]) -> [Tag] {
        var tags = [Tag]()
        
        models.forEach { model in
            guard let createdDate = DateTimeManager.defaultDateFormatter.dateFormatter.date(from: model.createdDate), let updatedDate = DateTimeManager.defaultDateFormatter.dateFormatter.date(from: model.updatedDate) else { return }
            
            var linkCount: Int64 = 0
            if let count = model.linkCount {
                linkCount = count.links
            }
            
            let tag = Tag(tagID: model.tagID, name: model.name, ownerID: model.ownerID, createdDate: createdDate, updatedDate: updatedDate, linkCount: linkCount)
            
            tags.append(tag)
        }
        
        return tags
    }
    
}
