// cat day2.txt | nilang day2.nl

input = read;
@part1 = 0;
@part2 = 0;

fn part2(id_str) {
  if (#id_str % 2) != 0 {
    return;
  }

  first_half = id_str.slice(0, #id_str / 2);
  second_half = id_str.slice(#id_str / 2, #id_str);

  if first_half == second_half {
    // print("INVALID: {id_str}");
    @part1 = @part1 + int(id_str);
    return;
  }
}

fn part1(id_str) {
  i = 1;
  while i < #id_str {
    if (#id_str % i) != 0 {
      i = i + 1;
      continue;
    }

    first_slice = id_str.slice(0, i);

    invalid = true;
    k = i;
    while k < #id_str {
      next_slice = id_str.slice(k, k + i);

      if next_slice != first_slice {
        invalid = false;
        break;
      }

      k = k + i;
    }

    if invalid {
      // print("INVALID: {id_str}");
      @part2 = @part2 + int(id_str);
      return;
    }
    i = i + 1;
  }
}

for id_range in input.split(',') {
  first_and_last = id_range.split('-');
  first_id = int(first_and_last[0]);
  last_id = int(first_and_last[1]);

  id = first_id;
  while id <= last_id {
    id_str = str(id);

    part1(id_str);
    part2(id_str);

    id = id + 1;
  }

  print("{first_id} : {last_id}");
}

print("part1 🎁: {@part1}");
print("part2 ✨: {@part2}");
