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

get_largest_joltage_from_line :: proc(line: string, digit_count := 12) -> (largest: i64, ok: bool) {
    if len(line) < digit_count { return 0, false }

    if digit_count == 1 {
        largest := rune(0)
        for c in line {
            if c > largest { largest = c }
        }
        return i64(largest), true
    }

    largest = 0
    for c, i in line {
        lower_part := get_largest_joltage_from_line(line[i + 1:], digit_count - 1) or_continue
        the_num := i64(math.pow10_f32(f32(digit_count) - 1)) + lower_part

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
    for line in strings.split_lines_iterator(&input) {
        if len(line) < 2 { continue }

        joltage_num, _ := get_largest_joltage_from_line(line, 3)
        joltage = joltage_num
    }

    fmt.println("Joltage:", joltage)
}

part2 :: proc(input: string) {
    input := input

    joltage := i64(0)

    digits: [dynamic]i64
    defer delete(digits)

    for line in strings.split_lines_iterator(&input) {
        if len(line) < 12 { continue }

        line_start := 0
        for len(digits) < 12 {
            largest := rune(line[line_start])
            #reverse for c, i in line[line_start:len(line) - len(digits)] {
                if c > largest {
                    line_start = i
                    largest = c
                }
            }

            append(&digits, i64(largest))
        }

        num := i64(0)
        power := 1
        #reverse for d in digits {
            num = num * i64(math.pow_f32(10, f32(power))) + d
        }

        joltage += num
        clear(&digits)
    }

    fmt.println("Joltage:", joltage)
}

main :: proc() {
    when true {
        input := EXAMPLE
    } else {
        input := INPUT
    }

    part1(input)
}

