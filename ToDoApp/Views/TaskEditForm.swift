//
//  TaskFormSheet.swift
//  ToDoApp
//
//  Created by Владислав Лесовой on 07.12.2023.
//

import SwiftUI
import SwiftData

struct TaskEditForm: View {
    @Environment(\.modelContext) private var ctx
    @Environment(\.dismiss) var dismiss
    
    @State var date: Date = .now
    @State var name: String = ""
    @State var details: String = ""
    @State var completed: Bool = false
    @State var priority: Int = 0
    
    var task: Task
    init(task: Task) {
        self.task = task
    }
    
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
                    Button(action: {editTask()}, label: {
                        Text("Сохранить задачу")
                    })
                    Section{
                        Button(action: {deleteTask()}, label: {
                            Text("Удалить задачу")
                                .foregroundStyle(.red)
                        })
                    }
                }
            }
            .navigationBarTitle("Изменение задачи")
        }
        .onAppear(perform: { onAppearFunc() })
    }
    
    private func editTask() -> Void{
        task.name = self.name
        task.date = self.date
        task.details = self.details
        task.completed = self.completed
        task.priority = self.priority
        try! ctx.save()
        dismiss()
    }
    
    private func deleteTask() -> Void{
        ctx.delete(task)
        try! ctx.save()
        dismiss()
    }
    
    private func onAppearFunc() -> Void{
        self.date = task.date
        self.name = task.name
        self.details = task.details
        self.completed = task.completed
        self.priority = task.priority
    }
}

#Preview {
    TaskEditForm(task: Task(name: "Huy"))
}
