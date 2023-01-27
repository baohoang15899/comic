//
//  SwiftSoupService.swift
//  Base
//
//  Created by BaoHoang on 16/01/2023.
//

import Foundation
import SwiftSoup

class SwiftSoupService {
    
    static let shared = SwiftSoupService()
    
    func getAllElements(document: Document?, className: String) -> Elements? {
        var data: Elements?
        do {
            data = try document?.body()?.select(className)
        } catch {
            print("Can't parse html")
        }
        return data
    }
    
    func getSingleElement(document: Document?, className: String) -> Element? {
        var data: Element?
        do {
            data = try document?.body()?.select(className).first()
        } catch {
            print("Can't parse html")
        }
        return data
    }
    
    func elementToString(element: Element?, className: String) -> String? {
        var data: String?
        do {
            data = try element?.select(className).first()?.text()
        } catch {
            print("Can't parse html")
        }
        return data
    }
    
    func lastSiblingToString(element: Element?, className: String) -> String? {
        var data: String?
        do {
            data = try element?.select(className).first()?.lastElementSibling()?.text()
        } catch {
            print("Can't parse html")
        }
        return data
    }
    
    func getAttrFromHtml(element: Element?,className: String, attr: String) -> String? {
        var data: String?
        do {
            data = try element?.select(className).first()?.attr(attr)
        } catch {
            print("Can't parse html")
        }
        return data
    }
    
}
