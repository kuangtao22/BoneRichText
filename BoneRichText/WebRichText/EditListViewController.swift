//
//  RootViewController.swift
//  SwiftRichTextDemo
//
//  Created by Steven Xie on 2018/7/23.
//  Copyright © 2018年 Steven Xie. All rights reserved.
//

import UIKit

class EditListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "富文本编辑器"
        
        let table = UITableView(frame: view.bounds, style: .plain)
        table.delegate = self
        table.dataSource = self
        view.addSubview(table)
        table.tableFooterView = UIView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension EditListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idenstr = "sss"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: idenstr)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: idenstr)
        }
        cell?.textLabel?.text = ["新增", "编辑"][indexPath.row]
        cell?.accessoryType = .disclosureIndicator
        if let aCell = cell {
            return aCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let view = EditViewController()
        
//        let str = "哈哈哈啊啊啊啊 <img src=\"http://pic.baikemy.net/apps/kanghubang/486/3486/iOS1475026895.jpg\"><div>哈哈哈啊啊啊啊奥等级看哈接口b</div>"
        
        let str = "说得就像是真的一样差点信了你的鬼话<img src=\"https://bbtcdn.8btc.com/static/image/smiley/coolmonkey/09.gif\" smilieid=\"33\" border=\"0\" alt=\"\" />"
        
        view.inHtmlString = indexPath.row == 0 ? "" : str
        navigationController?.pushViewController(view, animated: true)
    }
}
