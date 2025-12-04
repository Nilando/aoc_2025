// cat day4.txt | nilang day4.nl

input = read;
grid = [];

// oof is all i have to say about this function
fn count_neighbors(row, col) {
  count = 0;
  not_right_edge = (col+1) < #grid;
  not_bottom_edge = (row+1) < #grid;

  if 0 < row && grid[row - 1][col] {
      count = count + 1;
  }

  if 0 < row && 0 < col && grid[row - 1][col - 1] {
      count = count + 1;
  }

  if 0 < row && not_right_edge && grid[row - 1][col + 1] {
      count = count + 1;
  }

  if 0 < col && grid[row][col - 1] {
      count = count + 1;
  }

  if not_right_edge && grid[row][col + 1] {
      count = count + 1;
  }

  if not_bottom_edge && grid[row + 1][col] {
      count = count + 1;
  }

  if not_bottom_edge && 0 < col && grid[row + 1][col - 1] {
      count = count + 1;
  }

  if not_bottom_edge && not_right_edge && grid[row + 1][col + 1] {
      count = count + 1;
  }

  return count;
}

for line in input.split('\n') {
  row = [];

  for c in line {
    row << (c == "@");
  }

  grid << row;
}

part1 = 0;

row = 0;
while row < #grid {
  col = 0;

  while col < #grid[0] {
    if !grid[row][col] {
      col = col + 1;
      continue;
    }

    n = count_neighbors(row, col);

    if n < 4 {
      part1 = part1 + 1;
    }

    col = col + 1;
  }

  row = row + 1;
}


removed = 0;
removed_flag = true;
while removed_flag {
  removed_flag = false;
  row = 0;
  while row < #grid {
    col = 0;

    while col < #grid[0] {
      if !grid[row][col] {
        col = col + 1;
        continue;
      }

      n = count_neighbors(row, col);

      if n < 4 {
        grid[row][col] = false;
        removed_flag = true;
        removed = removed + 1;
      }

      col = col + 1;
    }

    row = row + 1;
  }
}

print("part1 ❄️: {part1}");
print("part2 ⛄️: {removed}");
