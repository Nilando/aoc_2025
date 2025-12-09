input = read;

fn partition(A, lo, hi, comp) {
  // Use median-of-three pivot selection for better performance
  mid = lo + ((hi - lo) / 2);

  // Sort lo, mid, hi and use middle value as pivot
  if comp(A[lo], A[mid]) {
    t = A[lo];
    A[lo] = A[mid];
    A[mid] = t;
  }
  if comp(A[lo], A[hi]) {
    t = A[lo];
    A[lo] = A[hi];
    A[hi] = t;
  }
  if comp(A[mid], A[hi]) {
    t = A[mid];
    A[mid] = A[hi];
    A[hi] = t;
  }

  pivot = A[mid];

  i = lo - 1;
  k = hi + 1;

  while true {
    i = i + 1;
    k = k - 1;

    while !comp(A[i], pivot) {
      i = i + 1;
    }

    while comp(A[k], pivot) {
      k = k - 1;
    }

    if i >= k {
      return k;
    }

    t = A[i];
    A[i] = A[k];
    A[k] = t;
  }
}

fn inner_quicksort(A, lo, hi, comp) {
  if lo < hi {
    p = partition(A, lo, hi, comp);
    inner_quicksort(A, lo, p, comp);
    inner_quicksort(A, p + 1, hi, comp);
  }
}

fn sort(numbers, comp) {
  inner_quicksort(numbers, 0, #numbers - 1, comp);
  return numbers;
}

fn calc_distance(a, b) {
  (a[0] - b[0]).pow(2)
    + (a[1] - b[1]).pow(2)
    + (a[2] - b[2]).pow(2);
}

boxes = input
  .split('\n')
  .filter(fn(i) { i != ""; })
  .map(fn(l) { 
    l.split(',').map(fn(i) { int(i); });
  });

pairs = [];

i = 0;
while i < #boxes {
  k = i + 1;
  while k < #boxes {
    d = calc_distance(boxes[i], boxes[k]);
    pairs << [d, i, k];
    k = k + 1;
  }
  print("{i}");
  i = i + 1;
}

sorted_connections = sort(pairs, fn(a, b) { a[0] > b[0]; });
print("sorted");

N = 1000;

patch($list, $uniq, fn(self) {
  result = {};

  for v in self {
    if result[v] == null {
      result[v] = true;
    }
  }

  return result.keys();
});

n_closest_neighbors = sorted_connections.slice(0, N).map(fn(p) { p[1]; });

print(n_closest_neighbors);
circuits = map((#boxes).times(fn(i) { [i, [i]]; }));

fn connect_boxes(pair) {
  a = pair[0];
  b = pair[1];

  if circuits[a] == circuits[b] {
    return;
  }

  new_circuit = (circuits[a]).concat(circuits[b]);

  if #new_circuit == #boxes {
    print("part2 {boxes[a][0] * boxes[b][0]}");
    return;
  }

  for c in new_circuit {
    circuits[c] = new_circuit;
  }
}

for pair in n_closest_neighbors {
  connect_boxes(pair);
}

three_largest_circuits = circuits
  .values()
  .uniq()
  .sort(fn(a, b) { #a < #b; })
  .slice(0,3);

//print(three_largest_circuits);
part1 = three_largest_circuits.reduce(fn(acc, x) { return acc * #x; }, 1);

print("part1 {part1}");

ps = calc_distances(boxes).slice(N, #calc_distances).map(fn(p) { p[1]; });

for pair in ps {
  connect_boxes(pair);
  if #(@circuits[0]) == #boxes {
    break;
  }
}
