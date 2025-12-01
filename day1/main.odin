package day1

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

diff :: proc(a, b: int) -> int {
    if a < b { return b - a }
    return a - b
}

EXAMPLE :: `
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
`

main :: proc() {
    file_content_bytes, ok := os.read_entire_file("input.txt")
    if !ok { return }

    dial := 50
    zero_count := 0

    when true {
        file_content := string(file_content_bytes)
    } else {
        file_content := strings.trim_space(EXAMPLE)
    }

    for line in strings.split_iterator(&file_content, "\n") {
        line := line

        direction := line[0]
        line = line[1:]

        amount, ok := strconv.parse_int(line)
        assert(ok)

        step := 0

        if direction == 'R' {
            step = 1
        } else if direction == 'L' {
            step = -1
        } else {
            unreachable()
        }

        for amount > 0 {
            dial += step
            if dial == -1 {
                dial = 99
            } else if dial == 100 {
                dial = 0
            }

            if dial == 0 {
                zero_count += 1
            } 

            amount -= 1
        }
    }

    fmt.printfln("Zero count: %d", zero_count)
}
