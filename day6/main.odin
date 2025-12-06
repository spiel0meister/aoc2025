package day6

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:slice"
import "core:text/match"

INPUT :: string(#load("input.txt"))

EXAMPLE :: `123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  `

Operator :: enum {
    Add,
    Mult
}

part1 :: proc(input: string) {
    input := input

    lines: [dynamic][]u64
    defer {
        for line in lines {
            delete(line)
        }
        delete(lines)
    }

    operators: [dynamic]Operator
    defer delete(operators)

    line_collector: [dynamic]u64
    defer delete(line_collector)

    for line in strings.split_lines_iterator(&input) {
        line := strings.trim_left_space(line)
        if match.is_digit(auto_cast line[0]) {
            for num_raw in strings.split_iterator(&line, " ") {
                line = strings.trim_left_space(line)

                num, ok := strconv.parse_u64_of_base(num_raw, 10)
                assert(ok)

                append(&line_collector, num)
            }

            append(&lines, slice.clone(line_collector[:]))
            clear(&line_collector)
        } else {
            for op_raw in strings.split_iterator(&line, " ") {
                line = strings.trim_left_space(line)

                if op_raw == "+" {
                    append(&operators, Operator.Add)
                } else if op_raw == "*" {
                    append(&operators, Operator.Mult)
                } else {
                    unreachable()
                }
            }
        }
    }

    sum := u64(0)
    for op, i in operators {
        result := u64(0)
        for line in lines {
            if op == .Add {
                result += line[i]
            } else {
                if result == 0 { result = 1 }
                result *= line[i]
            }
        }
        fmt.printfln("Result of column %d: %d", i + 1, result)
        sum += result
    }

    fmt.println("Sum:", sum)
}

part2 :: proc(input: string) {
    input := input

    lines: [dynamic][]string
    defer {
        for line in lines {
            delete(line)
        }
        delete(lines)
    }

    operators: [dynamic]Operator
    defer delete(operators)

    line_collector: [dynamic]string
    defer delete(line_collector)

    for line in strings.split_lines_iterator(&input) {
        line := strings.trim_left_space(line)
        if match.is_digit(auto_cast line[0]) {
            for len(line) > 0 {
                space_index := strings.index(line, " ")

                i := -1
                for j := space_index; j >= 0 && j < len(line) - 1; j += 1 {
                    if line[j] == ' ' && match.is_digit(auto_cast line[j + 1]) {
                        i = j
                        break
                    }
                }

                if i == -1 {
                    append(&line_collector, line)
                    break
                }

                num_raw := line[:i]
                line = line[i + 1:]

                append(&line_collector, num_raw)
            }

            append(&lines, slice.clone(line_collector[:]))
            clear(&line_collector)
        } else {
            for op_raw in strings.split_iterator(&line, " ") {
                line = strings.trim_left_space(line)

                if op_raw == "+" {
                    append(&operators, Operator.Add)
                } else if op_raw == "*" {
                    append(&operators, Operator.Mult)
                } else {
                    unreachable()
                }
            }
        }
    }

    sum := u64(0)
    for op, i in operators {
        result: u64
        if op == .Mult { result = 1 }

        longest_num := -1
        for line in lines {
            fmt.println("\"", line[i], "\"")
            if longest_num < len(line[i]) { longest_num = len(line[i]) }
        }

        fmt.println(longest_num)
    }

    fmt.println("Sum:", sum)
}

main :: proc() {
    when true {
        input := EXAMPLE
    } else {
        input := INPUT
    }

    part1(input)
}
