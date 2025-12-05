package day5

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:time"

INPUT :: string(#load("input.txt"))

EXAMPLE :: `3-5
10-14
16-20
12-18

1
5
8
11
17
32
`

Range :: struct {
    start, end: u64,
}

get_range_overlap_count :: proc(range1, range2: Range) -> u64 {
    if 
        range2.start <= range1.start && range1.start <= range2.end ||
        range2.start <= range1.end && range1.end <= range2.end || 
        range1.start <= range2.start && range2.start <= range1.end ||
        range1.start <= range2.end && range1.end <= range1.end {
        highest_start := range1.start if range1.start > range2.start else range2.start
        lowest_end := range1.end if range1.end < range2.end else range2.end
        return lowest_end - highest_start + 1
    }

    return 0
}

part1 :: proc(input: string) {
    input := input

    ranges: [dynamic]Range
    defer delete(ranges)

    for line in strings.split_lines_iterator(&input) {
        if len(line) == 0 { break }

        dash_index := strings.index(line, "-")

        start_num_raw := line[:dash_index]
        end_num_raw := line[dash_index + 1:]

        ok: bool
        start, end: u64

        start, ok = strconv.parse_u64_of_base(start_num_raw, 10)
        assert(ok)

        end, ok = strconv.parse_u64_of_base(end_num_raw, 10)
        assert(ok)

        append(&ranges, Range{start, end})
    }

    fresh_count := 0
    for line in strings.split_lines_iterator(&input) {
        num, ok := strconv.parse_u64_of_base(line, 10)
        assert(ok)

        invalid := true
        for range in ranges {
            if range.start <= num && num <= range.end {
                invalid = false
                break
            }
        }

        if !invalid {
            fresh_count += 1
        }
    }

    fmt.println("Fresh count:", fresh_count)
}

main :: proc() {
    when true {
        input := INPUT
    } else {
        input := EXAMPLE
    }

    ranges: [dynamic]Range
    defer delete(ranges)

    for line in strings.split_lines_iterator(&input) {
        if len(line) == 0 { break }

        dash_index := strings.index(line, "-")

        start_num_raw := line[:dash_index]
        end_num_raw := line[dash_index + 1:]

        ok: bool
        start, end: u64

        start, ok = strconv.parse_u64_of_base(start_num_raw, 10)
        assert(ok)

        end, ok = strconv.parse_u64_of_base(end_num_raw, 10)
        assert(ok)

        append(&ranges, Range{start, end})
    }

    num_count := u64(0)
    for range, i in ranges {
        range_size := range.end - range.start + 1
        for second_range in ranges[:i] {
            range_size -= get_range_overlap_count(range, second_range)
        }
        num_count += range_size
    }

    fmt.println("Different numbers:", num_count)
}
