//
//  ViewController.swift
//  NotesApp1
//
//  Created by Sergio Rodarte on 31/01/25.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables declarations
    var noteTitle: String?
    var noteContent: String?
    
    //ScrollView Declaration
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //StackView Declaration
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Layout
        setUpLayout()
        
        //Title
        navigationController?.navigationBar.prefersLargeTitles = true
        title = noteTitle
        
        //Content
        addNote()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
}

//ScrollView, StackView & Constraints
extension ViewController {
    
    func setUpLayout() {
        
        //Add ScrollView to the MainView
        view.addSubview(scrollView)
        
        //Add StackView inside ScrollView
        scrollView.addSubview(stackView)
        
        //ScrollView Constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        //StackView Constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16)
        ])
    }
    
}

//Note Content
extension ViewController {
    
    func addNote() {
        let label = UILabel()
        label.text = noteContent
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 0
        stackView.addArrangedSubview(label)
    }
}
