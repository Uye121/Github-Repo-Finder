//
//  SearchSettingsViewController.swift
//  GithubDemo
//
//  Created by Ulric Ye on 3/2/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit


protocol SettingsPresentingViewControllerDelegate: class {
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}

class SearchSettingsViewController: UIViewController {
    
    weak var delegate: SettingsPresentingViewControllerDelegate?
    var settings: GithubRepoSearchSettings?

    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.value = (Float((settings?.minStars)!))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    

    
    @IBAction func saveButtonTapped(_ sender: Any) {
        var newSettings = settings
        newSettings?.minStars = Int(slider.value)
        print(newSettings?.searchString)
        starLabel.text = slider.value as? String
        
        delegate?.didSaveSettings(settings: newSettings!)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func starNumber(_ sender: Any) {
        starLabel.text = String(Int(slider.value))
        
    }

}
