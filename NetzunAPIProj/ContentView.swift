//  ContentView.swift
//  NetzunAPIProj
//
//  Created by Sinuhé Ruedas on 18/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .onAppear {
                    self.enviarPeticion()
                }
        }
        .padding()
    }
    
    // Funcion Consulta
    func enviarPeticion() {
        
        // MARK: - GET METHOD
        
        // Definir URL
        let baseURL = "https://pokeapi.co/api/v2/"
        let peticionDitto = "pokemon/ditto"
        let urlPeticion = URL(string: baseURL + peticionDitto)
        // Crear elemento peticion/request
        var urlRequest = URLRequest(url: urlPeticion!)
        
        // Definir Método
        urlRequest.httpMethod = "GET" // Este es opcional porque es por defecto
        
        // Crear consulta
        let peticion = URLSession.shared.dataTask(with: urlRequest,
                                                  completionHandler: { (data: Data?,
                                                                        urlResponse: URLResponse?,
                                                                        error: Error?) in
            // data no sea vacía -> Tengamos datos
            // urlResponse no sea vacía -> Tenga datos
            // error que sea vacío -> No hay errores
            // Actualizar UI
            
            if (error == nil) {
                // No hay errores
                
                if (data != nil && urlResponse != nil) {
                    // Procesar datos
                    // Do-catch
                    do {
                        // data -> JSON -> Cast -> Dictionary
                        
                        let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any]
                        let nombrePokemon = json!["name"] as! String
                        
                        DispatchQueue.main.async {
                            self.nombrePokemon.text = nombrePokemon
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("Data es vacío o urlResponse es vacía")
                }
            } else {
                print(error?.localizedDescription)
            }
            
        })
        
        // Ejecutar consulta
        peticion.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

