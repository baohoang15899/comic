//
//  SwiftSoupService.swift
//  Base
//
//  Created by BaoHoang on 16/01/2023.
//

import Foundation
import SwiftSoup

class CacheManager {
    
    static let shared = CacheManager()
    
    let cache = NSCache<NSString, AnyObject>()
    
    func setCache(item: AnyObject, key: String) {
        cache.setObject(item, forKey: key as NSString)
    }
    
    func getCache(key: String) -> AnyObject? {
        return cache.object(forKey: key as NSString)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}

struct SwiftSoupService {

    static func getAllElements(document: Document?, className: String) -> Elements? {
        var data: Elements?
        do {
            data = try document?.body()?.select(className)
        } catch {
            print("Can't parse html")
        }
        return data
    }
    
    static func getSingleElement(document: Document?, className: String) -> Element? {
        var data: Element?
        do {
            data = try document?.body()?.select(className).first()
        } catch {
            print("Can't parse html")
        }
        return data
    }
    
    static func elementToString(element: Element?, className: String) -> String? {
        var data: String?
        do {
            data = try element?.select(className).first()?.text()
        } catch {
            print("Can't parse html")
        }
        return data
    }
    
    static func nextSiblingToString(element: Element?, className: String) -> String? {
        var data: String?
        do {
            data = try element?.select(className).first()?.nextElementSibling()?.text()
        } catch {
            print("Can't parse html")
        }
        return data
    }
    
    static func lastSiblingToString(element: Element?, className: String) -> String? {
        var data: String?
        do {
            data = try element?.select(className).first()?.lastElementSibling()?.text()
        } catch {
            print("Can't parse html")
        }
        return data
    }
    
    static func getAttrFromHtml(element: Element?,className: String, attr: String) -> String? {
        var data: String?
        do {
            data = try element?.select(className).first()?.attr(attr)
        } catch {
            print("Can't parse html")
        }
        return data
    }
    
    static func getEmptyDocument() -> Document {
        do {
           let html = "<html><head><title>First parse</title></head>"
               + "<body><p>Parsed HTML into a doc.</p></body></html>"
           let doc: Document = try SwiftSoup.parse(html)
           return doc
        } catch {
            print("error")
        }
        return Document("")
    }
    
}
