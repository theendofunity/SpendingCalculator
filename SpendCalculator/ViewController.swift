//
//  ViewController.swift
//  SpendCalculator
//
//  Created by Admin on 14.03.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var itemTextEdit: UITextField!
    @IBOutlet weak var priseTextEdit: UITextField!
    @IBOutlet weak var spendTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var spends = [(item: String, prise: Int)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spendTableView.dataSource = self
        spendTableView.delegate = self
        
        updateButtonsState()
    }

    @IBAction func add(_ sender: UIButton) {
        let itemName = itemTextEdit.text ?? "-"
        guard let prise = Int(priseTextEdit.text ?? "0") else {
            return
        }
        
        spends.append((itemName, prise))
        updateView()
    }
    
    @IBAction func clear(_ sender: UIButton) {
        spends.removeAll()
        updateView()
    }
    
    @IBAction func checkInput(_ sender: UITextField) {
        updateButtonsState()
    }
    
    func calculateTotalSpending() {
        var total = 0
        
        for spend in spends {
            total += spend.prise
        }
        totalLabel.text = "\(total)"
    }
    
    func updateView() {
        spendTableView.reloadData()
        calculateTotalSpending()
        updateButtonsState()
        itemTextEdit.text?.removeAll()
        priseTextEdit.text?.removeAll()
    }
    
    func updateButtonsState() {
        if spendTableView.numberOfRows(inSection: 0) == 0 {
            clearButton.isEnabled = false
        } else {
            clearButton.isEnabled = true
        }
        
        if itemTextEdit.hasText && priseTextEdit.hasText {
            addButton.isEnabled = true
        } else {
            addButton.isEnabled = false
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: - Table view data sourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spends.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spendCell", for: indexPath)
        
        let spend = spends[indexPath.row]
        cell.textLabel?.text = "\(spend.item)       \(spend.prise)"
       
        return cell
    }
}
