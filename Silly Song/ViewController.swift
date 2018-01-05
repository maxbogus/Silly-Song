//
//  ViewController.swift
//  Silly Song
//
//  Created by Max Boguslavskiy on 02/01/18.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField?
    
    @IBOutlet weak var lyricsView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameField?.delegate = self
    }

    @IBAction func reset(_ sender: Any) {
        nameField?.text = nil
        lyricsView.text = nil
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        guard let textField = nameField else {
            return
        }
        guard let fullName: String = textField.text else {
            return
        }
        lyricsView.text = lyricsForName(lyricsTemplate:bananaFanaTemplate, fullName: fullName)
    }
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo b<SHORT_NAME>",
        "Banana Fana Fo f<SHORT_NAME>",
        "Me My Mo m<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    func shortNameFromName(name: String) -> String {
        let vowels = "aeuio"
        var lowercaseName = name.lowercased()
        for char in name {
            if vowels.contains(char) {
                if let index = name.index(of: char) {
                    lowercaseName = lowercaseName.substring(from: index)
                    break
                }
            }
        }
        return String(lowercaseName)
    }
    
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        let shortName = shortNameFromName(name: fullName)
        let lyrics = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName).replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        return lyrics
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
