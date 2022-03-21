//
//  NYCSchoolsViewModelObject.swift
//  20220320-NagaraniParapelly-NYCSchools
//
//  Created by raniraja on 3/20/22.
//

import UIKit
private struct LocalConstants {
    static let serverReachability = "Unable to reach Server"
    static let tryAgain = "Please tryagain later"
}
class NYCSchoolsViewModelObject: NSObject {
    /** Creating instance of network class to call api ***/
    private let networkClassObject = NetworkRequestObject()
    /** Alias for existing type ***/
    typealias completionBlock = (Bool, Error?) -> Void
    /** To append school info data ***/
    private var schoolInfoList = [SchoolInfo]()
    /** To append data to search filter array ***/
    private var filtered = [SchoolInfo]()
    /*** call network api and based on responce send back to VC to update UI ***/
    func getSchoolDataFromNetworkAPI(urStr: String, completionBlock: @escaping completionBlock) {
        networkClassObject.get(endpoint: urStr, type: [SchoolInfo].self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self.schoolInfoList = items
                    completionBlock(true, nil)
                case .failure(let error):
                    completionBlock(false, (error as APIClientError))
                }
            }
        }
    }
    func getAlertInfo(code: Error) -> (String, String) {
        return (LocalConstants.serverReachability, LocalConstants.tryAgain)
    }
    /*** Table view number or rows based on array count / search filter count ***/
    func numberOfItemsInRow() -> Int {
        if filtered.count > 0 {
            return filtered.count
        }
        return schoolInfoList.count
    }
    /*** school name to display in each row***/
    func titleForItemIndexPath(indexpath: IndexPath) -> String? {
        if filtered.count > 0 {
            return filtered[indexpath.row].schoolName!
        }
        if let name = schoolInfoList[indexpath.row].schoolName {
            return name
        }
        return nil
    }
    /*** Getting selected row dbn to pass to get SAT details ***/
    func didSelectItem(indexPath: IndexPath) -> SchoolInfo {
        if filtered.count > 0 {
            return filtered[indexPath.row]
        }
        return schoolInfoList[indexPath.row]
    }
    /*** Based on search bar search test will filter ***/
    func searchText(stext: String) {
        filtered = schoolInfoList.filter({ (schoolObj) -> Bool in
            var searchObj: NSString = ""
            if let temp = schoolObj.schoolName as NSString? {
                searchObj = temp
            }
            let range = searchObj.range(of: stext, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
    }
}
