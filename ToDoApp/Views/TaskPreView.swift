//
//  TaskPreView.swift
//  ToDoApp
//
//  Created by Владислав Лесовой on 07.12.2023.
//

import SwiftUI

struct TaskPreView: View {
    
    @State var toDoName: String = "Test task"
    @State var toDoStatus: Bool = false
    @State var toDoDate: Date = .now
    
    var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(task.priority != 0 ? task.priority == 1 ? .orange : .red : .black )
                .shadow(radius: 3)
                .frame(width: 370, height: 100)
            VStack(alignment: .leading){
                HStack(){
                    VStack(alignment: .leading){
                        Text(toDoName)
                            .font(.custom("Roboto", size: 24))
                            .foregroundStyle(.white)
                        Text("Выполнить до: ")
                            .foregroundStyle(.white)
                        Text(toDoDate.formatted(date: .long, time: .shortened))
                            .foregroundStyle(.white)
                    }
                    .frame(width: 250, alignment: .leading)
//                    .border(.red)
                    VStack(alignment: .trailing){
                        RoundedRectangle(cornerRadius: 20)
                            .fill(toDoStatus ? .green : .gray)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .frame(width: 60, height: 60, alignment: .trailing)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)){
                            completeTask()
                        }
                    }
//                    .border(.red)
                }
            }
            .frame(maxWidth: 340, maxHeight: 90, alignment: .leading)
        }
        .frame(alignment: .leading)
        .onAppear{
            self.toDoName = task.name
            self.toDoStatus = task.completed
            self.toDoDate = task.date
        }
    }
        
    private func completeTask() -> Void{
        self.toDoStatus = !toDoStatus
        task.completed = !task.completed
    }
}

#Preview {
    TaskPreView(task: Task(name: "Сходить в спортазл"))
}
