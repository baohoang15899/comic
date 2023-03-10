//
//  UIViewExtension.swift
//  Base
//
//  Created by baohoang on 19/01/2023.
//

import Foundation
import UIKit


extension UINib {
    func instantiate(owner: Any? = nil) -> Any? {
        return self.instantiate(withOwner: owner, options: nil).first
    }
}

protocol NibLoadable: AnyObject {}
extension NibLoadable where Self: UIView {

    static var nib: UINib {
        let bundle = Bundle(for: self)
        return UINib(nibName: "\(self)", bundle: bundle)
    }

    func loadFromNib() -> UIView {
        return type(of: self).nib.instantiate(owner: self) as! UIView // swiftlint:disable:this force_cast
    }
}

@IBDesignable
class XibView: UIView, NibLoadable {

    @IBOutlet weak var viewXIB: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }

    private func nibSetup() {
        backgroundColor = .clear

        viewXIB = loadFromNib()
        viewXIB.frame = bounds
        viewXIB.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewXIB.translatesAutoresizingMaskIntoConstraints = true

        addSubview(viewXIB)
    }
}

class XibTableViewCell: UITableViewCell, NibLoadable {}

class XibCollectionViewCell: UICollectionViewCell, NibLoadable {}
