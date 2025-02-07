//
//  ViewController.swift
//  NotesApp1
//
//  Created by Sergio Rodarte on 31/01/25.
//

import UIKit

class NotesController: UIViewController {
    
    //Variables declarations
    var notes: [NotesModel] = []
    var selectedNote: NotesModel? = nil
    var isCellSelected = false
    
    let ingredients = """
        500g de maíz nixtamalizado  
        200g de frijoles negros cocidos  
        2 chiles jalapeños  
        1 aguacate maduro  
        150g de queso fresco  
        100g de nopales cocidos  
        4 tortillas de maíz  
        100g de chorizo  
        1 diente de ajo  
        1 cebolla blanca  
        2 tomates rojos  
        Cilantro fresco al gusto  
        1 limón verde  
        Sal al gusto  
        Aceite de oliva  
        100g de carne de res deshebrada  
        2 tortillas de maíz  
        200g de frijoles refritos  
        100g de queso fresco  
        1 aguacate  
        2 chiles jalapeños  
        1 diente de ajo  
        1 cebolla  
        4 tomates rojos  
        1 manojo de cilantro  
        500g de carne de res  
        2 limones  
        3 cucharadas de aceite de oliva  
        100g de arroz  
        200g de maíz  
        1 cucharadita de comino  
        Sal al gusto  
        2 pimientos morrones  
        500g de camarones frescos  
        1 litro de caldo de pollo  
        50g de almendras tostadas  
        1 puñado de espinacas  
        1 taza de quinoa  
        3 dientes de ajo  
        250g de champiñones  
        1 lata de leche de coco  
        150g de tofu  
        1 pizca de cúrcuma  
        1 puñado de hierbas frescas  
        500g de pescado blanco  
        1 paquete de fideos de arroz  
        200g de salmón ahumado  
        1 frasco de aceitunas  
        1 puñado de alcaparras  
        300g de calabacines  
        100g de queso parmesano  
        250ml de crema para cocinar  
        4 piezas de pan pita  
        1 frasco de salsa de tomate  
        200g de lentejas cocidas  
        1 mango maduro  
        1 puñado de nueces  
        250g de yogur griego  
        2 cucharadas de miel  
        1 piña fresca  
        1 kg de pollo en trozos  
        1 taza de salsa de soja  
        5 cucharadas de vinagre balsámico  
        1 pizca de jengibre  
        2 ramas de romero  
        500ml de vino blanco  
        1 kg de costillas de cerdo  
        1 taza de miel de maple  
        1 cucharada de mostaza  
        Sal y pimienta al gusto 
        """
    
    //Outlets declarations
    @IBOutlet weak var noNotesLabel: UILabel!
    @IBOutlet weak var notesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //notes.append(NotesModel(noteTitle: "Ingredients",noteContent: ingredients))
        print(notes)
        
        if !notes.isEmpty{
            notesTable.isHidden = false
            noNotesLabel.isHidden = true
        }
        
        notesTable.delegate = self
        notesTable.dataSource = self
    }
    
    
    //Buttons declarations
    
    @IBAction func addPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "Add-Edit-Segue", sender: self)
    }
    
    
    @IBAction func editPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "Add-Edit-Segue", sender: selectedNote)
    }
    
    
    @IBAction func viewPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "View-Segue", sender: self)
    }
 
    
    @IBAction func deletePressed(_ sender: UIButton) {
        if isCellSelected != false {
            showAlert(title: "Are you sure?", message: "Press delete to confirm")
        } else {
            print("No cell selected")
        }
        
    }
    
    
    //Segue prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Add-Edit Segue
        if segue.identifier == "Add-Edit-Segue" {
            if let addEditVC = segue.destination as? AddEditController {
                
                if sender is NotesModel {
                    print(selectedNote ?? "Error")
                    addEditVC.noteTitle = selectedNote?.noteTitle
                    addEditVC.noteContent = selectedNote?.noteContent
                }
                
                addEditVC.delegate = self
            }
        }
        
        //View Segue
        if segue.identifier == "View-Segue" {
            if let viewVC = segue.destination as? ViewController {
                viewVC.noteTitle = selectedNote?.noteTitle
                viewVC.noteContent = selectedNote?.noteContent
            }
        }
    }
    
}

//Add-Edit Delegate
extension NotesController: Add_Edit_Delegate {
    func addNote(_ note: NotesModel) {
        
        
        if let index = notes.firstIndex(where: { $0.noteTitle == note.noteTitle }) {
            notes[index] = note
        } else {
            notes.append(note)
        }
        
        notesTable.isHidden = false
        noNotesLabel.isHidden = true
        notesTable.reloadData()
    }
}


//UITableView
extension NotesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].noteTitle
        cell.detailTextLabel?.text = notes[indexPath.row].noteContent
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isCellSelected = true
        selectedNote = notes[indexPath.row]
    }
    
}

//Alert
extension NotesController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.notes.remove(at: self.notesTable.indexPathForSelectedRow!.row)
            self.isCellSelected = false
            self.notesTable.reloadData()
        }))
        present(alert, animated: true)
    }
}



