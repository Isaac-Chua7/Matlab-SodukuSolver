# 🔢 MATLAB Sudoku Solver

A MATLAB application developed during my first semester of the **Bachelor of Computer Science (Advanced)** at the **University of Adelaide**. The program solves standard 9×9 Sudoku puzzles using a backtracking algorithm while providing a visual demonstration of the solving process.

## ✨ Features

* 🧩 Solves standard 9×9 Sudoku puzzles.
* ⚡ Implements a recursive backtracking algorithm.
* 👀 Visualises the solving process step-by-step.
* ✅ Validates moves according to Sudoku rules.
* 🎓 Demonstrates recursive algorithms and problem-solving techniques in MATLAB.

## 🎥 Demo

<div align="center">

### 📺 Solver Preview

<img src="SodukuSolverAssets/MATLAB_Soduku.gif" width="500">

*Watch the solver complete a Sudoku puzzle.*

<br><br>

### ▶️ Video Walkthrough

<a href="https://www.youtube.com/watch?v=GpqnEvF3qjw">
  <img src="SodukuSolverAssets/thumbnail.png" width="500">
</a>

**⬆️ Click the preview above to watch the full walkthrough on YouTube.**

</div>

## 🧠 How It Works

The solver first applies **logical deduction** to simplify the puzzle. It scans each empty cell and checks whether only one valid number can be placed there based on the existing values in the same **row**, **column**, and **3×3 subgrid**. Any cells with a single possible value are filled in immediately.

If logical deduction alone cannot complete the puzzle, the solver switches to a **recursive backtracking algorithm**. It systematically tests possible values, backtracking whenever a choice leads to an invalid board state, until a complete and valid solution is found.

By combining deterministic logic with backtracking, the solver efficiently solves puzzles while reducing the amount of brute-force searching required.


## 🛠️ Built With

* MATLAB
* Recursive Backtracking Algorithm

## 🚀 Getting Started

1. Open the project in MATLAB.
2. Run the main script.
3. Enter or load a valid Sudoku puzzle.
4. Watch the solver find the solution step by step.
