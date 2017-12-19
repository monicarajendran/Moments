////
////  ActionSheetDatePicker.swift
////  Moments
////
////  Created by user on 16/12/17.
////  Copyright © 2017 user. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//// Compatible with iOS 7 and iOS 8 both
//
//extension NewMomentsPageViewController{
//
//override func viewDidLoad()
//{
//    super.viewDidLoad()
//}
//
//
//
////--- *** ---//
//
//func createDatePickerViewWithAlertController()
//{
//    var viewDatePicker: UIView = UIView(frame: CGRect(0, 0, self.view.frame.size.width, 200))
//    viewDatePicker.backgroundColor = UIColor.clear
//    
//    
//    self.datePicker = UIDatePicker(frame: CGRect(0, 0, self.view.frame.size.width, 200))
//    self.datePicker.datePickerMode = UIDatePickerMode.dateAndTime
//    self.datePicker.addTarget(self, action: Selector("datePickerSelected"), for: UIControlEvents.valueChanged)
//    
//    viewDatePicker.addSubview(self.datePicker)
//    
//    
//    if(UIDevice.current.systemVersion >= "8.0")
//    {
//        
//        let alertController = UIAlertController(title: nil, message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: UIAlertControllerStyle.actionSheet)
//        
//        alertController.view.addSubview(viewDatePicker)
//        
//        
//        
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        { (action) in
//            // ...
//        }
//        
//        alertController.addAction(cancelAction)
//        
//        let OKAction = UIAlertAction(title: "Done", style: .default)
//        { (action) in
//            
//            self.dateSelected()
//        }
//        
//        alertController.addAction(OKAction)
//        
//        /*
//         let destroyAction = UIAlertAction(title: "Destroy", style: .Destructive)
//         { (action) in
//         println(action)
//         }
//         alertController.addAction(destroyAction)
//         */
//        
//        self.present(alertController, animated: true)
//        {
//            // ...
//        }
//        
//    }
//    else
//    {
//        let actionSheet = UIActionSheet(title: "\n\n\n\n\n\n\n\n\n\n", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: "Done")
//        actionSheet.addSubview(viewDatePicker)
//        actionSheet.showInView(self.view)
//    }
//    
//}
//
//
//func dateSelected()
//{
//    var selectedDate: String = String()
//    
//    selectedDate =  self.dateformatterDateTime(date: self.datePicker.date as NSDate)
//    
//    self.textFieldFromDate.text =  selectedDate
//    
//}
//
//
//func dateformatterDateTime(date: NSDate) -> NSString
//{
//    let dateFormatter: DateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "MM-dd-yyyy h:mm a"
//    return dateFormatter.string(from: date as Date) as NSString
//}
//
//
//
//
//
//// Now Implement UIActionSheet Delegate Method just for support for iOS 7 not for iOS 8
//
//// MARK: - UIActionSheet Delegate Implementation ::
//
//func actionSheet(actionSheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int)
//{
//    switch buttonIndex
//    {
//        
//    case 0:
//        print("Done")
//        self.dateSelected()
//        break;
//    case 1:
//        print("Cancel")
//        break;
//    default:
//        print("Default")
//        break;
//    }
//}
//}

