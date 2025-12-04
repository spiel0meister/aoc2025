package day4

import "core:fmt"
import "core:strings"

EXAMPLE :: `..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
`

INPUT :: string(#load("input.txt"))

count_neighbors :: proc(grid: []bool, width, height: int, row, col: int) -> int {
    count := 0

    /*
    if row < height - 1 && col < width - 1 && grid[(row + 1) * width + (col + 1)] {
        count += 1
    }

    if row > 0 && col > 0 && grid[(row - 1) * width + (col - 1)] {
        count += 1
    }

    if col < width - 1 && grid[row * width + (col + 1)] {
        count += 1
    }

    if row < height - 1 && grid[(row + 1) * width + col] {
        count += 1
    }

    if row > 0 && grid[(row - 1) * width + col] {
        count += 1
    }

    if col > 0 && grid[row * width + (col - 1)] {
        count += 1
    }

    if row < height - 1 && col > 0 && grid[(row + 1) * width + (col - 1)] {
        count += 1
    }

    if row > 0 && col < width - 1 && grid[(row - 1) * width + (col + 1)] {
        count += 1
    }
    */

    for drow in -1..=1 {
        for dcol in -1..=1 {
            i := (row + drow) * width + (col + dcol)
            if i < 0 || i >= len(grid) { continue }

            if grid[i] { count += 1 }
        }
    }

    return count
}

main :: proc() {
    // input := INPUT
    input := EXAMPLE

    width := strings.index(input, "\n")
    height := strings.count(input, "\n")

    grid: []bool = make([]bool, width * height)
    defer delete(grid)

    input_copy := input
    line_index := 0
    for line in strings.split_lines_iterator(&input_copy) {
        for c, i in line {
            grid[line_index * width + i] = (c == '@')
        }
        line_index += 1
    }

    access_count := 0
    for _, i in grid {
        row := i / width
        col := i % width

        n := count_neighbors(grid, width, height, row, col)
        if n < 4 {
            access_count += 1
        }
    }

    fmt.printfln("Free: %v", access_count)
}

