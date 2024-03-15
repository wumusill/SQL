import sys
from math import ceil, log2


def build_tree(nums, k):
    tree_size = 2 ** (k + 1)
    tree = [0] * tree_size

    for idx, num in enumerate(nums):
        tree[idx + (2 ** k)] = num

    for i in range(2 ** k - 1, -1, -1):
        tree[i] = tree[i * 2] + tree[i * 2 + 1]

    return tree


def query(tree, start_index, end_index):
    result = 0
    while start_index <= end_index:
        if start_index % 2 == 1:
            result += tree[start_index]
        if end_index % 2 == 0:
            result += tree[end_index]

        start_index = (start_index + 1) // 2
        end_index = (end_index - 1) // 2

    print(result)


def update(tree, index, val):
    diff = val - tree[index]
    tree[index] = val
    index //= 2
    while index:
        tree[index] += diff
        index //= 2


n, q = map(int, sys.stdin.readline().split())
nums = list(map(int, sys.stdin.readline().split()))
k = ceil(log2(n))
segment_tree = build_tree(nums, k)

for _ in range(q):
    start_idx, end_idx, idx, val = map(int, sys.stdin.readline().split())
    if start_idx > end_idx:
        start_idx, end_idx = end_idx, start_idx
    a = 2 ** k - 1
    query(segment_tree, start_idx + a, end_idx + a)
    update(segment_tree, idx + a, val)