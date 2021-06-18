//
//  MemoStore.swift
//  SwiftUIMemo
//
//  Created by Lee Kira on 2021/06/18.
//

import Foundation

class MemoStore: ObservableObject {
  
  @Published var list: [Memo]
  
  init() {
    self.list = [
      Memo(content: "Memo1"),
      Memo(content: "Memo2"),
      Memo(content: "Memo3")
    ]
  }
  
  // CRUD
  
  func insert(name: String) {
    let newMemo = Memo(content: name)
    self.list.insert(newMemo, at: 0)
  }
  
  func update(memo: Memo?, content: String) {
    guard let memo = memo else { return }
    memo.content = content
  }
  
  func delete(memo: Memo) {
    self.list.removeAll() { $0 == memo }
  }
  
  func delete(set: IndexSet) {
    for index in set {
      self.list.remove(at: index)
    }
  }
}
