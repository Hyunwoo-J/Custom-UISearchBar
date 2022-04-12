//
//  UIImage+Extension.swift
//  Custom_UISearchBar
//
//  Created by Hyunwoo Jang on 2022/04/12.
//

import UIKit


extension UIImage {
    
    /// 이미지의 alpha 값을 변경합니다.
    /// - Parameter value: 적용할 alpha 값
    /// - Returns: alpha 값이 적용된 이미지
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
