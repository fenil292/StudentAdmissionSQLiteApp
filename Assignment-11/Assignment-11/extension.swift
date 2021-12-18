//
//  extension.swift
//  Ass7
//
//  Created by DCS on 06/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

extension UIView {
    public var width:CGFloat{return frame.size.width}
    public var height:CGFloat{return frame.size.height}
    public var top:CGFloat{return frame.origin.y}
    public var bottom:CGFloat{return top+height}
    public var left:CGFloat{return frame.origin.x}
    public var right:CGFloat{return left+width}
}
