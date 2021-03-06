//
//  Mastering SwiftUI
//  Copyright (c) KxCoding <help@kxcoding.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import SwiftUI

struct View_TextField: View {
  
  @State private var name: String = ""
  @State private var password: String = ""
  
  var body: some View {
    VStack {
      Text("TextField")
        .font(.largeTitle)
      
      Text("input: \(name)")
        .font(.title)
        .foregroundColor(.secondary)
      
      //
      TextField("Input Something",
                text: $name,
                onEditingChanged: { changed in // 텍스트 필드에 포커싱 되었을때 true 벗어날때 false
                  print(changed)
                },
                onCommit: { // 키보드 리턴키 입력 시 호출
                  print("commit")
                })
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .font(.title)
//        .keyboardType(.numberPad)
//        .textContentType(.username)
//        .autocapitalization(.none) // 첫 대문자 설정
//        .disableAutocorrection(true) // 자동 수정 비활성화 true
      
      SecureField("Input Password", text: $password)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      Spacer()
    }
  }
}

struct View_TextField_Previews: PreviewProvider {
  static var previews: some View {
    View_TextField()
  }
}
