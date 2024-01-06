//
//  ContentView.swift
//  calendarView+swiftUI
//
//  Created by 青山凱 on 2024/01/06.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectDate: String = ""
    
    var body: some View {
        
        Text("カレンダー").font(.title)
            .padding(.top, 50)
        
        CalendarView(didSelectDate: { dateComponents in
            guard let year = dateComponents.year,
                  let month = dateComponents.month,
                  let day = dateComponents.day else {
                return
            }
            print("year: \(year), month: \(month), day: \(day)")
            selectDate = "year: \(year), month: \(month), day: \(day)"
        }, iconDate: 19)
        .padding()
        
        Text(selectDate).font(.title)
    }
}

#Preview {
    ContentView()
}
