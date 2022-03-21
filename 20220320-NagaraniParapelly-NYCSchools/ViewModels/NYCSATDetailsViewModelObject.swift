//
//  NYCSATDetailsViewModelObject.swift
//  20220320-NagaraniParapelly-NYCSchools
//
//  Created by raniraja on 3/20/22.
//

import UIKit
private struct LocalConstants {
    static let serverReachability = "Unable to reach Server"
    static let tryAgain = "Please tryagain later"
}
class NYCSATDetailsViewModelObject: NSObject {
    //typealias completionBlock = () -> Void
    typealias completionBlock = (Bool, Error?) -> Void
    /*** Creating instance to call network api ***/
    private let networkClassObject = NetworkRequestObject()
    /** Creating instance to store SAT data **/
    private var schoolSATDaataObject: SchoolSATResults?
    func getSchoolDataFromNetworkAPI(urStr: String, completionBlock: @escaping completionBlock) {
        /** After calling network based on responce will parse or update UI **/
        networkClassObject.get(endpoint: urStr, type: [SchoolSATResults].self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let schoolDetail):
                    if schoolDetail.count > 0 {
                    self.schoolSATDaataObject = schoolDetail[0]
                    }
                    completionBlock(true, nil)
                case .failure(let error):
                    completionBlock(false, error as APIClientError)
                }
            }
        }
    }
    func getAlertInfo(code: Error) -> (String, String) {
        return (LocalConstants.serverReachability, LocalConstants.tryAgain)
    }
    /** Getting SAT match avg score ***/
    func getMathScore() -> String {
        return (schoolSATDaataObject?.mathAvgScore) ?? scoreNotAvaible
    }
    /** Getting SAT Avg reading score ***/
    func getReadingScore() -> String {
        return schoolSATDaataObject?.readAvgScore ?? scoreNotAvaible
    }
    /** Getting writing avg score ***/
    func getWritingScore() -> String {
        return schoolSATDaataObject?.writingAvgScore ?? scoreNotAvaible
    }
    /*** Formatting email to clickable link ***/
    func getSchoolClikable(text: String?) -> NSAttributedString {
        if  text != nil {
            let range = (text! as NSString).range(of: text!, options: .caseInsensitive)
            let attributeStr: NSMutableAttributedString = NSMutableAttributedString(string: text!)
            attributeStr.addAttribute(.link, value: text!, range: range )
            return attributeStr
        }
        return NSAttributedString(string: "Info Not Available")
    }
    /***  Formatting mail clickable **/
    func getMailFormat(text: String?) -> String {
        return text ?? ""
    }
    /*** Formatting phone number ***/
    func call(phoneNumber: String?) -> URL? {
        let cleanPhoneNumber = phoneNumber?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        let urlString: String = "tel://\(cleanPhoneNumber ?? "")"
        if let phoneCallURL = URL(string: urlString) {
            return phoneCallURL
        }
        return nil
    }
}
