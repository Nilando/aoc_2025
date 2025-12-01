// cat day1.txt | nilang day1.nl

input = read;
part1 = 0;
part2 = 0;
dial = 50;

for line in input.split('\n') {
  line = line.trim();
  direction = line[0];
  distance = int(line.slice(1, #line));
  prev_dial = dial;

  if direction == "R" {
    dial = dial + distance;
  } else {
    dial = dial - distance;
  }

  if dial == 0 {
    part2 = part2 + 1;
  }

  if dial < 0 && prev_dial != 0 {
      part2 = part2 + 1;
    }
  }
  
  part2 = part2 + (dial.abs() / 100);

  if dial < 0 {
    dial = ((dial % 100) + 100) % 100;
  } else {
    dial = dial % 100;
  }

  // print(dial);

  if dial == 0 {
    part1 = part1 + 1;
  }
}

print("part1 🎁: {part1}");
print("part2 ✨: {part2}");
