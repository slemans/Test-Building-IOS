//
//  ViewController.swift
//  testOne
//
//  Created by sleman on 14.10.21.
//

import UIKit

class ViewController: UIViewController {

    let viewTop: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let tableView: UITableView = {
//        tableView = UITableView(frame: view.bounds, style: .grouped)
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(StreetTableViewCell.self, forCellReuseIdentifier: "contactCell")
        return tableView
    }()
    let buttonAddCell: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(("+"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.tintColor = .white
        button.titleLabel!.font = UIFont(name: "Arial", size: 60)
        button.titleLabel!.textAlignment = .center
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.layer.cornerRadius = 70 / 2.0
        button.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
        return button
    }()

    // cancel demo

    var arrayStreet: [Street] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        arrayStreet.append(Street(lable: "Название локации", arrayImage: []))
    }

    @objc func pressed(_ sender: UIButton) {
        arrayStreet.append(Street(lable: "Название локации", arrayImage: []))
        tableView.reloadData()
    }


    func setupTableView() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: viewTop.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true


    }

    // demo
//    func setupView1() {
//        view1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        view1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 3).isActive = true
//        view1.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        view1.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//    }
//    func setupView2() {
//        view2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
//        view2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 3).isActive = true
//        view2.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        view2.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//    }
    // cancel demo



    func startSetting() {
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        view.addSubview(viewTop)
        setupViewTop()
        view.addSubview(tableView)
        setupTableView()
        view.addSubview(buttonAddCell)
        setupButton()
    }
    // кнопка addCell
    func setupButton() {
        buttonAddCell.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        buttonAddCell.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
    }

    // верхняя часть
    func setupViewTop() {
        viewTop.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewTop.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewTop.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        viewTop.heightAnchor.constraint(equalToConstant: 150).isActive = true
        let imageTop = UIImageView()
        imageTop.image = #imageLiteral(resourceName: "logo")
        imageTop.translatesAutoresizingMaskIntoConstraints = false
        viewTop.addSubview(imageTop)
        imageTop.centerYAnchor.constraint(equalTo: viewTop.centerYAnchor).isActive = true
        imageTop.centerXAnchor.constraint(equalTo: viewTop.centerXAnchor).isActive = true
        let labelTop = UILabel()
        labelTop.text = "ЛОКАЦИИ"
        labelTop.textAlignment = .center
        labelTop.textColor = #colorLiteral(red: 0.1294117647, green: 0.1254901961, blue: 0.1254901961, alpha: 1)
        labelTop.font = UIFont(name: "Oswald-Regular", size: 40)
        labelTop.translatesAutoresizingMaskIntoConstraints = false
        viewTop.addSubview(labelTop)
        labelTop.centerYAnchor.constraint(equalTo: viewTop.centerYAnchor).isActive = true
        labelTop.centerXAnchor.constraint(equalTo: viewTop.centerXAnchor).isActive = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayStreet.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! StreetTableViewCell
        cell.backgroundColor = .red
        let street = arrayStreet[indexPath.row]
        cell.textField.placeholder = street.lable
        return cell
    }
}
