// cat day5.txt | nilang day5.nl

input = read;
part1 = 0;

ranges = [];
ingredient_ids = [];

flag = true;
for line in input.split('\n') {
  if line == "" {
    flag = false;
    continue;
  }

  if flag {
    split_line = line.trim().split('-');

    ranges << [int(split_line[0]), int(split_line[1])];
  } else {
    ingredient_ids << int(line);
  }
}

for id in ingredient_ids {
  for range in ranges {
    if range[0] <= id && id <= range[1] {
      part1 = part1 + 1;
      break;
    }
  }
}

print("part1 🎁: {part1}");

// ******* PART 2 BELOW ********

fn in_range(range, n) {
  return range[0] <= n && n <= range[1];
}

fn combine_ranges(this, other) {
  if other[0] < this[0] && this[1] < other[1] {
    this[0] = other[0];
    this[1] = other[1];
    return true;
  }

  if in_range(this, other[0]) || in_range(this, other[1]) {
    if other[0] < this[0] {
      this[0] = other[0];
    }

    if this[1] < other[1]{
      this[1] = other[1];
    }

    return true;
  }

  if other[1] + 1 == this[0] {
    this[0] = other[0];
    return true;
  }

  if this[1] + 1 == other[0] {
    this[1] = other[1];
    return true;
  }

  return false;
}

fn combine_list_of_ranges(ranges) {
  combined_ranges = [];

  for range_x in ranges {
    combined_flag = false;

    for range_y in combined_ranges {
      combined = combine_ranges(range_y, range_x);

      combined_flag = combined_flag || combined;
    }

    if !combined_flag {
      combined_ranges << range_x;
    }
  }
  
  return combined_ranges.sort(fn(a, b) { a[0] > b[0]; });
}

while true {
  combined = combine_list_of_ranges(ranges);

  if combined == ranges {
    ranges = combined;
    break;
  }

  ranges = combined;
}

part2 = 0;
for range in ranges {
  part2 = part2 + 1 + (range[1] - range[0]);
}

print("part2 😭: {part2}");
