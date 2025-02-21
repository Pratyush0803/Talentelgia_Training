document.getElementById("my-form").addEventListener("submit", function(event) {
  event.preventDefault();
  addTask();
});

function addTask() {
  const newTask = document.getElementById("new-task").value.trim();
  if (newTask !== "") {
      const p = document.createElement("p");
      p.textContent = newTask;
      p.classList.add("task");
      document.getElementById("my-list").appendChild(p);
      document.getElementById("new-task").value = ""; 
      localStorage.setItem
  }
}