//
//  BuyViewController.swift
//  Agent1C
//
//  Created by Administrator on 09.11.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit
import Charts

class BuyViewController: UIViewController {

    @IBOutlet weak var barChart: BarChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self
        loadData()
    }
    
    // MARK: - Methods
    
    func loadData() {
        let networkDataFetcher: DataFetcher = NetworkDataFetcher()
        let urlData = "http://185.179.188.159/DemoTrdBase/hs/AgentAPI/V1/BuyList"
        DispatchQueue.global(qos: .utility).async {
            networkDataFetcher.fetchGenericJSONData(urlString: urlData) { (saleGroup: SaleGroup?) in
                guard let results = saleGroup?.results else { return }
                self.pieChartUpdate(results: results)
            }
        }
    }
    
    func pieChartUpdate(results: [Sale]) {
        
        var entryArray = [ChartDataEntry]()
        let tempResults = results.sorted(by: { $0.sum > $1.sum })
        for (index, sale) in tempResults.enumerated() {
            let entry = BarChartDataEntry(x: Double(index + 1), y: Double(sale.sum), data: sale.name)
            entryArray.append(entry)
        }
        
        let dataSet = BarChartDataSet(entries: entryArray, label: nil)
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        
        dataSet.colors = ChartColorTemplates.joyful()
        dataSet.valueColors = [UIColor.black]

        barChart.legend.font = UIFont(name: "Futura", size: 15)!
        barChart.chartDescription?.font = UIFont(name: "Futura", size: 30)!
        barChart.chartDescription?.xOffset = barChart.frame.width + 30
        barChart.chartDescription?.yOffset = barChart.frame.height * (2/3)
        barChart.chartDescription?.textAlign = NSTextAlignment.left
        
        barChart.notifyDataSetChanged()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func repeatPressed(_ sender: UIButton) {
        loadData()
    }

}

extension BuyViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        let alert = UIAlertController(title: nil, message: entry.data as? String, preferredStyle: .alert)
        let cansel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(cansel)
        present(alert, animated: true, completion: nil)
    }
}
