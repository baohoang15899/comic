//
//  LeftAlignFlowLayout.swift
//  Base
//
//  Created by baohoang on 22/01/2023.
//

import Foundation
import UIKit

class LeftAlignCollectionViewCellFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        //get an array of UICollectionViewLayoutAttributes for all the cells
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        
        var maxY: CGFloat = 2.0
        
        let horizontalSpacing: CGFloat = 0
        
        //Modify the UICollectionViewLayoutAttributes for each cell
        attributes?.forEach { layoutAttribute in
            
            if layoutAttribute.frame.origin.y >= maxY
                || layoutAttribute.frame.origin.x == sectionInset.left {
                
                leftMargin = sectionInset.left
            }
            
            if layoutAttribute.frame.origin.x == sectionInset.left {
                leftMargin = sectionInset.left
            }else {
                layoutAttribute.frame.origin.x = leftMargin
            }
            
            leftMargin += layoutAttribute.frame.width + horizontalSpacing
            
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        //return the array of modified UICollectionViewLayoutAttributes
        return attributes
    }
}
