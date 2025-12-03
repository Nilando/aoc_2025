// cat day3.txt | nilang day3.nl

input = read;

fn part1() {
  result = 0;

  for bank in input.split('\n') {
    max = 0;
    i = 0;
    while i < #bank {
      k = i + 1;

      while k < #bank {
        n = int("{bank[i]}{bank[k]}");

        if n > max {
          max = n;
        }

        k = k + 1;
      }

      i = i + 1;
    } 

    result = result + max;
  }

  print("part1 🎁: {result}");
}


fn find_left_most_digits(bank_slice) {
  indexes = {};

  i = 0;
  while i < #bank_slice {
    c = int(bank_slice[i]);

    if indexes[c] == null {
      indexes[c] = i;
    }

    if #indexes.keys() == 9 {
      return indexes;
    }

    i = i + 1;
  }

  return indexes;
}

fn turn_on_n_batteries(bank, batteries_left_to_turn_on) {
  l = 0;
  result_str = "";

  while batteries_left_to_turn_on != 0 {
    bank_slice = bank.slice(l, (#bank - (batteries_left_to_turn_on - 1)));
    left_most_digits = find_left_most_digits(bank_slice);
    highest_digit = left_most_digits.keys().sort(fn (a, b) {
      a > b;
    }).last();

    l = l + left_most_digits[highest_digit] + 1;
    result_str << str(highest_digit);
    batteries_left_to_turn_on = batteries_left_to_turn_on - 1;
  }

  return int(result_str);
}

fn part1() {
  result = 0;

  for bank in input.split('\n') {
    result = result + turn_on_n_batteries(bank, 2);
  }

  print("part1 💫: {result}");
}

fn part2() {
  result = 0;

  for bank in input.split('\n') {
    result = result + turn_on_n_batteries(bank, 12);
  }

  print("part2 🎅: {result}");
}

part1();
part2();

