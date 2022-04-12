//
//  UISearchBar+Extension.swift
//  Custom_UISearchBar
//
//  Created by Hyunwoo Jang on 2022/04/12.
//

import UIKit


extension UISearchBar {
    
    /// 텍스트 필드
    ///
    /// UITextField에 안전하게 Access할 수 있는 코드입니다.
    public var textField: UITextField? {
        if #available(iOS 13, *) {
            return searchTextField
        }
        let subViews = subviews.flatMap { $0.subviews }

        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }

        return textField
    }


    /// 서치바 안 텍스트 필드 왼쪽에 이미지를 추가합니다.
    /// - Parameters:
    ///   - image: 추가할 이미지
    ///   - padding: 왼쪽 여백
    ///
    ///   패딩이 0일 경우, 텍스트 필드에 패딩뷰는 추가하지 않고 이미지뷰만 추가합니다.
    ///   패딩이 0이 아닐 경우, 패딩뷰와 이미지뷰를 스택뷰에 추가하고 텍스트 필드 왼쪽에 추가합니다.
    func setLeftImage(_ image: UIImage, with padding: CGFloat = 0) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moon")
        imageView.translatesAutoresizingMaskIntoConstraints = false // auto layout을 사용하여 크기와 위치를 동적으로 계산하려면, 이 프로퍼티를 false로 설정해야 한다.
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true // 이미지뷰 너비 제약
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true // 이미지뷰 높이 제약
        imageView.tintColor = .gray

        if padding != 0 {
            let stackView = UIStackView() // 스택뷰
            stackView.axis = .horizontal // 가로축의 스택뷰(View들을 가로로 배치 (| | |))
            stackView.alignment = .center // 정렬은 중간으로
            stackView.distribution = .fill // 꽉 채우게 배분
            stackView.translatesAutoresizingMaskIntoConstraints = false // auto layout을 사용하여 크기와 위치를 동적으로 계산하려면, 이 프로퍼티를 false로 설정해야 한다.

            let paddingView = UIView()
            paddingView.translatesAutoresizingMaskIntoConstraints = false // auto layout을 사용하여 크기와 위치를 동적으로 계산하려면, 이 프로퍼티를 false로 설정해야 한다.
            paddingView.widthAnchor.constraint(equalToConstant: padding).isActive = true // 패딩뷰의 너비 제약
            paddingView.heightAnchor.constraint(equalToConstant: padding).isActive = true // 패딩뷰의 높이 제약
            stackView.addArrangedSubview(paddingView) // 스택뷰에 패딩뷰 추가
            stackView.addArrangedSubview(imageView) // 스태뷰에 이미지뷰 추가
            textField?.leftView = stackView
        } else {
            textField?.leftView = imageView
        }
    }


    /// 서치바의 플레이스홀더 색상을 변경합니다.
    /// - Parameter color: 변경할 색상
    func changePlaceholderColor(_ color: UIColor) {
        guard let UISearchBarTextFieldLabel: AnyClass = NSClassFromString("UISearchBarTextFieldLabel"),
              let field = textField else {
            return
        }

        for subview in field.subviews where subview.isKind(of: UISearchBarTextFieldLabel) {
            (subview as! UILabel).textColor = color
        }
    }

    
    /// Activity Indicator
    public var activityIndicator: UIActivityIndicatorView? {
        return textField?.leftView?.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
    }
    
    
    /// 로딩 플래그
    var isLoading: Bool {
        get {
            return activityIndicator != nil
        } set {
            if newValue {
                if activityIndicator == nil {
                    let newActivityIndicator = UIActivityIndicatorView(style: .medium)
                    newActivityIndicator.color = .gray
                    newActivityIndicator.startAnimating()
                    newActivityIndicator.backgroundColor = textField?.backgroundColor ?? .systemGray6
                    textField?.leftView?.addSubview(newActivityIndicator)
                    let leftViewSize = textField?.leftView?.frame.size ?? .zero
                    newActivityIndicator.center = CGPoint(x: leftViewSize.width - newActivityIndicator.frame.width / 2, y: leftViewSize.height / 2)
                }
            } else {
                activityIndicator?.removeFromSuperview()
            }
        }
    }
    
    
    /// 서치바 안 텍스트 필드 오른쪽에 이미지를 추가합니다.
    /// - Parameter image: 추가할 이미지
    func setRightImage(_ image: UIImage) {
        showsBookmarkButton = true
        if let btn = textField?.rightView as? UIButton {
            btn.translatesAutoresizingMaskIntoConstraints = false // auto layout을 사용하여 크기와 위치를 동적으로 계산하려면, 이 프로퍼티를 false로 설정해야 한다.
            btn.widthAnchor.constraint(equalToConstant: 20).isActive = true // 버튼 너비 제약
            btn.heightAnchor.constraint(equalToConstant: 20).isActive = true // 버튼 높이 제약
            
            
            btn.setImage(image, for: .normal)
            btn.setImage(image.alpha(0.5), for: .highlighted)
        }
    }
}
