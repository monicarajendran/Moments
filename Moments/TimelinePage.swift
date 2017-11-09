//
//  TimeLinePage2.swift
//  Moments
//
//  Created by user on 02/08/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//


import UIKit

import AlecrimCoreData

class TimeLinePage: UIViewController , UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate{
    
    @IBOutlet weak var timelineSearchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noResultsFound: UILabel!
    
    var searchBarActive = false
        
    var searchBarText = String()
        
    var filteredObjects = Table<Moment>(context: container.viewContext)
    
    lazy var fetchTheMoments : FetchRequestController<Moment> = {
        
        let sortDescriptorss = NSSortDescriptor(key: "momentTime", ascending: false)
        
        let query = container.viewContext.moment.sort(using: [sortDescriptorss])
        
        return query.toFetchRequestController()
        
    }()
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .long
        
        tableView.delegate = self
        
        timelineSearchBar.delegate = self
        
        self.queryTheDataFromDisk()
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        //to remove the bottom and top line of the search bar
        timelineSearchBar.backgroundImage = UIImage()
        
        
        //print(CloudSyncServices.fetchRecordFromICloud(record: moment.toICloudRecord()))

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.topItem?.title = "Moments"
        noResultsFound.isHidden = true
        
        self.tableView.reloadData()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        timelineSearchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        /*
         
         if string is kind of number
         check for date, month, year
         
         if string is kind of letters,
         then monthname, momentName
         
         */
        
        print("entered search bar")
        
        
        let searchPredicate = NSPredicate(format: "searchToken CONTAINS[c] %@",searchText)
        
        filteredObjects = container.viewContext.moment.filter(using: searchPredicate).sort(using: NSSortDescriptor(key: "createdAt", ascending: false))
        
        print(searchText)
        
        searchBarText = searchText
        
        print("fetched objects: \(filteredObjects.count())")
        
        if filteredObjects.count() == 0 {
            
            searchBarActive = false
            
        }
        else{
            
            self.tableView.backgroundView = .none
            
            searchBarActive = true
        }
        
        self.tableView.reloadData()
        
    }
    
    func queryTheDataFromDisk() {
        
        do {
            try fetchTheMoments.performFetch()
        }
        catch{
            
            print("error occured")
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        searchBarText = ""
        searchBar.text = nil
        
        searchBarActive = false
        searchBar.setShowsCancelButton(false, animated: true)
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    @IBAction func addMomentsButton(_ sender: UIBarButtonItem) {
        
        guard let newMomentsPage = storyboard?.instantiateViewController(withIdentifier: "NewMomentsPageViewController") as? NewMomentsPageViewController
            
            else{
                
                return
        }
        
        let navController = UINavigationController(rootViewController: newMomentsPage)
        
        self.present(navController, animated:true, completion: nil)


        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if searchBarActive{
            
            return 1
        }
        else {
            
            return self.fetchTheMoments.numberOfSections()
            
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchBarActive {
            
            return filteredObjects.execute().count
            
        }
            
        else {
            
            return fetchTheMoments.sections[section].numberOfObjects
            
        }
       
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! MomentsTableViewCell
        
        if searchBarActive {
            
            getTheMomentObject = filteredObjects.execute()[indexPath.row]
        }
        else {
            
            getTheMomentObject = fetchTheMoments.object(at: indexPath)
        }
      
        if (filteredObjects.count() == 0 && !searchBarText.isEmpty) {
            
            cell.isHidden = true
            noResultsFound.isHidden = false
        }
            
        else {
            
            noResultsFound.isHidden = true
        }
        
        cell.momentName.text = getTheMomentObject.name
        
        cell.momentDescription.text = getTheMomentObject.desc
        
        cell.date.text = "\(String(format: "%02d", getTheMomentObject.day))"
        
        if let color = getTheMomentObject.color
        {
            
          
            cell.viewForCell.backgroundColor = MomentColors(rawValue: color)?.uicolor()
            cell.viewForDate.backgroundColor = MomentColors(rawValue: color)?.uicolor()
        }
        
        let timeAsSeconds = getTheMomentObject.momentTime
        
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(timeAsSeconds))
        
        dateFormatter.dateFormat = "EEE"
        
        cell.day.text = dateFormatter.string(from: date).uppercased()
        
        cell.viewForCell.layer.cornerRadius = 5
        
        dateFormatter.dateFormat = "MMMM yyyy"
        
        cell.cellHeader.text = dateFormatter.string(from: date)
        
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        timelineSearchBar.resignFirstResponder()
        
        guard let pushToDetailMomentPage = storyboard?.instantiateViewController(withIdentifier: "NewMomentsPageViewController")  as? NewMomentsPageViewController else {   return  }
                
        navigationController?.pushViewController(pushToDetailMomentPage, animated: true)
    }
    
}



