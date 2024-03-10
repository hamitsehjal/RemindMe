//
//  ReminderViewController.swift
//  Reminder App
//
//  Created by Hamit Sehjal on 2024-03-07.
//

import UIKit

class ReminderViewController: UITableViewController {
    var reminderList:ReminderList!
    
    // helper function to format date
    let dateFormatter:DateFormatter={
        let formatter=DateFormatter()
        formatter.dateFormat="MMMM d, yyyy 'at' h:mm a"
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        reminderList.sortReminders()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return reminderList.listOfReminders.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Extract the section name from sectionOrder array
        let sectioinKey=reminderList.sectionOrder[section]
        

        return reminderList.listOfReminders[sectioinKey]?.count ?? 0
    }
    
//     customize the title view for each section's header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerViewHeight:CGFloat=40
        let headerViewWidth:CGFloat=tableView.bounds.width // same a tableview
        let padding:CGFloat=10
        // Create an UIView instance
        let headerView=UIView(frame: CGRect(x: 0, y: 0, width: headerViewWidth, height: headerViewHeight))
        
        // set the background to light text
        headerView.backgroundColor = .lightText
        
        // Create a label instance with appropriate padding relative to HeaderView
        let titleLabel=UILabel(frame: CGRect(x: 10, y: 0, width: headerViewWidth-2*padding, height: headerViewHeight-2*padding))
        
        // set the label's font style and size
        titleLabel.font=UIFont(name: "Kohinoor Bangla", size: 16)
        
        // set the labe's font color
        titleLabel.textColor = .black
        
        // Extract the section title
        let sectionTitle=reminderList.sectionOrder[section].capitalized
        titleLabel.text=sectionTitle.uppercased()
        
        // add the title label(UILabel) to header view (UIView)
        headerView.addSubview(titleLabel)

        return headerView
    }
    
    // height for each section's footer
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40.0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)


        // Extract the section Key from sectionOrder using indexPath.section
        let sectionKey=reminderList.sectionOrder[indexPath.section]
        
        // extract the section items from reminder's list using sectionKey
        let sectionReminders=reminderList.listOfReminders[sectionKey]!
        
        let reminder=sectionReminders[indexPath.row]
       
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text="\(reminder.title)"
        let formattedDate=dateFormatter.string(from: reminder.reminderDate)
        cell.detailTextLabel?.text=formattedDate

        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    // Delete a row by Swiping from right to left
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // UIContextualAction - actions such as swipe actions in table view
        let deleteAction=UIContextualAction(style: .destructive, title: "Delete"){
            (action,view,completionHandler) in
            
            // logic to delete the row
            // Extract the item associated with the given row
            let sectionKey=self.reminderList.sectionOrder[indexPath.section]
            let allReminders=self.reminderList.listOfReminders[sectionKey]!
            
            let reminderToDelete=allReminders[indexPath.row]
            
            // Remove the reminder from the Data Source
            self.reminderList.removeReminder(reminder: reminderToDelete, sectionIndex: indexPath.section)
            // Remove the row from table view with an animation
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            completionHandler(true)
        }
        
        // Configure UISwipeActionsConfiguration Object by passing in an array of UIContextualAction object
        print("Delete pressed")
        let swipeConfigurations=UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfigurations
        
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    @IBAction func myUnwindAction(unwindSegue:UIStoryboardSegue){
        print("Unwind Segue to ReminderViewController")
        print("Reloading table date in ReminderViewController")
//        reminderList.sortReminders()
        tableView.reloadData()
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        switch segue.identifier{
//        case "showReminder":
//            // Figure out which row was tapped
//            if let row=tableView.indexPathForSelectedRow?.row{
//                // Get the item associated with the row
//                let reminder=reminderList.listOfReminders[row]
//                let navController=segue.destination as! UINavigationController
//                let detailController=navController.topViewController as! DetailViewController
//                detailController.reminder=reminder
//            }
//        case "addReminder":
//            // Create a new instance of Reminder object
//            
//            // Generate a random uuid and convert it to string
//            let randomId=UUID().uuidString.components(separatedBy: "-").first!
//
//            let newReminder=Reminder(title: "Submit Assignment", description: "iOS Development Midterm Due", id: randomId, reminderDate: Date())
//            let navController=segue.destination as! UINavigationController
//            let detailController=navController.topViewController as! DetailViewController
//            detailController.reminder=newReminder
//            detailController.reminderList=reminderList
//            
//        default: preconditionFailure("Unexpected Segue Failure")
//        }
    }
    

}
