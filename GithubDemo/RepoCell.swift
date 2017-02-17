//
//  RepoCell.swift
//  GithubDemo
//
//  Created by Ulric Ye on 2/16/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {
    @IBOutlet weak var repoImageView: UIImageView!

    @IBOutlet weak var repoTitle: UILabel!
    @IBOutlet weak var repoAuthor: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var repoStars: UILabel!
    @IBOutlet weak var repoForks: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
