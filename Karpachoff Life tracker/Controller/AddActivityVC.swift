//
//  AddActivityVC.swift
//  Karpachoff Life tracker
//
//  Created by Oleg Minkov on 15/12/2017.
//  Copyright © 2017 Oleg Minkov. All rights reserved.
//

import UIKit

class AddActivityVC: UIViewController {

    
    @IBOutlet weak var activityHeadImageView: UIImageView!
    @IBOutlet weak var startActivityButton: UIButton!
    @IBOutlet weak var activitySettingsView: UIView!
    
    @IBOutlet weak var notificationOMSwitch: OMSwitch!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var activityRatingLabel: UILabel!
    
    var datePicker = UIDatePicker()
    var activeField: UITextField!
    
    let screenSize = UIScreen.main.bounds
    var currentSelectedDate: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentSelectedDate = getCorrectDate(date: Date(), mode: .date)
        
        createDelimitersView()
        setupTextFields()
    }
    
    // MARK: - UI Methods
    @IBAction func closePress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeActivityPress(_ sender: UIButton) {
    }
    
    @IBAction func changeStartDatePress(_ sender: UIButton) {
        dateTextField.becomeFirstResponder()
        //activeField = startDateTextField
    }
    
    @IBAction func changeTimePress(_ sender: UIButton) {
        startTimeTextField.becomeFirstResponder()
        //activeField = timeTextField
    }
    
    @IBAction func changeDescriptionPress(_ sender: UIButton) {
    }
    
    @IBAction func changeEndDatePress(_ sender: UIButton) {
        endTimeTextField.becomeFirstResponder()
        //activeField = endDateTextField
    }
    
    @IBAction func addLikePress(_ sender: UIButton) {
    }
    
    @IBAction func addDislikePress(_ sender: UIButton) {
    }
    
    @IBAction func startActivityPress(_ sender: UIButton) {
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        
        if sender.datePickerMode == .date {
            currentSelectedDate = getCorrectDate(date: sender.date, mode: .date)
        } else if sender.datePickerMode == .time {
            currentSelectedDate = getCorrectDate(date: sender.date, mode: .time)
        }
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
    
    func createDatePickerView(mode: UIDatePickerMode) -> UIDatePicker {
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = mode
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        return datePicker
    }
    
    func createAccessoryView(mode: UIDatePickerMode) -> UIView {
        
        let accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        accessoryView.backgroundColor = .groupTableViewBackground
        
        let accessoryControlHeight:CGFloat = 44
        let accessoryControlWidth:CGFloat = screenSize.width / 3
        
        var okButton: UIButton {
            
            let rect = CGRect(x: screenSize.width - accessoryControlWidth, y: 0, width: accessoryControlWidth - 5, height: accessoryControlHeight)
            
            let button = UIButton(frame: rect)
            button.setTitle("Ок", for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.contentHorizontalAlignment = .right
            button.addTarget(self, action: #selector(selectButtonAction), for: .touchUpInside)
            
            return button
        }
        
        var cancelButton: UIButton {
            
            let rect = CGRect(x: 5, y: 0, width: accessoryControlWidth - 5, height: accessoryControlHeight)
            
            let button = UIButton(frame: rect)
            button.setTitle("Отмена", for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.contentHorizontalAlignment = .left
            button.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
            
            return button
        }
        
        var title: UILabel {
            
            let rect = CGRect(x: accessoryControlWidth, y: 0, width: accessoryControlWidth, height: accessoryControlHeight)
            
            let label = UILabel(frame: rect)
            label.textAlignment = .center
            label.text = setAccessoryName(mode: mode)
            
            return label
        }
        
        accessoryView.addSubview(okButton)
        accessoryView.addSubview(title)
        accessoryView.addSubview(cancelButton)
        
        return accessoryView
    }
    
    func setAccessoryName(mode: UIDatePickerMode) -> String {
        
        if mode == .date {
            return "Дата"
        } else { return "Время" }
    }
    
    @objc func cancelButtonAction() {
        hideKeyboards()
    }
    
    @objc func selectButtonAction() {
        
        if activeField == dateTextField {
            dateTextField.text = currentSelectedDate
        } else if activeField == endTimeTextField {
            endTimeTextField.text = currentSelectedDate
        } else if activeField == startTimeTextField {
            startTimeTextField.text = currentSelectedDate
        }
        
        /*if activeField == districtTextField {
            districtTextField.text = pickerData[pickerSelectedIndex]
            streetTextField.text = ""
        } else if activeField == streetTextField {
            streetTextField.text = pickerData[pickerSelectedIndex]
        } else if activeField == derectionAppealTextField {
            derectionAppealTextField.text = pickerData[pickerSelectedIndex]
            eventTypeTextField.text = ""
        } else if activeField == eventTypeTextField {
            eventTypeTextField.text = pickerData[pickerSelectedIndex]
        } else if activeField == appealTypeTextField {
            appealTypeTextField.text = pickerData[pickerSelectedIndex]
        }*/
        
        hideKeyboards()
    }
    
    func hideKeyboards() {
        
        dateTextField.resignFirstResponder()
        endTimeTextField.resignFirstResponder()
        startTimeTextField.resignFirstResponder()
    }
    
    func setupTextFields() {
        
        dateTextField.inputView = createDatePickerView(mode: .date)
        dateTextField.inputAccessoryView = createAccessoryView(mode: .date)
        
        endTimeTextField.inputView = createDatePickerView(mode: .time)
        endTimeTextField.inputAccessoryView = createAccessoryView(mode: .date)
        
        startTimeTextField.inputView = createDatePickerView(mode: .time)
        startTimeTextField.inputAccessoryView = createAccessoryView(mode: .time)
    }
    
    func getCorrectDate(date: Date, mode: UIDatePickerMode) -> String {
        
        let dateFormatter = DateFormatter()
        
        if mode == .date {
            dateFormatter.dateFormat = "MMMM dd, yyyy"
        } else { dateFormatter.dateFormat = "HH:mm" }
        
        return dateFormatter.string(from: date)
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

extension AddActivityVC: OMSwitchDelegate {
    
    func omSwitchValueDidChange(_ omSwitch: OMSwitch) {
    }
}

extension AddActivityVC: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
}

