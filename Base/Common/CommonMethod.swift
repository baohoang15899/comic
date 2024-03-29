//
//  CommonMethod.swift
//  Base
//
//  Created by BaoHoang on 22/02/2023.
//

import Foundation
import CoreData
import UIKit

struct CommonMethod {
    
    static func getStatusBarHeight() -> CGFloat {
       var statusBarHeight: CGFloat = 0
       if #available(iOS 13.0, *) {
           let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
           statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
       } else {
           statusBarHeight = UIApplication.shared.statusBarFrame.height
       }
       return statusBarHeight
   }
    
    static func getDomainKey() -> String? {
        let key = UserDefaults.standard.object(forKey: DomainKey.domain) as? String
        return key
    }
    
    static func clearCache() {
        let context = AppDelegate.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ChapterCoreData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch  {
            print("Clear Cache Failed")
        }
        CacheManager.shared.clearCache()
    }
    
    static func saveDomain(domain: String) {
        UserDefaults.standard.set(domain, forKey: DomainKey.domain)
    }
    
}
