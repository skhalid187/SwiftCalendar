//
//  CalendarViewController.swift
//  Catch App
//
//  Created by Salman Khalid on 05/09/2016.
//  Copyright © 2016 Salman Khalid. All rights reserved.
//

import Foundation
import UIKit


class CalendarViewController:UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIPickerViewDataSource, UIPickerViewDelegate {
    
    let monthsArray:[String] = ["January","February","March","April","May","June","July","August","September","October","November","December"];
    
    let yearsArray:[String] = ["1980","1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var calendarPicker: UIPickerView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var showPickerBtn: UIButton!
    
    var componentsCalculation:NSDateComponents?
    var selectedComponents:NSDateComponents?
    
    var days:NSRange?
    
    var gregorian: NSCalendar?
    var dayInfoUnits:NSCalendar.Unit?
    var weekDayNames:[String]?
    var df:DateFormatter?
    var currentCalendarDate:NSDate?
    var selectedIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.collectionView.register(UINib(nibName: "CalenderViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        gregorian = NSCalendar.init(identifier: NSCalendar.Identifier.gregorian)
        dayInfoUnits = [NSCalendar.Unit.era , NSCalendar.Unit.year , NSCalendar.Unit.month , NSCalendar.Unit.day , NSCalendar.Unit.weekday];
        
        let shortWeekdaySymbols:NSArray = DateFormatter.init().weekdaySymbols as NSArray
     
        weekDayNames = [shortWeekdaySymbols[0] as! String,shortWeekdaySymbols[1] as! String, shortWeekdaySymbols[2] as! String, shortWeekdaySymbols[3] as! String, shortWeekdaySymbols[4] as! String, shortWeekdaySymbols[5] as! String, shortWeekdaySymbols[6] as! String]
        
        df = DateFormatter.init()
        
        self.setCurrentCalendarDate1(_calendarDate: NSDate())

    }
    
    func setCurrentCalendarDate1(_calendarDate:NSDate) -> Void
    {
        currentCalendarDate = _calendarDate
        
        componentsCalculation = gregorian?.components(dayInfoUnits!, from: currentCalendarDate! as Date) as NSDateComponents?
        
        selectedComponents = gregorian?.components(dayInfoUnits!, from: currentCalendarDate! as Date) as NSDateComponents?
        
        days = gregorian?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: currentCalendarDate! as Date)
        
        let df:DateFormatter = DateFormatter.init();
        df.dateFormat = "MMMM yyyy"
        
        let finalStr:String = df.string(from: currentCalendarDate! as Date);
        
        showPickerBtn.setTitle(finalStr, for: UIControlState.normal)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.reloadData()
        
    }
    
    func getTextForDate(_date:NSDate) -> String{
        
        let tempComponents:NSDateComponents = (gregorian?.components(dayInfoUnits!, from: _date as Date))! as NSDateComponents
        
        let text = String(format: "%@ %ld, %@", weekDayNames![tempComponents.weekday-1],tempComponents.day,df!.monthSymbols[tempComponents.month-1])
        
        return text
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let returnSize:CGSize = CGSize(width:collectionView.frame.size.width/3.03,height:collectionView.frame.size.width/3.03);
        return returnSize;
    }
    
    
    // tell the collection view how many cells to make
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (days?.length)!;
    }
    
    
    // make a cell for each cell index path
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! CalenderViewCell
        
        
        cell.eventlbl.isHidden = false
        cell.firstImageView.isHidden = false
        cell.secondImageView.isHidden = false
        cell.thirdImageView.isHidden = false
        
        componentsCalculation!.day = indexPath.row+1;
        
        // static lbl
        cell.datelbl.text = self.getTextForDate(_date: (gregorian?.date(from: componentsCalculation! as DateComponents))! as NSDate)
        
        return cell
    }
    
    private func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        selectedIndex = indexPath.row
        selectedComponents!.day = indexPath.row+1;
        
    }
    
    // MARK: - UIPickerViewDelegate UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 2;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if(component == 0)
        {
            return monthsArray.count;
        }
        else if (component == 1)
        {
            return yearsArray.count;
        }
        
        return 0;
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if(component == 0)
        {
            return  monthsArray[row]
        }
        else
        {
            return yearsArray[row]
        }
    }
    
    @IBAction func showCalendarPicker(sender:AnyObject)
    {
        calendarView.isHidden = false;
        
    }
    
    @IBAction func cancelBtnAction(sender:AnyObject)
    {
        calendarView.isHidden = true
    }
    
    @IBAction func doneBtnAction(sender:AnyObject)
    {
        calendarView.isHidden = true
        
        var tempString:String = ""
        
        for i in 0 ... 1
        {
            let selectedRow:Int = calendarPicker.selectedRow(inComponent: i)
            
            let title:String = (calendarPicker.delegate?.pickerView!(calendarPicker, titleForRow: selectedRow, forComponent: i))!
            tempString += title
            
            if(i==0)
            {
                tempString += " "
            }
        }
        
        let pickerDF:DateFormatter = DateFormatter.init();
        pickerDF.dateFormat = "MMMM yyyy"
        
        let resultDate:NSDate = pickerDF.date(from: tempString)! as NSDate
        
        self.setCurrentCalendarDate1(_calendarDate: resultDate)
        
    }

    
}
