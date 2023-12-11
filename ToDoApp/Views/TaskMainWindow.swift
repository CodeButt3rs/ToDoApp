//
//  ContentView.swift
//  ToDoApp
//
//  Created by Владислав Лесовой on 07.12.2023.
//

import SwiftUI
import SwiftData

struct TaskMainWindow: View {
    @Query var tasks: [Task]
    @Environment(\.modelContext) private var ctx
    
    @State var isSheet: Bool = false
    @State var filterCompletion: Bool = false
    @State var selectedState: Int = 0
    
    let priorities: [Priority] = [
        Priority(id: 0, name: "Все"),
        Priority(id: 1, name: "Не выполненные"),
        Priority(id: 2, name: "Выполненные")
    ]
    var filterState: Bool {get{selectedState == 1 ? false : true }}
    
    var body: some View {
        NavigationStack{
            VStack(){
                Text("Фильтр выполненных")
                    .frame(alignment: .trailing)
                Picker("Выбор фильтра состояния задач", selection: $selectedState){
                    ForEach(priorities, id: \.id) { priority in
                        /*@START_MENU_TOKEN@*/Text(priority.name)/*@END_MENU_TOKEN@*/
                    }
                }
                .frame(width: 370)
                .pickerStyle(.segmented)
            }
            .opacity(tasks.isEmpty ? 0 : 1)
            .frame(width: 300, height: 50)
            List{
                ForEach(tasks.isEmpty ? tasks : selectedState != 0 ? try! tasks.filter(#Predicate<Task> {t in t.completed == filterState}) : tasks
                ){ i in
                    ZStack{
                        NavigationLink(destination: TaskEditForm(task: i)){ EmptyView()}
                            .opacity(0)
                        TaskPreView(task: i)
                    }
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .overlay(content: {
                if tasks.isEmpty {
                    ContentUnavailableView{
                        VStack{
                            Image(systemName: "list.bullet.clipboard")
                                .font(.system(size: 60))
                                .foregroundStyle(.gray)
                            Text("Тут нет задач...\nНо ничего не мешает создать новую!")
                                .font(.system(size: 16))
                                .foregroundStyle(.gray)
                                .padding(.top, 12)
                        }
                    }
                }
            })
            Button(action: {addTask()}, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.black)
                        .frame(width: 300, height: 75)
                    Text("Создать задачу")
                        .foregroundStyle(.white)
                }
            })
                .sheet(isPresented: $isSheet, content: {
                    TaskFormSheet()
                })
        }
        .navigationTitle("Just ToDoIt")
    }
    func addTask() -> Void{
        isSheet = !isSheet
    }
}

#Preview {
    TaskMainWindow()
        .modelContainer(for: Task.self, inMemory: true)
}
