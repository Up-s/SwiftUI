//
//  Memo.swift
//  SwiftUIMemo
//
//  Created by Lee Kira on 2021/06/18.
//

import SwiftUI

// Identifiable - 테이블뷰, 컬렉션뷰에 쉽게 바인딩
// ObservableObject - 반은형 UI 구현
class Memo: Identifiable, ObservableObject {
  
  let id: UUID
  @Published var content: String
  let insertDate: Date
  
  init(id: UUID = UUID(), content: String, insertDate: Date = Date()) {
    self.id = id
    self.content = content
    self.insertDate = insertDate
  }
}

extension Memo: Equatable {
  static func == (lhs: Memo, rhs: Memo) -> Bool {
    return lhs.id == rhs.id
  }
}
