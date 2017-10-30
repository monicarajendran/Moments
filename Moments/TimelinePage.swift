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
    
    var getTheMomentObject = Moment()
    
    var filteredObjects = Table<Moment>(context: container.viewContext)
    
    lazy var fetchTheMoments : FetchRequestController<Moment> = {
        
        let sortDescriptorss = NSSortDescriptor(key: "name", ascending: false)
        
        let query = container.viewContext.moment.sort(using: [sortDescriptorss])
        
        return query.toFetchRequestController()
        
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        
        timelineSearchBar.delegate = self
        
        self.queryTheDataFromDisk()
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        if fetchTheMoments.fetchedObjects?.count == 0 {
            

          let obj = container.viewContext.moment.create().fromICloudRecord()
            
            getTheMomentObject = obj
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.topItem?.title = "Moments"
        noResultsFound.isHidden = true
        self.tableView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        
        filteredObjects = container.viewContext.moment.filter(using: searchPredicate)
        
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
        
        guard let addMomentsPage = storyboard?.instantiateViewController(withIdentifier: "AddMomentsPage")
            
            else{
                
                return
        }
        
        navigationController?.present(addMomentsPage, animated: true)
        
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
            
        else{
            
            return fetchTheMoments.sections[section].numberOfObjects
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        if searchBarActive {
            
            getTheMomentObject = filteredObjects.execute()[indexPath.row]
        }
        else{
            
            getTheMomentObject = fetchTheMoments.object(at: indexPath)
        }
        if (filteredObjects.count() == 0 && !searchBarText.isEmpty) {
            
            cell.isHidden = true
            noResultsFound.isHidden = false
        }
            
        else {
            
            noResultsFound.isHidden = true
        }
        
        cell.textLabel?.text = getTheMomentObject.name
        
        let timeAsSeconds = getTheMomentObject.momentTime / 1000
        
        let date = Date(timeIntervalSince1970: TimeInterval(timeAsSeconds))
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .long
        
        cell.detailTextLabel?.text = dateFormatter.string(from: date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        timelineSearchBar.resignFirstResponder()
        
        guard let pushToDetailMomentPage = storyboard?.instantiateViewController(withIdentifier: "MomentsDetailPage")  as? MomentsDetailPage else {   return  }
        
        if searchBarActive{
            
            getTheMomentObject = filteredObjects.execute()[indexPath.row]
        }
        else{
            
            getTheMomentObject = fetchTheMoments.object(at: indexPath)
        }
        pushToDetailMomentPage.momentNameFromDb = getTheMomentObject.name!
        
        pushToDetailMomentPage.momentDateFromDb = getTheMomentObject.name!
        
        pushToDetailMomentPage.momentDescriptionFromDb = getTheMomentObject.desc!
        
        navigationController?.pushViewController(pushToDetailMomentPage, animated: true)
    }
    
}



