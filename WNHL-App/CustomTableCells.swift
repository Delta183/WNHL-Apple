//
//  ScheduleTableViewCell.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-24.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var HomeImage: UIImageView!
    @IBOutlet weak var AwayImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class TeamTableViewCell: UITableViewCell{
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var chevronImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class MoreTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var moreTextLabel: UILabel!
    @IBOutlet weak var chevronImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class PlayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerText: UILabel!
    @IBOutlet weak var chevronImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class NotificationTableViewCell: UITableViewCell{
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var teamLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class UpdateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var updateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class SingleTeamTableViewCell: UITableViewCell{
    
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var awayImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
