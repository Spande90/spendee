//
//  CalculatorVCViewController.swift
//  Spendee
//
//  Created by Siddharth on 7/25/19.
//  Copyright © 2019 TechnoPear. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var masterTable:UITableView!
    @IBOutlet weak var keyboardColl:UICollectionView!
    @IBOutlet weak var btnAddEntry:UIButton!
    @IBOutlet weak var txtFieldAmount:UITextField!
    @IBOutlet weak var txtFieldRemark:UITextField!
    @IBOutlet weak var optionView1:UIView!
    @IBOutlet weak var optionView2:UIView!
    @IBOutlet weak var optionViewHeightConstant:NSLayoutConstraint!
    @IBOutlet weak var keyboardView:UIView!
    @IBOutlet weak var btnCancel:UIButton!
    @IBOutlet weak var btnPlus:UIButton!
    @IBOutlet weak var btnMinus:UIButton!
    
    
    private var entryList:[Entry] = []
    private var isDarkModeSelected:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeVC()
        // Do any additional setup after loading the view.
    }

}
extension CalculatorViewController{
    
    @IBAction func btnMinusClicked(_ sender:UIButton){
        self.closeOptionView()
        
    }
    
    @IBAction func btnPlusClicked(_ sender:UIButton){
        self.closeOptionView()
    }
    
    @IBAction func btnCancelClicked(_ sender:UIButton){
        self.closeOptionView()
    }
    @IBAction func btnAddEntryClicked(_ sender:UIButton){
        self.openOptionView()
    }
    
}
extension CalculatorViewController{
    
    func initializeVC(){
        self.navigationController?.isNavigationBarHidden = true
        self.registerTableCells()
        self.assignDelegate()
        self.assignDataSource()
        self.reloadMasterTable()
        //self.optionViewHeightConstant.constant = Defaults.keyboardOptionViewHeight
    }
    
    //Register Table Cell
    func registerTableCells(){
        self.masterTable.register(UINib(nibName: "MasterEntryTableCell", bundle: nil), forCellReuseIdentifier: "MasterEntryTableCell")
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
        self.keyboardColl.reloadData()
    }
    
    func closeOptionView(){
        UIView.animate(withDuration: 0.3) {
            self.btnPlus.isHidden = true
            self.btnMinus.isHidden = true
            self.btnCancel.isHidden = true
            self.keyboardView.isHidden = true
            //self.optionViewHeightConstant.constant = Defaults.keyboardOptionViewHeight
        }
    }
    
    func openOptionView(){
        UIView.animate(withDuration: 0.3) {
            self.btnPlus.isHidden = false
            self.btnMinus.isHidden = false
            self.btnCancel.isHidden = false
            self.keyboardView.isHidden = false
            //self.optionViewHeightConstant.constant = self.masterTable.frame.height + Defaults.keyboardOptionViewHeight
        }
    }
    
}

//MARK: ADD Amount View Functions
extension CalculatorViewController{
    func amountAddClicked(){
        
    }
}

//MARK: TableView: Datasource and Delegate
extension CalculatorViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterEntryTableCell", for: indexPath) as! MasterEntryTableCell
        cell.selectionStyle = .none
        //cell.configureDataForCell(entry: Entry(entryID: 0, amount: 20000, notes: "Salary"), selectedMode: isDarkModeSelected ? Mode.darkMode : Mode.lightMode)
        
        //cell.configureCellLabel(name: entryList[indexPath.row].folder_name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(110)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit  = editAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [edit,delete])
    }
    
    func editAction(at index: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            DispatchQueue.main.async {
                //self.showEnterPasswordAlert(index: index.row, type: "Edit")
            }
            
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "ic_edit")
        action.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return action
    }
    
    func deleteAction(at index: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            DispatchQueue.main.async {
//self.showEnterPasswordAlert(index: index.row, type: "Delete")
            }
            
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "ic_delete")
        action.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return action
    }
    
}
extension CalculatorViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Defaults.keyboard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let keyboardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyboardCollCell", for: indexPath) as! KeyboardCollCell
        keyboardCell.configureCell(value: Defaults.keyboard[indexPath.row])
        return keyboardCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height / 3)
    }
    
    
}


