//
//  ClientTableViewController.swift
//  Agent1C
//
//  Created by Administrator on 06.11.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class ClientTableViewController: UITableViewController {
    
    private var resultsArray: [Client] = [] {
        didSet {
            tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadData()
    }
    
    
    // MARK: - Methods
    
    func configureView() {
                
        //refreshControl
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = .white
        refreshControl?.tintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        refreshControl?.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    }
    
    @objc
    func refreshTableView() {
        self.loadData()
    }
    
    func loadData() {
        let networkDataFetcher: DataFetcher = NetworkDataFetcher()
        let urlData = "http://185.179.188.159/DemoTrdBase/hs/AgentAPI/V1/ClientList"
        DispatchQueue.global(qos: .utility).async {
            networkDataFetcher.fetchGenericJSONData(urlString: urlData) { (clientGroup: ClientGroup?) in
                guard let results = clientGroup?.results else { return }
                self.resultsArray = results
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ClientTableViewCell

        let client = resultsArray[indexPath.row]
        
        cell.nameClient.text = client.name
        cell.innClient.text = client.inn
        cell.cppClient.text = client.cpp

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let client = resultsArray[indexPath.row]
        
        if segue.identifier == "showClient" {
            let clientDetailVC = segue.destination as! ClientDetailViewController
            clientDetailVC.client = client
        }
    }

}
