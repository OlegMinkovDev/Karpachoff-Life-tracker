//
//  PopUpVC.swift
//  Karpachoff Life tracker
//
//  Created by Oleg Minkov on 20/12/2017.
//  Copyright © 2017 Oleg Minkov. All rights reserved.
//

import UIKit

class PopUpVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    var completion: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    // MARK: UI Methods
    @IBAction func donePress(_ sender: UIButton) {
        completion?(textView.text)
        dismissVC()
    }
    
    @IBAction func cancelPress(_ sender: UIButton) {
        dismissVC()
    }
    
    // MARK: - Keybourd Events
    @objc func keyboardWillShow(_ notification: Notification) {
        
        //Need to calculate keyboard exact size due to Apple suggestions
        guard let userInfo = notification.userInfo, let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else {
            return
        }
        
        textViewBottomConstraint.constant = textViewBottomConstraint.constant + keyboardSize.height
    }
    
    // MARK: Helpful functions
    func dismissVC() {
        
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
