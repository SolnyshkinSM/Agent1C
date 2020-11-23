//
//  SaleViewController.swift
//  Agent1C
//
//  Created by Administrator on 06.11.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit
import Charts

class SaleViewController: UIViewController {
    
    @IBOutlet weak var pieChart: PieChartView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // MARK: - Methods
    
    func loadData() {
        let networkDataFetcher: DataFetcher = NetworkDataFetcher()
        let urlData = "http://185.179.188.159/DemoTrdBase/hs/AgentAPI/V1/SaleList"
        DispatchQueue.global(qos: .utility).async {
            networkDataFetcher.fetchGenericJSONData(urlString: urlData) { (saleGroup: SaleGroup?) in
                guard let results = saleGroup?.results else { return }
                self.pieChartUpdate(results: results)
            }
        }
    }
    
    func pieChartUpdate(results: [Sale]) {
        
        var entryArray = [PieChartDataEntry]()
        results.forEach { (sale) in
            let entry = PieChartDataEntry(value: Double(sale.sum), label: sale.name)
            entryArray.append(entry)
        }
        
        let dataSet = PieChartDataSet(entries: entryArray, label: nil)
        
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data

        dataSet.colors = ChartColorTemplates.joyful()
        dataSet.valueColors = [UIColor.black]
        dataSet.entryLabelColor = UIColor.purple
        
        pieChart.legend.font = UIFont(name: "Futura", size: 15)!
        pieChart.chartDescription?.font = UIFont(name: "Futura", size: 30)!
        pieChart.chartDescription?.xOffset = pieChart.frame.width + 30
        pieChart.chartDescription?.yOffset = pieChart.frame.height * (2/3)
        pieChart.chartDescription?.textAlign = NSTextAlignment.left

        pieChart.notifyDataSetChanged()
    }
    
    // MARK: - Actions
    
    @IBAction func repeatPressed(_ sender: UIButton) {
        loadData()
    }    

}
