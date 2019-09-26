//
//  ViewController.swift
//  NotePadGR
//
//  Created by Mseak GR on 9/26/19.
//  Copyright © 2019 Mseak GR. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UITableViewController {

    var notas = [Notas]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNotes()
    }


    //MARK: - metodo Load Notes
    //para cargar todo lo que este dentro
    
    func loadNotes(with request: NSFetchRequest<Notas> = Notas.fetchRequest()){
        
        do {
            
            notas = try context.fetch(request)
            
        }catch{
            
            print("Error fetching data from context issue : \(error)")
        }
    
    }
    
    //MARK: - Table View Data Source
    // Metodos para cargar datos
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCells", for: indexPath)
        let nota = notas[indexPath.row]
        
        cell.textLabel?.text = nota.titulo
        
        return cell
        
    }
    
    //MARK: - Add Notes to the View
    
    @IBAction func addNotas(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        let alert = UIAlertController(title: "Añade Nueva Nota", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Añadir", style: .default) { (action) in
            
            let newNote = Notas(context: self.context)
            newNote.titulo = textfield.text
            self.notas.append(newNote)
            self.saveNotas()
            
        }
        alert.addTextField { (alerta) in
            alerta.placeholder = "Titulo de la Nueva Nota"
            textfield = alerta
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Data Manipulation
    //Aqui van las funciones para salvar
        
        
    func saveNotas (){
        
        do{
            try context.save()
        }catch{
            print("Error Saving Note \(error)")
        }
        self.tableView.reloadData()
    }
    
    

}
