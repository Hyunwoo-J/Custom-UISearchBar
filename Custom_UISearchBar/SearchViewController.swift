//
//  SearchViewController.swift
//  Custom_UISearchBar
//
//  Created by Hyunwoo Jang on 2022/04/10.
//

import UIKit


class SearchViewController: UIViewController {
    
    /// 서치바
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    /// 검색한 데이터를 정렬합니다.
    func sortSearchData() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let sortByNameAction = UIAlertAction(title: "이름순", style: .default) { _ in
            print("이름순으로 정렬합니다.")
        }
        alert.addAction(sortByNameAction)
        
        let sortByDateAction = UIAlertAction(title: "날짜순", style: .default) { _ in
            print("날짜순으로 정렬합니다.")
        }
        alert.addAction(sortByDateAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    /// 초기화 작업을 실행합니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = UIImage(named: "moon") {
            searchBar.setLeftImage(image, with: 20)
            
        }
        
        searchBar.placeholder = "검색어를 입력해주세요."
        
    }
    
    
    /// View가 표시된 후 호출됩니다.
    /// - Parameter animated: 애니메이션 사용 여부
    override func viewDidAppear(_ animated: Bool) {
        searchBar.changePlaceholderColor(.blue) // viewDidLoad에서 호출시 적용되지 않음
        if let image = UIImage(named: "filter") {
            searchBar.setRightImage(image)
        }
    }
}



extension SearchViewController: UISearchBarDelegate {
    
    /// 검색 버튼을 클릭하면 Activity Indicator를 실행합니다.
    /// - Parameter searchBar: 서치바
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.isLoading = true
    }
    
    
    /// 입력된 텍스트가 없으면 Acitivity Indicator를 종료합니다.
    /// - Parameters:
    ///   - searchBar: 서치바
    ///   - searchText: 검색할 텍스트
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBar.isLoading = false
        }
    }
    
    
    /// 북마크 버튼이 탭되면 정렬 관련 액션시트를 띄웁니다.
    /// - Parameter searchBar: 서치바
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        sortSearchData()
    }
}
