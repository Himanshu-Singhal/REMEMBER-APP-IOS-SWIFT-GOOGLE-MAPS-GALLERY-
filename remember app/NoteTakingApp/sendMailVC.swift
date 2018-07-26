//
//  sendMailVC.swift
//  NoteTakingApp
//
//  Created by MacStudent on 2017-08-14.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import UIKit
import MessageUI

class sendMailVC: UIViewController, MFMailComposeViewControllerDelegate{

    
    
    @IBOutlet weak var imgNotes: UIImageView!
    @IBOutlet weak var txtMessageBody: UITextView!
    
    @IBOutlet weak var txtReceipient: UITextField!
    
    @IBOutlet weak var txtSubject: UITextField!
    
    var noteTitle = ""
    var noteLocation = ""
    var noteImg : UIImage = UIImage()
    var noteAttach = ""
    var attachment = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtMessageBody.text = "Note Title : \(noteTitle) \n Location : \(noteLocation) \n Path : \(noteAttach)"
        
        imgNotes.image = noteImg
        attachment = noteAttach
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendEmail(_ sender: Any) {
        
        if( MFMailComposeViewController.canSendMail() ) {
            print("Can send email.")
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            //Set the subject and message of the email
            mailComposer.setToRecipients(["\(txtReceipient.text)"])
            mailComposer.setSubject("\(txtSubject.text)")
            mailComposer.setMessageBody("\(txtMessageBody.text)", isHTML: false)
            
            if let filePath = Bundle.main.path(forResource: "\(attachment)", ofType: "jpeg") {
                print("File path loaded.")
                
                if let fileData = NSData(contentsOfFile: filePath) {
                    print("File data loaded.")
                    mailComposer.addAttachmentData(fileData as Data, mimeType: "jpeg", fileName: "Note123")
                }
            }
            self.present(mailComposer, animated: true, completion: nil)

            
        }
        let alertController = UIAlertController(title: title, message: "Send Email Successfully", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil);
        
        
        
        print(" Sent Mail Succcessfully to \(txtReceipient.text)")
    }
    
    func mailComposeController(controller: MFMailComposeViewController,
                               didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
