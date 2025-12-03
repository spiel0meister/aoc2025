package day3

import "core:fmt"
import "core:strings"
import "core:math"

INPUT :: string(#load("input.txt"))

EXAMPLE :: `
987654321111111
811111111111119
234234234234278
818181911112111
`

get_largest_joltage_from_line :: proc(line: string, digit_count := 12) -> (largest: i64 = 0, ok: bool = false) {
    if len(line) < digit_count { return }

    if digit_count == 1 {
        largest := rune(0)
        for c in line {
            if c > largest { largest = c }
        }
        return i64(largest - '0'), true
    }

    largest_index := 0
    for i := len(line) - digit_count; i >= 1; i -= 1 {
        if rune(line[largest_index]) <= rune(line[i]) { largest_index = i }
    }

    fmt.println(line, largest_index)

    for c, i in line[largest_index:] {
        if len(line) - i < digit_count { continue }

        lower_part := get_largest_joltage_from_line(line[largest_index + i + 1:], digit_count - 1) or_break
        d := i64(c - '0')
        zeros := i64(math.pow10_f64(f64(digit_count) - 1))
        the_num := d * zeros + lower_part

        if largest < the_num {
            largest = the_num
        }
    }

    ok = true
    return
}

part1 :: proc(input: string) {
    input := input

    joltage := i64(0)
    line_count := 0
    for line in strings.split_lines_iterator(&input) {
        if len(line) < 2 { continue }

        joltage_num, _ := get_largest_joltage_from_line(line, 2)
        joltage += joltage_num

        line_count += 1
    }

    fmt.println("Joltage:", joltage)
}

part2 :: proc(input: string) {
    input := input

    joltage := i64(0)
    line_count := 0
    for line in strings.split_lines_iterator(&input) {
        if len(line) < 12 { continue }
        // fmt.printf("\rOn line %d", line_count)

        joltage_num, _ := get_largest_joltage_from_line(line, 12)
        joltage += joltage_num

        line_count += 1
    }
    fmt.println()

    fmt.println("Joltage:", joltage)
}

main :: proc() {
    when true {
        input := EXAMPLE
    } else {
        input := INPUT
    }

    part2(input)
}

