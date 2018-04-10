//
//  TimeLinePage2.swift
//  Moments
//
//  Created by user on 02/08/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//


import UIKit

import AlecrimCoreData

import Firebase

class MomentsTimeLinePage: UIViewController , UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate{
    
    @IBOutlet weak var timelineSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noResultsFound: UILabel!
    @IBOutlet weak var addButtonOutlet: UIButton!
    
    var searchBarActive = false
    var searchBarText = ""
    var momentObject : Moment?
    var filteredObjects = Table<Moment>(context: container.viewContext)
    
    lazy var fetchTheMoments : FetchRequestController<Moment> = {
        
        let sortByTime = NSSortDescriptor(key: "momentTime", ascending: false)
        let sortByDate = NSSortDescriptor(key: "momentDate", ascending: false)
        
        let query = container.viewContext.moment.sort(using: [sortByDate, sortByTime])
        return query.toFetchRequestController(sectionNameKeyPath: "momentDate", cacheName: nil)
        
    }()
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(true, forKey: "firstRun")
        UserDefaults.standard.synchronize()
        
        addButtonShadow()
        dateFormatter.dateStyle = .long
        
        tableView.delegate = self
        timelineSearchBar.delegate = self
        
        self.queryTheDataFromDisk()
        
        tableView.tableFooterView = UIView(frame: .zero)
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        //to remove the bottom and top line of the search bar
        timelineSearchBar.backgroundImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.shared.statusBarStyle = .default
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = "Moments"
        noResultsFound.isHidden = true
        self.tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timelineSearchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        Analytics.logEvent("moment_search", parameters: ["search_word": searchBar.text ?? ""])
        
        let searchPredicate = NSPredicate(format: "searchToken CONTAINS[c] %@",searchText)
        filteredObjects = container.viewContext.moment.filter(using: searchPredicate).sort(using: NSSortDescriptor(key: "createdAt", ascending: false))
        
        searchBarText = searchText
        
        if filteredObjects.count() == 0 {
            searchBarActive = false
        } else{
            self.tableView.backgroundView = .none
            searchBarActive = true
        }
        self.tableView.reloadData()
    }
    
    func queryTheDataFromDisk() {
        
        do {
            try fetchTheMoments.performFetch()
        } catch{
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
    
    func addButtonShadow() {
        
        let buttonLayer = addButtonOutlet.layer
        buttonLayer.cornerRadius = addButtonOutlet.frame.height / 2
        buttonLayer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        buttonLayer.shadowOffset = CGSize(width: 0, height: 1)
        buttonLayer.shadowRadius = 5
        buttonLayer.shadowOpacity = 0.7
        buttonLayer.masksToBounds = false
    }
    
    @IBAction func addNewMoment(_ sender: UIButton) {
        
        guard let createMomentsVC = R.storyboard.main.createMomentsViewController() else {
            return
        }
        let navController = UINavigationController(rootViewController: createMomentsVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if searchBarActive{
            return 1
        } else {
            return self.fetchTheMoments.numberOfSections()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = fetchTheMoments.sections[section]
        return section.name
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        view.backgroundColor = .clear

        let dateFormater = DateFormatter()
        dateFormater.dateFormat = MomentDateFormat.monthAndYear.rawValue
        
        let label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.text = dateFormater.string(from: momentObject?.momentDate ?? Date())
        label.frame = CGRect(x: 20, y: 15, width: tableView.frame.width, height: 30)
        
        //Section headers will now scroll 
        self.tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0)
        view.addSubview(label)

        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchBarActive {
            return filteredObjects.execute().count
        } else {
            return fetchTheMoments.sections[section].numberOfObjects
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! MomentsTableViewCell
        
        if searchBarActive {
            momentObject = filteredObjects.execute()[indexPath.row]
        } else {
            momentObject = fetchTheMoments.object(at: indexPath)
        }
        
        if (filteredObjects.count() == 0 && !searchBarText.isEmpty) {
            cell.isHidden = true
            noResultsFound.isHidden = false
        } else {
            noResultsFound.isHidden = true
        }
        
        cell.momentName.text = momentObject?.name
        cell.momentDescription.text = momentObject?.desc
        cell.date.text = "\(String(format: "%02d", momentObject?.day ?? 0))"
        
        if let color = momentObject?.color {
            cell.viewForCell.backgroundColor = UIColor(hexString: color)
            cell.viewForDate.backgroundColor = UIColor(hexString: color)
        }
        
        let timeAsSeconds = momentObject?.momentTime
        let date = Date(timeIntervalSince1970: TimeInterval(timeAsSeconds ?? 0))
        
        dateFormatter.dateFormat = MomentDateFormat.day.rawValue
        cell.day.text = dateFormatter.string(from: date).uppercased()
        cell.viewForCell.layer.cornerRadius = 5
        dateFormatter.dateFormat = MomentDateFormat.monthAndYear.rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        timelineSearchBar.resignFirstResponder()
        
        guard let detailsPageVc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        if searchBarActive{
            momentObject = filteredObjects.execute()[indexPath.row]
        } else{
            momentObject = fetchTheMoments.object(at: indexPath)
        }
        
        detailsPageVc.selectedMoment = momentObject
        navigationController?.pushViewController(detailsPageVc, animated: true)
    }
}
