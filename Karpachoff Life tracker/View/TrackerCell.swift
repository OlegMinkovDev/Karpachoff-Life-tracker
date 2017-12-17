//
//  TrackerCell.swift
//  Karpachoff Life tracker
//
//  Created by Oleg Minkov on 09/12/2017.
//  Copyright © 2017 Oleg Minkov. All rights reserved.
//

import UIKit

protocol TrackerCellDelegate {
    func cellTouchesBegan(cell: TrackerCell, x: CGFloat, y: CGFloat)
}

class TrackerCell: UITableViewCell {
    
    var delegate: TrackerCellDelegate? = nil
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var subActivityLabel: UILabel!
    
    func setTimeLabel(y: CGFloat) {
        let frame = CGRect(x: 8, y: y - 7.5, width: 15, height: 15)
        
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "circle")
        
        addSubview(imageView)
        
        /*let timeLabel = UILabel(frame: CGRect(x: 20, y: CGFloat(activity.position.minutes) - 8, width: 80, height: 16))
        timeLabel.text = activity.time
        
        addSubview(timeLabel)*/
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        timeLabel.isHidden = true
        activityLabel.isHidden = true
        subActivityLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        
        delegate?.cellTouchesBegan(cell: self, x: (location?.x)!, y: (location?.y)!)
    }
}
