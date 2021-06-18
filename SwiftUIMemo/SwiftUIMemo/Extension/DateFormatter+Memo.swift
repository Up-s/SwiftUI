//
//  DateFormatter+Memo.swift
//  SwiftUIMemo
//
//  Created by Lee Kira on 2021/06/18.
//

import Foundation

extension DateFormatter {
  static let memoDateFormater: DateFormatter = {
    let f = DateFormatter()
    f.dateStyle = .long
    f.timeStyle = .none
    f.locale = Locale(identifier: "Ko_kr")
    return f
  }()
}



extension DateFormatter: ObservableObject {}
