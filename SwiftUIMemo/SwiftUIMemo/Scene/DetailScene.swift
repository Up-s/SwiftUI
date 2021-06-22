//
//  DetailScene.swift
//  SwiftUIMemo
//
//  Created by Lee Kira on 2021/06/21.
//

import SwiftUI

struct DetailScene: View {
  
  @ObservedObject var memo: MemoEntity
  
  @EnvironmentObject var store: CoreDataManager
  @EnvironmentObject var formatter: DateFormatter
  
  @State private var showEditSheet = false
  @State private var showDeleteAlert = false
  
  @Environment(\.presentationMode) var presentiationMode
  
  var body: some View {
    VStack {
      ScrollView {
        VStack {
          HStack {
            Text(self.memo.content ?? "")
              .padding()
            
            Spacer()
          }
          
          Text("\(self.memo.insertDate ?? Date(), formatter: formatter)")
            .padding()
            .font(.footnote)
            .foregroundColor(Color(UIColor.secondaryLabel))
        }
      }
      
      HStack {
        Button {
          self.showDeleteAlert.toggle()
        } label: {
          Image(systemName: "trash")
            .foregroundColor(Color(UIColor.systemRed))
        }
        .padding()
        .alert(isPresented: $showDeleteAlert) {
          Alert(title: Text("삭제 확인"),
                message: Text("메모를 삭제할까요?"),
                primaryButton: .destructive(Text("삭제"), action: {
                  self.store.delete(memo: self.memo)
                  self.presentiationMode.wrappedValue.dismiss()
                }),
                secondaryButton: .cancel())
        }
        
        Spacer()

        
        Button {
          self.showEditSheet.toggle()
        } label: {
          Image(systemName: "square.and.pencil")
        }
        .padding()
        .sheet(isPresented: $showEditSheet) {
          ComposeScene(showComposer: $showEditSheet, memo: self.memo)
            .environmentObject(self.store)
        }
      }
      .padding(.leading)
      .padding(.trailing)
    }
    .navigationBarTitle("메모 보기")
  }
}

struct DetailScene_Previews: PreviewProvider {
  static var previews: some View {
    DetailScene(memo:  MemoEntity(context: CoreDataManager.mainContext))
      .environmentObject(CoreDataManager.shared)
      .environmentObject(DateFormatter.memoDateFormater)
  }
}
