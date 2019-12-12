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

var MOMENT_MODE: MomentMode = .create

enum MomentFilter: String {
    
    case day = "momentDate"
    case month = "momentMonth"
    case week = "momentWeek"
    case year = "momentYear"
}

class MomentsTimeLinePage: UIViewController , UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate, MomentDelegate {
    
    //@IBOutlet weak var timelineSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noResultsFound: UILabel!
    @IBOutlet weak var addButtonOutlet: UIButton!
    
    var searchBarActive = false
    var searchBarText = ""
    var momentObject : Moment?
    var filteredObjects = Table<Moment>(context: container.viewContext)
    var filterOption = MomentFilter.day
    
    let startButtonColour: UIColor = UIColor(hexString: "FD1C00")
    let endButtonColour: UIColor = UIColor(hexString: "FF4200")
    
    lazy var fetchTheMoments : FetchRequestController<Moment> = {
        
        let sortByTime = NSSortDescriptor(key: "momentTime", ascending: false)
        let sortByDate = NSSortDescriptor(key: "momentDate", ascending: false)
        
        let query = container.viewContext.moment.sort(using: [sortByTime, sortByDate])
        return query.toFetchRequestController(sectionNameKeyPath: "momentDate", cacheName: nil)
        
    }()
    
    var timelineSearchBar: UISearchBar!
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForPreviewing(with: self, sourceView: tableView)
        
        UserDefaults.standard.set(true, forKey: "firstRun")
        UserDefaults.standard.synchronize()
        addButtonShadow()
        
        dateFormatter.dateStyle = .long
        
        tableView.delegate = self
        self.queryTheDataFromDisk()
        
        configureSearch()
        
        //timelineSearchBar.delegate = self
        //self.automaticallyAdjustsScrollViewInsets = false
    
        tableView.tableFooterView = UIView(frame: .zero)
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        //to remove the bottom and top line of the search bar
        //timelineSearchBar.backgroundImage = UIImage()
    
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = UIRectEdge.bottom
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        navigationController?.view.backgroundColor = UIColor(rawRGBValue: 242, green: 242, blue: 247, alpha: 1)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
        } else {
            // Fallback on earlier versions
        }

        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = "Moments"
        
        noResultsFound.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
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
    
    func configureSearch() {
        
        let searchbar = UISearchBar()
        searchbar.delegate = self
        searchbar.showsCancelButton = false
        searchbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 55)
        searchbar.layer.position = CGPoint(x: self.view.bounds.width/2, y: 100)
        searchbar.searchBarStyle = .minimal
        searchbar.layer.borderWidth = 1
        searchbar.layer.borderColor = UIColor.clear.cgColor
        searchbar.setImage(UIImage(), for: .clear, state: .normal)
        searchbar.placeholder = "Search"
        //searchbar.tintColor = UIColor.groupTableViewBackground
        searchbar.backgroundImage = UIImage()
        self.timelineSearchBar = searchbar
        self.tableView.tableHeaderView = searchbar
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
        MOMENT_MODE = .create
        guard let createMomentsVC = R.storyboard.main.createMomentsViewController() else {
            return
        }
        createMomentsVC.momentDelegate = self
        let navController = UINavigationController(rootViewController: createMomentsVC)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    //Moment deelgate
    func createdMoment() {
        self.tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return searchBarActive ? 1 : self.fetchTheMoments.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = .clear
        
        let sectionHeader = self.fetchTheMoments.sections[section].name
        dateFormatter.dateFormat = MomentDateFormat.default.rawValue
        let date = dateFormatter.date(from: sectionHeader)
        
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 15, width: tableView.frame.width, height: 30)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        
            switch filterOption {
                
            case .day:
                dateFormatter.dateFormat = MomentDateFormat.dayMonthYear.rawValue
                label.text =  dateFormatter.string(from: date ?? Date())
                
            case .month:
                dateFormatter.dateFormat = MomentDateFormat.monthYear.rawValue
                label.text = dateFormatter.string(from: date ?? Date())
                
            case .week:
                let monthName = (date?.monthName ?? "")
                let weekFirstDay = String(describing: date?.startWeek.day ?? 00)
                let weekLastDay = String(describing: date?.endWeek.day ?? 00)
                label.text = monthName + " " + weekFirstDay + " - " + weekLastDay
                
            case .year:
                label.text = sectionHeader
                
            }
        
        view.addSubview(label)
        self.automaticallyAdjustsScrollViewInsets = false
        return view
    }
    
    //Section headers will now scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let sectionHeaderHeight: CGFloat = 50
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return filteredObjects.count() == 0 ? 0 : 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchBarActive ? filteredObjects.execute().count : fetchTheMoments.sections[section].numberOfObjects
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
        dateFormatter.dateFormat = MomentDateFormat.dayMonthYear.rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MOMENT_MODE = .create
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
        
        
//        guard let createMomentsVC = R.storyboard.main.createMomentsViewController() else {
//            return
//        }
//        let navController = UINavigationController(rootViewController: createMomentsVC)
//        self.present(navController, animated: true, completion: nil)
        
        navigationController?.pushViewController(detailsPageVc, animated: true)
    }
    
    func filter(by key: String) {
        
        filterOption = MomentFilter(rawValue: key)!
        
        let sortByFilter = NSSortDescriptor(key: key, ascending: false)
        let sortByTime = NSSortDescriptor(key: "momentTime", ascending: false)
        
        let query = container.viewContext.moment.sort(using: [sortByFilter, sortByTime])
        
        self.fetchTheMoments = query.toFetchRequestController(sectionNameKeyPath: key, cacheName: nil)
        
        try? self.fetchTheMoments.performFetch()
        try? container.viewContext.save()
        self.tableView.reloadData()
    }
    
    var dayName = "Day"
    var monthName = "Month"
    var weekName = "Week"
    var yearName = "Year"
    
    
    let groupByValues = ["Day", "Month", "Week", "Year"]
    
    @IBAction func filterAction(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Group By", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: dayName, style: .default, handler: { action in
            
            self.setTheCheckMark(groupBy: .day)
            self.filter(by: MomentFilter.day.rawValue) }))
        
        alert.addAction(UIAlertAction(title: monthName, style: .default, handler: { action in
            
            self.setTheCheckMark(groupBy: .month)
            self.filter(by: MomentFilter.month.rawValue) }
        ))
        
        alert.addAction(UIAlertAction(title: weekName, style: .default, handler: { action in
            self.setTheCheckMark(groupBy: .week)
            self.filter(by: MomentFilter.week.rawValue) }
        ))
        
        alert.addAction(UIAlertAction(title: yearName, style: .default, handler: { action in
            self.setTheCheckMark(groupBy: .year)
            self.filter(by: MomentFilter.year.rawValue) }
        ))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setTheCheckMark(groupBy: MomentFilter){
        
        switch groupBy {
        case .day:
            dayName = "Day ✔︎"
            monthName = "Month"
            weekName = "Week"
            yearName = "Year"
        case .month:
            dayName = "Day"
            monthName = "Month ✔︎"
            weekName = "Week"
            yearName = "Year"
            
        case .week:
            dayName = "Day"
            monthName = "Month"
            weekName = "Week ✔︎"
            yearName = "Year"
        case .year:
            dayName = "Day"
            monthName = "Month"
            weekName = "Week"
            yearName = "Year ✔︎"
        }
    }
}


extension MomentsTimeLinePage: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: location),
            let cell = tableView.cellForRow(at: indexPath) else {
                return nil }
        
        guard let detailViewController =
            storyboard?.instantiateViewController(
                withIdentifier: "DetailsViewController") as?
            DetailsViewController else { return nil }

        detailViewController.selectedMoment = fetchTheMoments.object(at: indexPath)
        
        return detailViewController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
    
}
