//
//  ContactController.swift
//  TravLog
//
//  Created by Ben Kaufman on 10/26/15.
//  Copyright © 2015 TravLog. All rights reserved.
//

import UIKit
import MessageUI

class ContactController: UIViewController, MFMailComposeViewControllerDelegate {
        
    @IBOutlet weak var MessageBody: UITextView!
    
    @IBOutlet weak var SubjectField: UITextField!
    
    @IBAction func SendEmail(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        }
    
        func configuredMailComposeViewController() -> MFMailComposeViewController {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
            
            mailComposerVC.setToRecipients(["blkaufma@uvm.edu"])
            mailComposerVC.setSubject("Hello TravLog")
            
            return mailComposerVC
        }
        
        func showSendMailErrorAlert() {
            let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
            sendMailErrorAlert.show()
        }
        
        // MARK: MFMailComposeViewControllerDelegate
        
        func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
            controller.dismissViewControllerAnimated(true, completion: nil)
            
        }
}
