//
//  TimelinePage.swift
//  Moments
//
//  Created by user on 17/07/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import UIKit

import AlecrimCoreData

class TimelinePage: UITableViewController , UISearchBarDelegate , UITextViewDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchBarActive = false
    
    var getTheMomentObject = Moments()

    var filteredObjects = Table<Moments>(context: container.viewContext)
    
    lazy var fetchTheMoments : FetchRequestController<Moments> = {
        
        let sortDescriptorss = NSSortDescriptor(key: "dateAdded", ascending: false)
        
        let query = container.viewContext.moment.sort(using: [sortDescriptorss])
        
        return query.toFetchRequestController()
        
    }()

    override func viewDidLoad() {

        super.viewDidLoad()
        
        searchBar.delegate = self
        
        self.queryTheDataFromDisk()
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        /*
         
         if string is kind of number 
         check for date, month, year
         
         if string is kind of letters,
         then monthname, momentName
         
         */
        
        
        print("entered search bar")
        
    let searchPredicate = NSPredicate(format: "momentName CONTAINS[c] %@", searchText)
        
       filteredObjects = container.viewContext.moment.filter(using: searchPredicate)
        
        print(searchText)
        
        print("fetched objects: \(filteredObjects.count())")
        
        if filteredObjects.count() == 0 {
            searchBarActive = false
        }
        else{
            searchBarActive = true
        }
        
        tableView.reloadData()

    }
    
    func queryTheDataFromDisk() {
        
        do {
            try fetchTheMoments.performFetch()
        }
        catch{
            
            print("error occured")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.topItem?.title = "Moments"
        
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
       @IBAction func addMomentsButton(_ sender: UIBarButtonItem) {
        
        guard let addMomentsPage = storyboard?.instantiateViewController(withIdentifier: "AddMomentsPage")
            
            else{
                
                return
        }
        
        navigationController?.present(addMomentsPage, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if searchBarActive{
            
            return 1
        }
        else {
            
            return self.fetchTheMoments.numberOfSections()

        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchBarActive {

        return filteredObjects.execute().count
            
        }
            
        else{
            return fetchTheMoments.sections[section].numberOfObjects
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        if searchBarActive{
            getTheMomentObject = filteredObjects.execute()[indexPath.row]
        }
        else{
         getTheMomentObject = fetchTheMoments.object(at: indexPath)
        }
        
        cell.textLabel?.text = getTheMomentObject.momentName
        
        cell.detailTextLabel?.text = getTheMomentObject.rawDateOfTheMoment
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let pushToDetailMomentPage = storyboard?.instantiateViewController(withIdentifier: "MomentsDetailPage") as? MomentsDetailPage  else {   return  }
        
        pushToDetailMomentPage.momentNameFromDb = getTheMomentObject.momentName!
        
        pushToDetailMomentPage.momentDateFromDb = getTheMomentObject.rawDateOfTheMoment!
        
        pushToDetailMomentPage.momentDescriptionFromDb = getTheMomentObject.momentDescription!
        
        navigationController?.pushViewController(pushToDetailMomentPage, animated: true)
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
