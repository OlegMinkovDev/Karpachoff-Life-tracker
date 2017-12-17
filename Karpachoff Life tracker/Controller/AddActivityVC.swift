//
//  AddActivityVC.swift
//  Karpachoff Life tracker
//
//  Created by Oleg Minkov on 15/12/2017.
//  Copyright © 2017 Oleg Minkov. All rights reserved.
//

import UIKit

class AddActivityVC: UIViewController, OMSwitchDelegate {

    
    @IBOutlet weak var activityHeadImageView: UIImageView!
    @IBOutlet weak var startActivityButton: UIButton!
    @IBOutlet weak var activitySettingsView: UIView!
    @IBOutlet weak var notificationOMSwitch: OMSwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDelimitersView()
    }
    
    // MARK: - UI Methods
    @IBAction func closePress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func omSwitchValueDidChange(_ omSwitch: OMSwitch) {
        print(omSwitch.isOn)
    }
    
    // MARK: - Helpful functions
    func createDelimitersView() {
        
        view.layoutIfNeeded()
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let headerHeight = activityHeadImageView.frame.height
        let buttonHeight = startActivityButton.frame.height
        
        let settingsViewHeight = screenHeight - (headerHeight + buttonHeight)
        let settingsSectionHeight = settingsViewHeight / 7
        
        for i in 0 ..< 7 {
            
            let delimiterView = UIView(frame: CGRect(x: 0, y: (CGFloat(i) * settingsSectionHeight), width: screenWidth, height: 1))
            delimiterView.backgroundColor = .groupTableViewBackground
            
            activitySettingsView.addSubview(delimiterView)
        }
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
