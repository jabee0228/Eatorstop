//
//  ContentView.swift
//  Eatorstop
//
//  Created by James Chiang on 2021/9/9.
//

import SwiftUI
class UserInput: ObservableObject {
    @Published var sum:[Int] = [1]
    @Published var summ:[String] = ["1"]
}

struct ContentView: View {
    @StateObject var input = UserInput()
    @State var sum = 0
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(
                    destination: a1(),
                    label: {
                        Text("點進來計算熱量")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(40)
                    })
                NavigationLink(
                    destination: b1(),
                    label: {
                        Text("點進來計查看今日攝取")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(40)
                    })
                HStack{
                    Button(action: {
                        sum = 0
                        for i in 1...input.sum.count-1 {
                            sum = sum + input.sum[i]
                        }
                    }) {
                        Text("計算目前熱量")
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.green)
                            .cornerRadius(40)
                    }
                    Text(String(sum)+"大卡")
                        .font(.largeTitle)
                    
                }
            }
            
            .navigationTitle("今天還要繼續吃？")
        }
        .environmentObject(input)
    }
}
struct a1: View {
    var karange = [10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250,260,270,280,290,300]
    var ca = ["早餐","中餐","晚餐","甜點","宵夜"]
    @State var karl = 0
    @State var karlsum = 0
    @State var category = 0
    @State var categorysum = "0"
    @EnvironmentObject var input: UserInput
    var body: some View {
        VStack{
            Text("請在下方輸入熱量 單位：大卡")
                .font(.title2)
            Picker(selection: $karl, label: Text("請輸入熱量")) {
                ForEach (0..<karange.count){ i in
                    Text(String(karange[i])).tag(i)
                }
            }
            Text("請在下方輸入類別")
                .font(.title2)
            Picker(selection: $category, label: Text("請輸入類別")) {
                Text("早餐").tag(0)
                Text("中餐").tag(1)
                Text("晚餐").tag(2)
                Text("甜點").tag(3)
                Text("宵夜").tag(4)
            }
            Button(action: {
                karlsum = karange[karl]
                categorysum = ca[category]
                input.sum.append(karlsum)
                input.summ.append(categorysum)
                print(input.sum)
                print(input.summ)
            }) {
                Text("確認")
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.green)
                    .cornerRadius(40)
            }
        }
        
    }
    
}
struct b1: View {
    @EnvironmentObject var input: UserInput
    var text1 = " 大卡"
    var body: some View {
        //Text("單位：大卡")
        List{
            ForEach (1..<input.summ.count){ i in
                Text(input.summ[i] + " 熱量：" + String(input.sum[i]) + text1 )
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        a1()
        b1()
    }
}
