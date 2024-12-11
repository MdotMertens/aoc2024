DIRECTIONS = {
    "^": (-1, 0),
    ">": (0, 1),
    "v": (1, 0),
    "<": (0, -1),
}

def generate_direction_list(start_char) -> list[str]:
    if start_char not in DIRECTIONS:
        raise ValueError(f"Invalid start character: {start_char}")

    keys = list(DIRECTIONS.keys())
    start_index = keys.index(start_char)
    return keys[start_index:] + keys[:start_index]

def generate_bounds(lines) -> tuple:
    return (len(lines), len(lines[0]))

def read_puzzle(lines) -> tuple[tuple, str, list[tuple], tuple]:
    obstacles = []
    guard = (0, 0)
    direction = ""
    bounds = (len(lines), len(lines[0]))
    for x, line in enumerate(lines):
        for y, char in enumerate(line):
            if char == "#":
                obstacles.append((x, y))
            if char in DIRECTIONS.keys():
                direction = char
                guard = (x, y)
    return guard, direction, obstacles, bounds

puzzle_input = """....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#..."""

lines = puzzle_input.split("\n")
guard, direction, obstacles, bounds = read_puzzle(lines)
directions = generate_direction_list(direction)
turns = 0  
visited = set()

while 0 <= guard[0] < bounds[0] and 0 <= guard[1] < bounds[1]:
    p_move = (guard[0] + DIRECTIONS[direction][0], guard[1] + DIRECTIONS[direction][1])
    if p_move in obstacles:  # If there's an obstacle in front
        turns += 1
        direction = directions[turns % len(directions)]  # Turn right, but don't change position
    else:
        guard = p_move  # Move forward to the next valid position
        visited.add(guard)

print(f"Total steps: {len(visited)}")

