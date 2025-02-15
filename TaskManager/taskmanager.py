import sys
import tkinter as tk
from tkinter import messagebox

tasks = []

def add_task():
    task = task_entry.get()
    if task:
        tasks.append({"task": task, "completed": False})
        update_task_list()
        task_entry.delete(0, tk.END)
    else:
        messagebox.showwarning("Warning", "Task cannot be empty!")

def delete_task():
    try:
        selected_index = task_listbox.curselection()[0]
        del tasks[selected_index]
        update_task_list()
    except IndexError:
        messagebox.showwarning("Warning", "No task selected!")

def mark_task_completed():
    try:
        selected_index = task_listbox.curselection()[0]
        tasks[selected_index]["completed"] = True
        update_task_list()
    except IndexError:
        messagebox.showwarning("Warning", "No task selected!")

def update_task_list():
    task_listbox.delete(0, tk.END)
    for task in tasks:
        status = "✔" if task["completed"] else "✗"
        task_listbox.insert(tk.END, f'{task["task"]} [{status}]')

def exit_app():
    root.quit()

root = tk.Tk()
root.title("Task Manager")

frame = tk.Frame(root)
frame.pack(pady=10)

task_entry = tk.Entry(frame, width=40)
task_entry.pack(side=tk.LEFT, padx=5)

add_button = tk.Button(frame, text="Add Task", command=add_task)
add_button.pack(side=tk.LEFT)

task_listbox = tk.Listbox(root, width=50, height=10)
task_listbox.pack(pady=10)

btn_frame = tk.Frame(root)
btn_frame.pack()

complete_button = tk.Button(btn_frame, text="Mark Completed", command=mark_task_completed)
complete_button.pack(side=tk.LEFT, padx=5)

delete_button = tk.Button(btn_frame, text="Delete Task", command=delete_task)
delete_button.pack(side=tk.LEFT, padx=5)

exit_button = tk.Button(root, text="Exit", command=exit_app)
exit_button.pack(pady=5)

root.mainloop()
