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
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reminderList.sortReminders()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reminderList.listOfReminders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)

        // Extract the reminder from the list
        let reminder=reminderList.listOfReminders[indexPath.row]
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
        reminderList.sortReminders()
        tableView.reloadData()
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier{
        case "showReminder":
            // Figure out which row was tapped
            if let row=tableView.indexPathForSelectedRow?.row{
                // Get the item associated with the row
                let reminder=reminderList.listOfReminders[row]
                let navController=segue.destination as! UINavigationController
                let detailController=navController.topViewController as! DetailViewController
                detailController.reminder=reminder
            }
        case "addReminder":
            // Create a new instance of Reminder object
            
            // Generate a random uuid and convert it to string
            let randomId=UUID().uuidString.components(separatedBy: "-").first!

            let newReminder=Reminder(title: "Submit Assignment", description: "iOS Development Midterm Due", id: randomId, reminderDate: Date())
            let navController=segue.destination as! UINavigationController
            let detailController=navController.topViewController as! DetailViewController
            detailController.reminder=newReminder
            detailController.reminderList=reminderList
            
        default: preconditionFailure("Unexpected Segue Failure")
        }
    }
    

}
