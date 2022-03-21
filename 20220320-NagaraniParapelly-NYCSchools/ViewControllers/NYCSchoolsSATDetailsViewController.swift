//
//  NYCSchoolsSATDetailsViewController.swift
//  20220320-NagaraniParapelly-NYCSchools
//
//  Created by raniraja on 3/20/22.
//

import UIKit
import MessageUI
private struct LocalConstants {
    static let EmailNotSent = "Could not sent email"
    static let DeviceEmailSupport = "Check if your device have email support!"
    static let DevicePhoneCall =  "Device does not support phone calls."
    static let AlertITitle = "Alert"
    static let alertOk = "OK"

}
class NYCSchoolsSATDetailsViewController: NYCRootViewController, MFMailComposeViewControllerDelegate {
    /** As i need to access in previous VC so not declaring as private ***/
    var schoolDetailsObject: SchoolInfo!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var writingScoreLabel: UILabel!
    @IBOutlet weak var readingScoreLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mathScoreLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    /*** Creating instance for calling network API ***/
    lazy var schoolDetailsViewModelObject: NYCSATDetailsViewModelObject = {
        let vModelObj = NYCSATDetailsViewModelObject()
        return vModelObj
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSchoolInfo()
        let schoolDetails = "\(Constants.kGetNYCSATDetails)\("/?dbn=")\(schoolDetailsObject.dbn!)"
        schoolDetailsViewModelObject.getSchoolDataFromNetworkAPI(urStr: schoolDetails) { [weak self]success, errorCode in
            if success {
                self?.updateUI()
            } else {
                DispatchQueue.main.async { [unowned self] in
                    if let selfObj = self {
                        selfObj.stopAnimating()
                    if let errorCodeObj: APIClientError = errorCode as? APIClientError {
                        let alertInfo: (String, String) =  selfObj.schoolDetailsViewModelObject.getAlertInfo(code: errorCodeObj)
                        let alert = UIAlertController(title: alertInfo.0, message: alertInfo.1, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: LocalConstants.alertOk, style: UIAlertAction.Style.default, handler: nil))
                        selfObj.present(alert, animated: true, completion: nil)
                    }
                    }
                }
            }
        }
    }
    /*** Update school data ***/
    private func updateSchoolInfo() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(contactlabelClicked))
        contactLabel.addGestureRecognizer(gesture)
        let emailgesture = UITapGestureRecognizer(target: self, action: #selector(emailClickable))
        emailLabel.addGestureRecognizer(emailgesture)
    }
    /** Mail compose ***/
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Saved")
        case MFMailComposeResult.sent.rawValue:
            print("Sent")
        case MFMailComposeResult.failed.rawValue:
            print("Error:)")
        default:
            break
        }
        controller.dismiss(animated: true)
    }
    /*** Email click action ***/
    @objc private func emailClickable() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([schoolDetailsViewModelObject.getMailFormat(text: schoolDetailsObject?.schoolEmail)])
            mail.setMessageBody("<p>Hello!</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            showError()
            // show failure alert
        }
    }
    /** Show error email device support***/
    private func showError() {
        let alertMessage = UIAlertController(title: LocalConstants.EmailNotSent, message: LocalConstants.DeviceEmailSupport, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: LocalConstants.alertOk, style: UIAlertAction.Style.default, handler: nil)
        alertMessage.addAction(action)
        self.present(alertMessage, animated: true, completion: nil)
    }
    /** conatact action **/
    @objc private func contactlabelClicked() {
        guard UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone else {
            let alertMessage = UIAlertController(title: LocalConstants.AlertITitle, message: LocalConstants.DevicePhoneCall, preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: LocalConstants.alertOk, style: UIAlertAction.Style.default, handler: nil)
            alertMessage.addAction(action)
            self.present(alertMessage, animated: true, completion: nil)
            return
        }
        UIApplication.shared.open(schoolDetailsViewModelObject.call(phoneNumber: schoolDetailsObject?.schoolContact)!)
    }
    /** Updating UI SAT and School Info ***/
    private func updateUI() {
        infoView.layer.borderWidth = 1
        detailsView.layer.borderWidth = 1
        infoView.layer.borderColor = UIColor.white.cgColor
        detailsView.layer.borderColor = UIColor.white.cgColor
        infoView.layer.cornerRadius = 10
        detailsView.layer.cornerRadius = 10
        self.nameLabel.text = schoolDetailsObject?.schoolName  ?? ""
        self.contactLabel.attributedText = schoolDetailsViewModelObject.getSchoolClikable(text: schoolDetailsObject?.schoolContact)
        self.emailLabel.attributedText = schoolDetailsViewModelObject.getSchoolClikable(text: schoolDetailsObject?.schoolEmail)
        self.readingScoreLabel.textColor = .secondaryLabel
        self.mathScoreLabel.text = schoolDetailsViewModelObject.getMathScore()
        self.readingScoreLabel.text = schoolDetailsViewModelObject.getReadingScore()
        self.writingScoreLabel.text = schoolDetailsViewModelObject.getWritingScore()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
