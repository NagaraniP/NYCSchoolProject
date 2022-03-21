//
//  NYCSchoolSATDetailsModelObject.swift
//  20220320-NagaraniParapelly-NYCSchools
//
//  Created by raniraja on 3/20/22.
//

import Foundation
/*** schoolSATResults struct to store SAT data ***/
struct SchoolSATResults: Decodable {
    private enum CodingKeys: String, CodingKey {
        case testTakers = "num_of_sat_test_takers"
        case readAvgScore = "sat_critical_reading_avg_score"
        case mathAvgScore = "sat_math_avg_score"
        case writingAvgScore = "sat_writing_avg_score"
    }
    let testTakers: String?
    let readAvgScore: String?
    let mathAvgScore: String?
    let writingAvgScore: String?
}
