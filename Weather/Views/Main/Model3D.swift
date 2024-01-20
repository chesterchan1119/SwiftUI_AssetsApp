//
//  Model3D.sqift.swift
//  Weather
//
//  Created by Chester Chan on 10/1/2024.
//

import Foundation

struct Model3D<Content> where Content : View
    
Model3D(named: "Robot-Drummer") { model in
        model
            .resizable()
            .aspectRatio(contentMode: .fit)
    } placeholder: {
        ProgressView()
    }
    
    

