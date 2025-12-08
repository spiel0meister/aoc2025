package day7

import "core:fmt"
import "core:strings"
import "core:slice"

INPUT :: string(#load("input.txt"))

EXAMPLE :: `.......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............
`

Cell :: enum (i32) {
    Start = 'S',
    Empty = '.',
    Split = '^',
}

Pos :: struct { row, column: int }

cache: map[Pos]int

get_split_count :: proc(cells: []Cell, width, height: int, row, column: int) -> (count: int = 0) {
    if column < 0 || column >= width { return 0 }

    row := row
    pos := Pos{ row, column }
    for row < height {
        if cells[row * width + column] == .Split {
            count = 1

            left_pos := Pos{ row, column - 1 }
            if 0 <= left_pos.column && left_pos.column < width {
                if left_pos not_in cache { count += get_split_count(cells, width, height, row, left_pos.column) }
            }

            right_pos := Pos{ row, column + 1 }
            if 0 <= right_pos.column && right_pos.column < width {
                if right_pos not_in cache { count += get_split_count(cells, width, height, row, right_pos.column) }
            }

            break
        }

        row += 1
    }

    cache[pos] = count
    return
}

main :: proc() {
    defer delete(cache)

    when false {
        input := EXAMPLE
    } else {
        input := INPUT
    }

    width := strings.index(input, "\n")
    height := strings.count(input, "\n")

    cells: []Cell = make([]Cell, width * height)
    defer delete(cells)

    row := 0
    for line in strings.split_lines_iterator(&input) {
        for c, i in line {
            cell := transmute(Cell)c
            cells[row * width + i] = cell
        }

        row += 1
    }

    start_index := -1
    for cell, i in cells {
        if cell == .Start {
            start_index = i
            break
        }
    }
    assert(start_index != -1)

    split_count := get_split_count(cells, width, height, 0, start_index)
    fmt.println("Split count:", split_count)
}

