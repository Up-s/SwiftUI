//
//  ComposeScene.swift
//  SwiftUIMemo
//
//  Created by Lee Kira on 2021/06/21.
//

import SwiftUI

struct ComposeScene: View {
  
  @EnvironmentObject var keyboard: KeyboardObserver
  
  @EnvironmentObject var store: CoreDataManager
  @State private var content: String = ""
  
  @Binding var showComposer: Bool
  
  var memo: MemoEntity? = nil
  
  var body: some View {
    NavigationView {
      VStack {
        TextView(text: $content)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
//          .padding(.bottom, keyboard.context.height)
//          .animation(.easeInOut(duration: keyboard.context.animationDuration))
          .background(Color.yellow)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .navigationBarTitle(memo != nil ? "메모 편집" : "새 메모", displayMode: .inline)
      .navigationBarItems(leading: DismissButton(show: $showComposer),
                          trailing: SaveButton(show: $showComposer, content: $content, memo: memo))
    }
    .onAppear {
      self.content = self.memo?.content ?? ""
    }
  }
}

fileprivate struct DismissButton: View {
  
  @Binding var show: Bool
  
  var body: some View {
    Button(action: {
      self.show = false
    }, label: {
      Text("취소")
    })
  }
}

fileprivate struct SaveButton: View {
  
  @Binding var show: Bool
  
  @EnvironmentObject var store: CoreDataManager
  @Binding var content: String
  
  var memo: MemoEntity? = nil
  
  var body: some View {
    Button(action: {
      switch self.memo {
      case .some(let memo):
        self.store.update(memo: memo, content: self.content)
        
      case .none:
        self.store.addMemo(content: self.content)
      }
      
      self.show = false
    }, label: {
      Text("저장")
    })
  }
}

struct ComposeScene_Previews: PreviewProvider {
  static var previews: some View {
    ComposeScene(showComposer: .constant(false))
      .environmentObject(CoreDataManager.shared)
      .environmentObject(KeyboardObserver())
  }
}
