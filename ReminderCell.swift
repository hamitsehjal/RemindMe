//
//  ReminderCell.swift
//  Reminder App
//
//  Created by Hamit Sehjal on 2024-03-11.
//

import UIKit

class ReminderCell: UITableViewCell {

    @IBOutlet weak var reminderTitleLabel: UILabel!
    @IBOutlet weak var reminderDateLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reminderDateLabel.font=UIFont.italicSystemFont(ofSize: 20.0)
        setUpCheckmark()
    }


    
    /**
     Configure the  Checkmark for the Table View cell
     */
    private func setUpCheckmark(){
        // set up the initial Checkmark image
        checkmarkImageView.image=UIImage(systemName: "circle")
        
        // Add the tap gesture to the checkmark view
        
        // Create a Tap Gesture
        let tapGesture=UITapGestureRecognizer(target: self, action: #selector(checkmarkTapped))
        
        // Add the tap Gestureto the image view
        checkmarkImageView.addGestureRecognizer(tapGesture)
        checkmarkImageView.isUserInteractionEnabled=true
    }

    @objc private func checkmarkTapped(){
        // toggle the checkmark
        toggleCheckmark()
    }
    
    func toggleCheckmark(){
        // toggle the checkmark image
        if checkmarkImageView.image==UIImage(systemName: "circle"){
            // change the image to filled circle
            checkmarkImageView.image=UIImage(systemName: "checkmark.circle.fill")
        
            // setting the background to gray
            contentView.backgroundColor=UIColor.lightGray
            
            // add strikethrough to the title label
            applyStrikeThrough(to: reminderTitleLabel)
            
        }else{
            checkmarkImageView.image=UIImage(systemName: "circle")
            // setting the background to default
            contentView.backgroundColor=UIColor.white
            // remove strikethrough from the title label
            removeStrikeThrough(from: reminderTitleLabel)
        }
    }
    
    // apply strikethrough to label
    private func applyStrikeThrough(to label:UILabel){
        
        // create a attribute string property with strikethrough attribute and add it to the label's attributed text property
        let attributedString=NSMutableAttributedString(string: reminderTitleLabel.text ?? "")
        
        // add the style for strikethrough
        attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributedString.length))
        
        // add the red color to strikethrough
        attributedString.addAttribute(.strikethroughColor, value: UIColor.red, range: NSMakeRange(0, attributedString.length))
        label.attributedText=attributedString
    }
    
    
    // remove strikethrough from a label
    private func removeStrikeThrough(from label:UILabel){
        
        // creates an empty attribute string property and assign to the label's attributedText property
        let attributedString=NSMutableAttributedString(string: label.text ?? "")
        
        label.attributedText=attributedString
    }
}
