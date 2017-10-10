//
//  TimelinePage.swift
//  Moments
//
//  Created by user on 17/07/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import UIKit
import AlecrimCoreData

class TimelinePage: UITableViewController {

    lazy var fetchTheEvents : FetchRequestController<Events> = {
        
        let sortDescriptorss = NSSortDescriptor(key: "eventName", ascending: true)
        
        let query = container.viewContext.event.sort(using: [sortDescriptorss])
        
        return query.toFetchRequestController()
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            
            try fetchTheEvents.performFetch()
            
        }
        catch{
            
        }

    }
    override func viewWillAppear(_ animated: Bool) {

        tableView.reloadData()
        
    }
    
    @IBAction func addMomentsButton(_ sender: Any) {
        
        guard let addMomentsPage = storyboard?.instantiateViewController(withIdentifier: "AddMomentsPage")
            
            else{
                
                return
        }
        navigationController?.present(addMomentsPage, animated: true)
        
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.fetchTheEvents.numberOfSections()
        //number of  entities 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return fetchTheEvents.numberOfObjects(inSection: section)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let getTheEventObject = fetchTheEvents.object(at: indexPath)
        
        cell.textLabel?.text = getTheEventObject.eventName
        
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
