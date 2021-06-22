//
//  ContentView.swift
//  SwiftUIMemo
//
//  Created by Lee Kira on 2021/06/18.
//

import SwiftUI

struct MemoListScene: View {
  
  @EnvironmentObject var store: CoreDataManager
  @EnvironmentObject var formatter: DateFormatter
  
  @State var showComposer: Bool = false
  
  
  // 변경이 있을때마다 최신으로 업데이트됨
  // FetchRequest - SwiftUIView 내부에서 사용해야 동작함
  @FetchRequest(entity: MemoEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MemoEntity.insertDate, ascending: false)])
  var memoList: FetchedResults<MemoEntity>
  
  
  var body: some View {
    NavigationView {
      List {
        ForEach(memoList) { memo in
          NavigationLink(
            destination: DetailScene(memo: memo),
            label: {
              MemoCell(memo: memo)
            })
        }
        .onDelete(perform: delete)
      }
      .navigationTitle("내 메모")
      .navigationBarItems(trailing: ModalButton(show: $showComposer))
//      .fullScreenCover(isPresented: $showComposer, content: {
//        ComposeScene(showComposer: $showComposer)
//          .environmentObject(self.store)
//          .environmentObject(KeyboardObserver())
//      })
      .sheet(isPresented: $showComposer, content: {
        ComposeScene(showComposer: $showComposer)
          .environmentObject(self.store)
          .environmentObject(KeyboardObserver())
      })
    }
  }
  
  func delete(set: IndexSet) {
    for index in set {
      store.delete(memo: memoList[index])
    }
  }
}

fileprivate struct ModalButton: View {
  
  @Binding var show: Bool
  
  var body: some View {
    Button(action: {
      self.show = true
    }, label: {
      Image(systemName: "plus")
    })
  }
}

struct MemoListScene_Previews: PreviewProvider {
  static var previews: some View {
    MemoListScene()
      .environmentObject(CoreDataManager.shared)
      .environmentObject(DateFormatter.memoDateFormater)
  }
}
