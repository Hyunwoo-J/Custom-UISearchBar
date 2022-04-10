//
//  ViewController.swift
//  Custom_UISearchBar
//
//  Created by Hyunwoo Jang on 2022/04/10.
//

import UIKit


class ViewController: UIViewController {
    
    /// 서치바를 생성합니다.
    private func initSearchBar() {
        // 서치바 생성
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width - 80, height: 0))
        
        // 플레이스 홀더
        searchBar.placeholder = "검색어를 입력해주세요."
        
        if #available(iOS 14.0, *) {
            let search = UIBarButtonItem(systemItem: .search, primaryAction: UIAction(handler: { _ in
                print(#function) // 오른쪽 돋보기 이미지를 클릭하면 출력됨
            }))
            self.navigationItem.rightBarButtonItem = search
        } else {
            let search = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
            self.navigationItem.rightBarButtonItem = search
        }
        
        
        // 서치바 넣기
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        
        // 서치바 왼쪽 돋보기 이미지 없애기
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        
        // 오른쪽 돋보기 이미지 색상 변경
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        // 서치바 텍스트필드 배경색 변경
        searchBar.searchTextField.backgroundColor = .clear
        
        // 서치바 텍스트필드 폰트 크기 변경
        searchBar.searchTextField.font = .systemFont(ofSize: 20)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSearchBar()
    }
}
