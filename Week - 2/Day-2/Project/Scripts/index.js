const dataContainer = document.getElementById("my-list");
const taskInput = document.getElementById("new-task");
const taskForm = document.getElementById("my-form");

let IS_EDITING = false;
let CURRENT_TASK_ID = null;

taskForm.addEventListener("submit", (event) => {
  event.preventDefault();
  const taskText = taskInput.value.trim();
  if (!taskText) return;

  if (IS_EDITING) {
    updateTask(CURRENT_TASK_ID, taskText);
  } else {
    addTask(taskText);
  }
  resetInput();
});

window.addEventListener("load", () => {
  loadTasks();
  taskInput.focus();
});

function addTask(taskText) {
  const tasks = getTasks();
  tasks.push({ id: Date.now(), text: taskText });
  saveTasks(tasks);
}

function loadTasks() {
  dataContainer.innerHTML = "";
  const tasks = getTasks();
  tasks.forEach(createTaskElement);
}

function createTaskElement(task) {
  const taskDiv = document.createElement("div");
  taskDiv.classList.add("task");
  taskDiv.textContent = task.text;

  const editBtn = createButton("Edit", "edit-button", () => editTask(task.id));
  const deleteBtn = createButton("Delete", "delete-button", () =>
    removeTask(task.id)
  );

  taskDiv.appendChild(editBtn);
  taskDiv.appendChild(deleteBtn);
  dataContainer.appendChild(taskDiv);
}

function createButton(text, className, onClick) {
  const button = document.createElement("button");
  button.textContent = text;
  button.classList.add(className);
  button.addEventListener("click", onClick);
  return button;
}

function removeTask(taskId) {
  if (confirm("Do you want to delete this task?")) {
    const tasks = getTasks().filter((task) => task.id !== taskId);
    saveTasks(tasks);
  }
}

function editTask(taskId) {
  const task = getTasks().find((task) => task.id === taskId);
  if (task) {
    taskInput.value = task.text;
    taskInput.focus();
    CURRENT_TASK_ID = taskId;
    IS_EDITING = true;
  }
}

function updateTask(taskId, newText) {
  const tasks = getTasks().map((task) =>
    task.id === taskId ? { ...task, text: newText } : task
  );
  saveTasks(tasks);
}

function resetInput() {
  taskInput.value = "";
  IS_EDITING = false;
  CURRENT_TASK_ID = null;
}

function getTasks() {
  return JSON.parse(localStorage.getItem("tasks")) || [];
}

function saveTasks(tasks) {
  localStorage.setItem("tasks", JSON.stringify(tasks));
  loadTasks();
}
