//
//  SurveyView.swift
//  Nimble
//
//  Created by master on 10/5/17.
//  Copyright © 2017 neemo. All rights reserved.
//

import UIKit
import FSPagerView

protocol SurveyCellProtocol
{
    func surveyButtonDidPress()
}
class SurveyView: FSPagerViewCell
{

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bgImagView: UIImageView!
    var delegate : SurveyCellProtocol!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func surveyButtonDidPress(_ sender: Any) {
        self.delegate.surveyButtonDidPress()
    }
}
