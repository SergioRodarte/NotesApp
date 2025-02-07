//
//  AddController.swift
//  NotesApp1
//
//  Created by Sergio Rodarte on 31/01/25.
//

import UIKit

protocol Add_Edit_Delegate {
    func addNote(_ note: NotesModel)
}

class AddEditController: UIViewController {
    
    //Delegate
    var delegate: Add_Edit_Delegate?
    
    //Variables Declarations
    var noteTitle: String?
    var noteContent: String?
    
    //Outlets declarations
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contentTextView.text = noteContent
        titleTextField.text = noteTitle
    }
    
    //Buttons declarations
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let note = saveNote()
        delegate?.addNote(note)
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    //Functions
    func saveNote() -> NotesModel {
        
        if let title = titleTextField.text, let content = contentTextView.text {
            return NotesModel(noteTitle: title, noteContent: content)
        }
        
        return NotesModel(noteTitle: "New Note", noteContent: "No Content")
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
