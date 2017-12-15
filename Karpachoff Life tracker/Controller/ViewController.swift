//
//  ViewController.swift
//  Karpachoff Life tracker
//
//  Created by Oleg Minkov on 09/12/2017.
//  Copyright © 2017 Oleg Minkov. All rights reserved.
//

import UIKit
import JTAppleCalendar

class Activity {
    
    var time: String!
    var position: Time!
    
    init() {
        self.time = ""
        self.position = Time()
    }
}

struct Time {
    
    var hours: Int!
    var minutes: Int!
    
    init() {
        self.hours = 0
        self.minutes = 0
    }
}

class ViewController: UIViewController, TrackerCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var appleCalendarView: JTAppleCalendarView!
    @IBOutlet weak var monthYearLabel: UILabel!
    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    var dateFormatter = DateFormatter()
    var activities = [Activity]()
    var currentSelectedDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0 ..< 24 {
            activities.append(Activity())
        }
        
        // setup calendar spacing
        appleCalendarView.minimumLineSpacing = 0
        appleCalendarView.minimumInteritemSpacing = 0
        
        // setup labels
        setupDayAndWeekday(date: Date())
        appleCalendarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
        
        // select current date
        appleCalendarView.selectDates([Date()])
        currentSelectedDate = Date()
        
        // scroll to current date
        appleCalendarView.scrollToDate(Date(), triggerScrollToDateDelegate: false, animateScroll: false, preferredScrollPosition: nil, extraAddedOffset: 0)
    }
    
    // UIView Methods
    @IBAction func showMenuPress(_ sender: UIButton) {
    }
    
    @IBAction func showCalendarPress(_ sender: UIButton) {
        calendarView.isHidden = (calendarView.isHidden) ? false : true
    }
    
    @IBAction func nextDayPress(_ sender: UIButton) {
        let newDate = Calendar.current.date(byAdding: .day, value: 1, to: currentSelectedDate)!
        appleCalendarView.selectDates([newDate])
    }
    
    @IBAction func previousDayPress(_ sender: UIButton) {
        let newDate = Calendar.current.date(byAdding: .day, value: -1, to: currentSelectedDate)!
        appleCalendarView.selectDates([newDate])
    }
    
    
    
    
    
    func cellTouchesBegan(cell: TrackerCell, x: CGFloat, y: CGFloat) {
        print("\(cell.tag) hours \(Int(y)) minutes")
        
        let activity = Activity()
        var position = Time()
        position.hours = cell.tag
        position.minutes = Int(y)
        activity.position = position
        activity.time = "\(cell.tag):\(Int(y))"
        
        activities[cell.tag] = activity
        
        cell.setTimeLabel(activity: activity)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func handleCellSelected(cell: JTAppleCell?, cellState: CellState) {
        
        guard let validCell = cell as? CalendarCell else { return }
        
        if validCell.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    func handleCellTextColor(cell: JTAppleCell?, cellState: CellState) {
        
        guard let validCell = cell as? CalendarCell else { return }
        
        if cellState.dateBelongsTo == .thisMonth {
            validCell.numberLabel.textColor = .black
        } else {
            validCell.numberLabel.textColor = .gray
        }
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo?) {
        
        var date = Date()
        if let visibleDates = visibleDates {
            date = visibleDates.monthDates.first!.date
        }
        
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        
        monthYearLabel.text = dateFormatter.string(from: date).uppercased()
    }
    
    func setupDayAndWeekday(date: Date) {
        
        let weekday = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        dateFormatter.dateFormat = "dd"
        dayOfTheWeekLabel.text = weekday
        
        let currentNumber = Int(dateFormatter.string(from: date))!
        dayLabel.text = String(currentNumber)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackerCell") as! TrackerCell
        
        /*cell.selectionStyle = .none
        cell.delegate = self
        cell.tag = indexPath.row
        
        if activities.count > 0 {
            cell.setTimeLabel(activity: activities[indexPath.row])
        }*/
        
        /*cell.timeLabel.isHidden = false
         cell.activityLabel.isHidden = false
         cell.subActivityLabel.isHidden = false
         cell.timeLabel.text = activities?[indexPath.row]
         cell.activityLabel.text = activities?[indexPath.row]
         cell.subActivityLabel.text = activities?[indexPath.row]*/
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /*let alertController = UIAlertController(title: "\(indexPath.row)", message: "", preferredStyle: .alert)
         let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         alertController.addAction(alertAction)
         
         present(alertController, animated: true, completion: nil)*/
    }
}

extension ViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        
        let startDate = dateFormatter.date(from: "2017 11 01")!
        let endDate = dateFormatter.date(from: "2030 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: nil, calendar: Calendar.current, generateInDates: nil, generateOutDates: nil, firstDayOfWeek: .monday, hasStrictBoundaries: nil)
        
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell

        cell.numberLabel.text = cellState.text
        
        handleCellSelected(cell: cell, cellState: cellState)
        handleCellTextColor(cell: cell, cellState: cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        currentSelectedDate = date
        appleCalendarView.scrollToDate(date)
        
        handleCellSelected(cell: cell, cellState: cellState)
        setupDayAndWeekday(date: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
}

