//
//  ViewController.swift
//  ProgramaticUIKit
//
//  Created by Tsvetelina Cholakova on 05/05/2023.
//

import UIKit

struct FlowerSection{
    let sectionTitle: String
    var sections: [String] = []
}

class ViewController: UIViewController {
    
    // MARK: Variables
    private var items: [String] = []
    
    private let images: [UIImage] = [UIImage(named: "Blue flower")!, UIImage(named: "Rose 1")!, UIImage(named: "Passon flower")!, UIImage(named: "Rose")!] //array of images
    
    
    // MARK: UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true //will alow selection
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier) //register the custom cell
        return tableView
    }() //making tabeView in class level () - constactor
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //seting up the header View
        let tableHeaderView = TableViewHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250))
        self.tableView.tableHeaderView = tableHeaderView
        
        //setting up the button
        let tableViewFooter = TableViewFooter(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        self.tableView.tableFooterView = tableViewFooter
        
        tableViewFooter.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        let section = Int.random(in: 0...1)
        self.items.append(section.description)
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: Setup UI
    private func setupUI() {
        self.view.backgroundColor = .orange
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        ]) // seting up the constrains
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    } //how many rows we want in that tableView
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            fatalError("The TableView cannot dequeue a Custom cell in ViewController")
        }
        let image = self.images[indexPath.row]
        cell.configure(with: image, and: indexPath.row.description)
        
        return cell
    } // using the custom cell
    
    private func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) -> CGFloat {
        return 60.5
    }  // the height of each row
}

