//
//  SchoolInfoModelObject.swift
//  20220320-NagaraniParapelly-NYCSchools
//
//  Created by raniraja on 3/20/22.
//

import Foundation
/*** School Info struct to store school info ***/
struct SchoolInfo: Decodable {
   private enum CodingKeys: String, CodingKey {
        case schoolName = "school_name"
        case schoolEmail = "school_email"
        case schoolContact = "phone_number"
        case dbn
    }
    let schoolName: String?
    let schoolEmail: String?
    let schoolContact: String?
    let dbn: String?
}
