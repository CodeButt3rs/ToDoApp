//
//  TaskFormSheet.swift
//  ToDoApp
//
//  Created by Владислав Лесовой on 07.12.2023.
//

import SwiftUI

struct TaskFormSheet: View {
    @Environment(\.modelContext) private var ctx
    @Environment(\.dismiss) var dismiss
    
    @State var date: Date = .now
    @State var name: String = ""
    @State var details: String = ""
    @State var completed: Bool = false
    @State var priority: Int = 0
    
    let priorities: [Priority] = [
        Priority(id: 0, name: "Обычная"),
        Priority(id: 1, name: "Важная"),
        Priority(id: 2, name: "Критичная")
    ]
    var body: some View {
        VStack{
            NavigationStack{
                Form{
                    Section{
                        Text("Название задачи")
                        TextField("Название", text: $name)
                    }
                    Section{
                        Text("Подробности задачи")
                        TextField("Подробности", text: $details, axis: .vertical)
                            .lineLimit(10)
                    }
                    Section{
                        DatePicker("Срок", selection: $date)
                    }
                    Section{
                        Toggle("Выполнение", isOn: $completed)
                    }
                    Section{
                        Text("Важность задачи")
                        Picker("Важность", selection: $priority){
                            ForEach(priorities, id: \.id){i in
                                Text(i.name)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    Button(action: {
                        addTask()
                    }, label: {
                        Text("Создать задачу")
                    })
                }
            }
            .navigationBarTitle("Создание задачи")
        }
    }
    
    private func addTask() -> Void{
        let task: Task = Task(
            date: self.date,
            name: self.name,
            details: self.details,
            completed: self.completed,
            priority: self.priority
        )
        ctx.insert(task)
        try! ctx.save()
        dismiss()
    }
}

#Preview {
    TaskFormSheet()
}
