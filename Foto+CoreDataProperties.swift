//
//  Foto+CoreDataProperties.swift
//  Fotorama
//
//  Created by Michael Worden on 2/16/22.
//
//

import Foundation
import CoreData


extension Foto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Foto> {
        return NSFetchRequest<Foto>(entityName: "Foto")
    }

    @NSManaged public var fotoID: String?
    @NSManaged public var title: String?
    @NSManaged public var dateTaken: Date?
    @NSManaged public var remoteURL: URL?

}

extension Foto : Identifiable {

}
