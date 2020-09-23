//
//  SimpleCalculatorViewController.swift
//  Spendee
//
//  Created by Siddharth on 7/29/19.
//  Copyright © 2019 TechnoPear. All rights reserved.
//

import UIKit
import Darwin

class SimpleCalculatorViewController: UIViewController {

    @IBOutlet weak var masterTable:UITableView!
    @IBOutlet weak var keyboardColl:UICollectionView!
    @IBOutlet weak var entryField:UILabel!
    @IBOutlet weak var keyboardView:UIView!
    @IBOutlet weak var entryView:UIView!
    @IBOutlet weak var lblTotal:UILabel!
    @IBOutlet weak var lblKeyboardTotal:UILabel!
    @IBOutlet weak var editOptionView:UIView!
    @IBOutlet weak var btnDone:UIButton!
    private var entryList:[Entry] = []
    private var isDarkModeSelected:Bool = false
    private var totalSum:String = "0"
    private var isKeyboardOpen:Bool = false
    private var isForEditing:Bool = false
    private var editingIndex:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        entryView.clipsToBounds = true
        entryView.layer.cornerRadius = 20
        entryView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        keyboardView.clipsToBounds = true
        keyboardView.layer.cornerRadius = 20
        keyboardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        keyboardColl.clipsToBounds = true
        keyboardColl.layer.cornerRadius = 20
        keyboardColl.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        initializeVC()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.closeKeyboardView()
    }
    
}
extension SimpleCalculatorViewController{
    @IBAction func btnMinusClicked(_ sender:UIButton){
        if entryField.text == "" || entryField.text == "0.00"{
            
        }else{
            if !(isForEditing){
                entryList.insert(Entry( amount: self.entryField.text!, operation: "-"), at: 0)
                self.entryField.text = ""
                self.calculateData()
                self.reloadMasterTable()
            }
            else{
                let editedEntry = Entry(amount: self.entryField.text!, operation: "-")
                entryList[editingIndex] = editedEntry
                self.calculateData()
                self.reloadMasterTable()
                self.isForEditing = false
                self.editOptionView.isHidden = true
                self.editOptionView.sendSubviewToBack(self.masterTable)
                self.initializeTextField()
                closeKeyboardView()
            }
        }
        
        
    }
    
    @IBAction func btnPlusClicked(_ sender:UIButton){
        if entryField.text == "" || entryField.text == "0.00"{
            
        }else{
            if !(isForEditing){
                entryList.insert(Entry( amount: self.entryField.text!, operation: "+"), at: 0)
                self.entryField.text = ""
                self.calculateData()
                self.reloadMasterTable()
            }else{
                let editedEntry = Entry(amount: self.entryField.text!, operation: "+")
                entryList[editingIndex] = editedEntry
                self.calculateData()
                self.reloadMasterTable()
                self.isForEditing = false
                self.editOptionView.isHidden = true
                self.editOptionView.sendSubviewToBack(self.masterTable)
                self.initializeTextField()
                closeKeyboardView()
            }
            
            //self.initializeTextField()
        }
        
        
    }
    
    @IBAction func btnDoneClicked(_ sender:UIButton){
        if isForEditing{
            self.editOptionView.isHidden = true
            self.editOptionView.sendSubviewToBack(masterTable)
            self.btnDone.setTitle("Done", for: .normal)
            self.isForEditing = false
        }
        self.calculateData()
        self.reloadMasterTable()
        self.initializeTextField()
        closeKeyboardView()
        
    }
    
    @IBAction func btnClearClicked(_ sender:UIButton){
        entryList = []
        self.calculateData()
        reloadMasterTable()
        self.initializeTextField()
        //closeKeyboardView()
    }
    
    @IBAction func btnCallKeyboard(_ sender:UIButton){
        self.openKeyboardView()
        self.entryField.text = ""
    }
}
extension SimpleCalculatorViewController{
    //math
    private func calculateTotal(value1:String,oper:String,value2:String) ->String{
        let val1 = value1.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range:nil)
        let val2 = value2.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range:nil)
        let finalVal2 = val2.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range: nil)
        let mathExpression = NSExpression(format: "\(val1)\(oper)\(finalVal2)")
        let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        guard  let value = formatter.string(from: NSNumber(value: mathValue!)) else {
            return "0"
        }
        return value
    }
    
    private func calculateData(){
        var tempTotal:String = "0"
        for entry in entryList{
            print("Value1:",tempTotal,"Operation",entry.Operation,"Value2",entry.Amount)
            tempTotal = calculateTotal(value1: tempTotal, oper: entry.Operation, value2: entry.Amount)
            print("--------Sum--------",tempTotal)
        }
        totalSum = tempTotal
        
        print("========TOTAL=========",totalSum)
        self.lblTotal.text = "\(Defaults.Total) \(Defaults.rupee)\(totalSum)"
        self.lblKeyboardTotal.text = "\(Defaults.Total) \(Defaults.rupee)\(totalSum)"
    }
}

extension SimpleCalculatorViewController{
    //Initaliztion
    func initializeVC(){
        self.editOptionView.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.lblTotal.text = "\(Defaults.Total) \(Defaults.rupee)0"
        self.lblKeyboardTotal.text = "\(Defaults.Total) \(Defaults.rupee)0"
        self.initializeTextField()
        self.registerTableCells()
        self.assignDelegate()
        self.assignDataSource()
        self.reloadMasterTable()
        self.reloadKeyboardTable()
        
    }
    //Register Table Cell
    func registerTableCells(){
        self.masterTable.register(UINib(nibName: "EntryTableViewCell", bundle: nil), forCellReuseIdentifier: "EntryTableViewCell")
        self.keyboardColl.register(UINib(nibName: "KeyboardCollCell", bundle: nil), forCellWithReuseIdentifier: "KeyboardCollCell")
    }
    
    //Master Table Delegate Assignment
    func assignDelegate(){
        self.masterTable.delegate = self
        self.keyboardColl.delegate = self
    }
    
    //Master Table DataSource Assignment
    func assignDataSource(){
        self.masterTable.dataSource = self
        self.keyboardColl.dataSource = self
        
    }
    
    //Reload Master Table
    func reloadMasterTable(){
        self.masterTable.reloadData()
        
    }
    func reloadKeyboardTable(){
        self.keyboardColl.reloadData()
    }
    //CloseKeyboard
    func closeKeyboardView(){
       
        UIView.animate(withDuration: 0.3, animations: {
             self.keyboardView.isHidden = true
            self.isKeyboardOpen = false
            
        }) { (true) in
           self.keyboardView.frame = CGRect(x: 0, y: Screen.screenHeight, width: Screen.screenWidth, height:Defaults.keyboardViewHeight)
        }
    }
    //OpenKeyboard
    func openKeyboardView(){
        if isKeyboardOpen{
            
        }
        else{
            UIView.animate(withDuration: 0.3, animations: {
                self.keyboardView.frame = CGRect(x: 0, y: (Screen.screenHeight - Defaults.keyboardViewHeight), width: Screen.screenWidth, height:Defaults.keyboardViewHeight)
            }) { (true) in
                self.keyboardView.isHidden = false
                self.isKeyboardOpen = true
                self.btnDone.setTitle(self.isForEditing ? "Cancel":"Done" , for: .normal)
                
            }
            
        }
        

    }
}
//MARK: TEXT FIELD METHOD
extension SimpleCalculatorViewController{
    
    func initializeTextField(){
        self.entryField.text = "0.00"
        self.entryField.textColor = #colorLiteral(red: 0.5843137255, green: 0.6862745098, blue: 0.7529411765, alpha: 1)
    }
    func updateLabel(value:String){
        var tempValue = entryField.text
        print("Before Update--------->>",tempValue)
        if value == "x"{
            if tempValue == ""{
                
            }else{
                tempValue?.removeLast()
            }
            //tempValue?.substring(to: tempValue!.index(before: tempValue!.endIndex))
            //tempValue?.dropLast()
            print("After Deletion--------->>",tempValue)
            //print(tempValue)
        }else{
            tempValue?.append(contentsOf: value)
            print("After Update--------->>",tempValue)
        }
        self.entryField.text = tempValue
        self.entryField.textColor = #colorLiteral(red: 0.3254901961, green: 0.3607843137, blue: 0.4078431373, alpha: 1)
    }
    
    func handleEdit(value:String){
        self.isForEditing = true
        self.btnDone.setTitle("Cancel", for: .normal)
        self.editOptionView.isHidden = false
        self.editOptionView.bringSubviewToFront(masterTable)
        self.openKeyboardView()
        self.entryField.text = value
    }
}

//MARK: TableView: Datasource and Delegate
extension SimpleCalculatorViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryTableViewCell", for: indexPath) as! EntryTableViewCell
        cell.selectionStyle = .none
        cell.configureDataForCell(entry: entryList[indexPath.row], selectedMode: Mode.lightMode)
        
        //cell.configureCellLabel(name: entryList[indexPath.row].folder_name)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat(70)
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit  = editAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [edit,delete])
    }
    
    func editAction(at index: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            DispatchQueue.main.async {
                self.editingIndex = index.row
                self.handleEdit(value: self.entryList[index.row].Amount)
                //self.showEnterPasswordAlert(index: index.row, type: "Edit")
            }
            
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "ic_edit")
        action.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.6862745098, blue: 0.7529411765, alpha: 1)
        return action
    }
    
    func deleteAction(at index: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            DispatchQueue.main.async {
                self.entryList.remove(at: index.row)
                self.calculateData()
                self.reloadMasterTable()
                //self.showEnterPasswordAlert(index: index.row, type: "Delete")
            }
            
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "ic_delete")
        action.backgroundColor = #colorLiteral(red: 0.3254901961, green: 0.3607843137, blue: 0.4078431373, alpha: 1)
        return action
    }
    
}
extension SimpleCalculatorViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Defaults.keyboard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let keyboardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyboardCollCell", for: indexPath) as! KeyboardCollCell
        keyboardCell.configureCell(value: Defaults.keyboard[indexPath.row])
        return keyboardCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: keyboardColl.frame.width / 3, height: 250 / 3)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateLabel(value: Defaults.keyboard[indexPath.row])
    }
    
}

