//
//  CalendarView.swift
//  calendarView+swiftUI
//
//  Created by 青山凱 on 2024/01/06.
//

import Foundation
import UIKit
import SwiftUI

struct CalendarView: UIViewRepresentable {
    let didSelectDate: (_ dateComponents: DateComponents) -> Void
    let iconDates: [DateComponents]
    
    // Coordibatorのクラスを定義。こいつが選択のdelegateに順序している。
    final public class Coordinator: NSObject, UICalendarSelectionSingleDateDelegate, UICalendarViewDelegate {
        let didSelectDate: (_ dateComponents: DateComponents) -> Void
        let iconDates: [DateComponents]
        
        //  ここのinitで、浴びた日付を渡すことができれば、特定の日付にマークをつけることはできそう。
        init(didSelectDate: @escaping (_: DateComponents) -> Void, iconDates: [DateComponents]) {
            self.didSelectDate = didSelectDate
            self.iconDates = iconDates
        }
        
        //  didSelectDateのクロージャに対して、dateComponentsをdelegate発火時に渡すことで、swiftUI側にデータを渡している。
        public func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            guard let dateComponents = dateComponents else {
                return
            }
            didSelectDate(dateComponents)
        }
        
        public func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            
            guard let currentYear = dateComponents.year,
                  let currentMonth = dateComponents.month,
                  let currentDay = dateComponents.day
            else { return nil }
            
            let isShowIcon = iconDates.contains { hitDate in
                
                guard let hitYear = hitDate.year,
                      let hitMonth = hitDate.month,
                      let hitDay = hitDate.day
                else { return false }
                
                return currentYear == hitYear && currentMonth == hitMonth && currentDay == hitDay
            }
            
            if isShowIcon {
                return .customView {
                    let image = UIImage(named: "tele2")
                    let view = UIImageView(image: image)
                    view.frame = .init(x: 0, y: 0, width: 10, height: 10)
                    return view
                }
            } else {
                return nil
            }
        }
    }
    
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(didSelectDate: didSelectDate, iconDates: iconDates)
    }
    
    
    func makeUIView(context: Context) -> some UIView {
        let calendarView = UICalendarView()
        
        calendarView.locale = Locale(identifier: "ja")
        
        calendarView.delegate = context.coordinator
        
        //  ここで、cotextで、作成したdelegateに準拠したCoordinatorを、引数に渡している。
        let selection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        calendarView.selectionBehavior = selection
        return calendarView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
