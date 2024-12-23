//
//  MemoData+CoreDataProperties.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/23/24.
//
//

import Foundation
import CoreData


extension MemoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoData> {
        return NSFetchRequest<MemoData>(entityName: "MemoData")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var content: String
    @NSManaged public var date: Date
    @NSManaged public var isChecked: Bool
    @NSManaged public var notificationType: NotificationType
}

extension MemoData : Identifiable {

}
