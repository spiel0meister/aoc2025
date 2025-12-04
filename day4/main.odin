package day4

import "core:container/bit_array"
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

    return count
}

part1 :: proc(input: string) {
    input := input

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
    
    for row in 0..<height {
        for col in 0..<width {
            fmt.printf("%v ", grid[row * width + col])
        }
        fmt.println()
    }

    access_count := 0
    for v, i in grid {
        if !v { continue }

        row := i / width
        col := i % width

        n := count_neighbors(grid, width, height, row, col)
        if n < 4 {
            access_count += 1
        }
    }

    fmt.printfln("Free: %v", access_count)
}

main :: proc() {
    input := INPUT

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
    
    for row in 0..<height {
        for col in 0..<width {
            fmt.printf("%v ", grid[row * width + col])
        }
        fmt.println()
    }

    access_count := 0
    for v, i in grid {
        if !v { continue }

        row := i / width
        col := i % width

        n := count_neighbors(grid, width, height, row, col)
        if n < 4 {
            access_count += 1
        }
    }

    fmt.printfln("Free: %v", access_count)
}

