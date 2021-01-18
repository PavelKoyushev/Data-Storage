//
//  RealmViewController.swift
//  Data Storage
//
//  Created by Pavel Koyushev on 14.01.2021.
//

import UIKit
import RealmSwift

class RealmViewController: UIViewController {
    
    @IBOutlet private weak var tableView : UITableView!
    
    private let simpleTableIdentifier = "ident"
    private let dataManager = RealmDataManager.shared
    private var allTasks: Results<TodoObject>!

    @IBAction private func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "Добавить задачу", message: nil, preferredStyle: .alert)
        alert.addTextField { text in text.placeholder = "Название"}
        
        let addAction = UIAlertAction(
            title: "Соханить", style: .default, handler: { [weak self] action in
                guard let name = alert.textFields?.first?.text
                    else { return }
                self!.dataManager.add(taskText: name)
                self?.getAllTasks()
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
        getAllTasks()
    }
}

extension RealmViewController {
    private func getAllTasks() {
        self.allTasks = dataManager.getTasks()
    }
}

extension RealmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allTasks.count != 0 { return allTasks.count } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if cell == nil {
            cell = UITableViewCell (
                style: UITableViewCell.CellStyle.value1,
                reuseIdentifier: simpleTableIdentifier
            )
        }
        cell?.textLabel?.text = self.allTasks[indexPath.row].task
        cell?.detailTextLabel?.text = self.allTasks[indexPath.row].date
        return cell!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completion in
                RealmDataManager.shared.remove(todo: self.allTasks[indexPath.row])
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                completion(true)
            }
            return UISwipeActionsConfiguration(actions: [action])
        }
}
