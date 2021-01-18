//
//  TodoCDViewController.swift
//  Data Storage
//
//  Created by Pavel Koyushev on 14.01.2021.
//

import UIKit
import CoreData

class TodoCDViewController: UIViewController {
    
    private let simpleTableIdentifier = "ident"
    private var tasksData: [NSManagedObject] = [] //all data from db
    
    @IBOutlet private weak var tableView : UITableView!
    
    @IBAction private func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "Добавить задачу", message: nil, preferredStyle: .alert)
        alert.addTextField { text in text.placeholder = "Название"}
        
        let addAction = UIAlertAction(
            title: "Соханить", style: .default, handler: { [weak self] action in
                guard let task = alert.textFields?.first?.text
                    else { return }
                let (rawDate, dateFormatter) = (Date(), DateFormatter())
                    dateFormatter.dateFormat = "dd.MM.YY HH:mm"
                let dateString = dateFormatter.string(from: rawDate)
                self?.saveTask(task: task, date: dateString)
                self?.fetchAllTasks()
                self?.tableView?.reloadData()
                
                alert.dismiss(animated: true, completion: nil)
        })
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: .none)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        fetchAllTasks()
    }
}

extension TodoCDViewController {
    private func saveTask(task: String, date: String) {
        CoreDataManager.sharedManager.insertTask(task: task, date: date)
        CoreDataManager.sharedManager.saveContext()
    }
    
    private func fetchAllTasks(){
        if CoreDataManager.sharedManager.fetchAllTasks() != nil{
            tasksData = CoreDataManager.sharedManager.fetchAllTasks()!
            tasksData.reverse()
        }
    }
}

extension TodoCDViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasksData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        
        if cell == nil {
            cell = UITableViewCell (
                style: UITableViewCell.CellStyle.value1,
                reuseIdentifier: simpleTableIdentifier
            )
        }
        
        let tasks = tasksData[indexPath.row]
        
        cell?.textLabel?.text = tasks.value(forKeyPath: "task") as? String
        cell?.detailTextLabel?.text = tasks.value(forKeyPath: "date") as? String
        
        return cell!
    }
}

