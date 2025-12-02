package day2

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:math"

part1 :: proc(input: string) {
    input := input

    invalid_sum := 0
    for range in strings.split_iterator(&input, ",") {
        dash_index := strings.index_byte(range, '-')
        assert(dash_index >= 0)

        range_start_raw := range[:dash_index]
        range_end_raw := range[dash_index + 1:]

        range_start, start_ok := strconv.parse_int(range_start_raw)
        assert(start_ok)

        range_end, end_ok := strconv.parse_int(range_end_raw)
        assert(end_ok)

        for num in range_start..=range_end {
            as_string := fmt.tprint(num)
            if len(as_string) % 2 != 0 { continue }

            first_half := as_string[:len(as_string)/2]
            second_half := as_string[len(as_string)/2:]

            if first_half == second_half {
                invalid_sum += num
            }
        }
    }

    fmt.println("Invalid count:", invalid_sum)
}

part2 :: proc(input: string) {
    input := input

    invalid_sum := 0
    for range in strings.split_iterator(&input, ",") {
        dash_index := strings.index_byte(range, '-')
        assert(dash_index >= 0)

        range_start_raw := range[:dash_index]
        range_end_raw := range[dash_index + 1:]

        range_start, start_ok := strconv.parse_int(range_start_raw)
        assert(start_ok)

        range_end, end_ok := strconv.parse_int(range_end_raw)
        assert(end_ok)

        for num in range_start..=range_end {
            as_string := fmt.tprint(num)

            outer: for i in 1..=len(as_string) / 2 {
                part := as_string[:i]
                as_string := as_string[i:]

                for len(as_string) > 0 {
                    if j := strings.index(as_string, part); j == 0 {
                        as_string = as_string[len(part):]
                        continue
                    }

                    continue outer
                }

                invalid_sum += num
                break
            }
        }
    }

    fmt.println("Invalid sum:", invalid_sum)
}

INPUT :: "851786270-851907437,27-47,577-1044,1184-1872,28214317-28368250,47766-78575,17432-28112,2341-4099,28969-45843,5800356-5971672,6461919174-6461988558,653055-686893,76-117,2626223278-2626301305,54503501-54572133,990997-1015607,710615-802603,829001-953096,529504-621892,8645-12202,3273269-3402555,446265-471330,232-392,179532-201093,233310-439308,95134183-95359858,3232278502-3232401602,25116215-25199250,5489-8293,96654-135484,2-17"

main :: proc() {
    input := INPUT

    // part1(input)
    part2(input)
}
