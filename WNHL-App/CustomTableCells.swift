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
    @IBOutlet weak var scheduleText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class TeamTableViewCell: UITableViewCell{
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var chevronImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class PlayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerText: UILabel!
    @IBOutlet weak var chevronImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
