# Data Structures and Algorithms

> the foundation of competitive programming and technical interviews.

---

## why DSA matters

DSA is not just for interviews. understanding the right data structure for the right problem makes your code faster and cleaner. a bad choice can make an app that handles 100 users crash with 10,000.

**time complexity** — how runtime grows as input grows
**space complexity** — how memory usage grows as input grows

---

## Big O notation

Big O describes the worst-case performance of an algorithm.

```
O(1)       constant    — always same time regardless of input
O(log n)   logarithmic — halves input each step (binary search)
O(n)       linear      — one operation per element
O(n log n) linearithmic — efficient sorting (merge sort)
O(n²)      quadratic   — nested loops
O(2ⁿ)      exponential — every subset (bad)
O(n!)      factorial   — every permutation (very bad)

fastest to slowest:
O(1) < O(log n) < O(n) < O(n log n) < O(n²) < O(2ⁿ) < O(n!)
```

```cpp
// O(1) — constant
int getFirst(vector<int>& arr) {
    return arr[0];
}

// O(n) — linear
int findMax(vector<int>& arr) {
    int max = arr[0];
    for (int x : arr) max = max > x ? max : x;
    return max;
}

// O(n²) — quadratic (nested loops)
bool hasDuplicate(vector<int>& arr) {
    for (int i = 0; i < arr.size(); i++)
        for (int j = i+1; j < arr.size(); j++)
            if (arr[i] == arr[j]) return true;
    return false;
}

// O(n) — same problem, better solution
bool hasDuplicate(vector<int>& arr) {
    unordered_set<int> seen;
    for (int x : arr) {
        if (seen.count(x)) return true;
        seen.insert(x);
    }
    return false;
}
```

---

## arrays

the most fundamental data structure. elements stored in contiguous memory.

```cpp
// C++ array operations
vector<int> arr = {1, 2, 3, 4, 5};

arr.push_back(6);      // O(1) amortized
arr.pop_back();        // O(1)
arr[2];                // O(1) access
arr.insert(arr.begin() + 2, 99);  // O(n) — shifts elements
arr.erase(arr.begin() + 2);       // O(n) — shifts elements

// two pointer technique
// find pair that sums to target in sorted array
bool twoSum(vector<int>& arr, int target) {
    int left = 0, right = arr.size() - 1;
    while (left < right) {
        int sum = arr[left] + arr[right];
        if (sum == target) return true;
        else if (sum < target) left++;
        else right--;
    }
    return false;
}
// time: O(n), space: O(1)

// sliding window — max sum subarray of size k
int maxSumSubarray(vector<int>& arr, int k) {
    int windowSum = 0, maxSum = 0;
    for (int i = 0; i < k; i++) windowSum += arr[i];
    maxSum = windowSum;
    for (int i = k; i < arr.size(); i++) {
        windowSum += arr[i] - arr[i-k];
        maxSum = max(maxSum, windowSum);
    }
    return maxSum;
}
// time: O(n), space: O(1)

// prefix sum — range sum queries
vector<int> prefix(arr.size() + 1, 0);
for (int i = 0; i < arr.size(); i++)
    prefix[i+1] = prefix[i] + arr[i];

// sum from index l to r
int rangeSum(int l, int r) {
    return prefix[r+1] - prefix[l];
}
// query: O(1), build: O(n)
```

---

## strings

```cpp
string s = "hello world";

s.length();              // 11
s.substr(0, 5);          // "hello"
s.find("world");         // 6
s.replace(6, 5, "there"); // "hello there"
s[0];                    // 'h'

// reverse string
reverse(s.begin(), s.end());

// check palindrome
bool isPalindrome(string s) {
    int l = 0, r = s.length() - 1;
    while (l < r) {
        if (s[l] != s[r]) return false;
        l++; r--;
    }
    return true;
}

// frequency count
unordered_map<char, int> freq;
for (char c : s) freq[c]++;

// anagram check (two strings have same characters)
bool isAnagram(string s, string t) {
    if (s.length() != t.length()) return false;
    unordered_map<char, int> count;
    for (char c : s) count[c]++;
    for (char c : t) {
        count[c]--;
        if (count[c] < 0) return false;
    }
    return true;
}
```

---

## linked list

nodes connected by pointers. efficient insert/delete at beginning, slow random access.

```cpp
struct Node {
    int val;
    Node* next;
    Node(int x) : val(x), next(nullptr) {}
};

// traverse
void traverse(Node* head) {
    while (head) {
        cout << head->val << " ";
        head = head->next;
    }
}

// reverse linked list
Node* reverse(Node* head) {
    Node* prev = nullptr;
    Node* curr = head;
    while (curr) {
        Node* next = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next;
    }
    return prev;  // new head
}

// detect cycle (Floyd's algorithm)
bool hasCycle(Node* head) {
    Node* slow = head;
    Node* fast = head;
    while (fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
        if (slow == fast) return true;
    }
    return false;
}

// find middle
Node* findMiddle(Node* head) {
    Node* slow = head;
    Node* fast = head;
    while (fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
    }
    return slow;
}

// merge two sorted lists
Node* mergeSorted(Node* l1, Node* l2) {
    if (!l1) return l2;
    if (!l2) return l1;
    if (l1->val <= l2->val) {
        l1->next = mergeSorted(l1->next, l2);
        return l1;
    }
    l2->next = mergeSorted(l1, l2->next);
    return l2;
}
```

---

## stack

LIFO (Last In First Out). think: stack of plates.

```cpp
stack<int> st;

st.push(1);      // push to top
st.push(2);
st.pop();        // remove from top
st.top();        // view top: 1
st.empty();      // false
st.size();       // 1

// valid parentheses
bool isValid(string s) {
    stack<char> st;
    for (char c : s) {
        if (c == '(' || c == '[' || c == '{') {
            st.push(c);
        } else {
            if (st.empty()) return false;
            char top = st.top(); st.pop();
            if (c == ')' && top != '(') return false;
            if (c == ']' && top != '[') return false;
            if (c == '}' && top != '{') return false;
        }
    }
    return st.empty();
}

// next greater element
vector<int> nextGreater(vector<int>& arr) {
    int n = arr.size();
    vector<int> result(n, -1);
    stack<int> st;  // stores indices
    for (int i = 0; i < n; i++) {
        while (!st.empty() && arr[st.top()] < arr[i]) {
            result[st.top()] = arr[i];
            st.pop();
        }
        st.push(i);
    }
    return result;
}
```

---

## queue

FIFO (First In First Out). think: line at a counter.

```cpp
queue<int> q;

q.push(1);       // enqueue
q.push(2);
q.front();       // view front: 1
q.back();        // view back: 2
q.pop();         // dequeue (removes front)
q.empty();
q.size();

// deque (double-ended queue)
deque<int> dq;
dq.push_front(1);
dq.push_back(2);
dq.pop_front();
dq.pop_back();

// sliding window maximum (deque technique)
vector<int> slidingMax(vector<int>& arr, int k) {
    deque<int> dq;  // stores indices
    vector<int> result;
    for (int i = 0; i < arr.size(); i++) {
        // remove out of window
        while (!dq.empty() && dq.front() < i - k + 1)
            dq.pop_front();
        // remove smaller elements
        while (!dq.empty() && arr[dq.back()] < arr[i])
            dq.pop_back();
        dq.push_back(i);
        if (i >= k - 1) result.push_back(arr[dq.front()]);
    }
    return result;
}
```

---

## hash map and hash set

O(1) average lookup, insert, delete. the most useful data structure for competitive programming.

```cpp
// unordered_map (hash map)
unordered_map<string, int> mp;

mp["apple"] = 5;
mp["banana"] = 3;
mp["apple"]++;

mp.count("apple");    // 1 (exists), 0 (not exists)
mp.find("apple");     // iterator, mp.end() if not found
mp.erase("apple");

// iterate
for (auto& [key, val] : mp) {
    cout << key << ": " << val << "\n";
}

// unordered_set (hash set)
unordered_set<int> st;
st.insert(5);
st.count(5);    // 1 if exists
st.erase(5);

// two sum — classic hash map problem
vector<int> twoSum(vector<int>& nums, int target) {
    unordered_map<int, int> seen;  // value → index
    for (int i = 0; i < nums.size(); i++) {
        int complement = target - nums[i];
        if (seen.count(complement))
            return {seen[complement], i};
        seen[nums[i]] = i;
    }
    return {};
}

// group anagrams
vector<vector<string>> groupAnagrams(vector<string>& strs) {
    unordered_map<string, vector<string>> mp;
    for (string& s : strs) {
        string key = s;
        sort(key.begin(), key.end());
        mp[key].push_back(s);
    }
    vector<vector<string>> result;
    for (auto& [key, group] : mp) result.push_back(group);
    return result;
}
```

---

## binary search

search sorted arrays in O(log n). halves the search space each step.

```cpp
// classic binary search
int binarySearch(vector<int>& arr, int target) {
    int left = 0, right = arr.size() - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;  // avoid overflow
        if (arr[mid] == target) return mid;
        else if (arr[mid] < target) left = mid + 1;
        else right = mid - 1;
    }
    return -1;
}

// find first occurrence
int firstOccurrence(vector<int>& arr, int target) {
    int left = 0, right = arr.size() - 1, result = -1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] == target) {
            result = mid;
            right = mid - 1;  // keep searching left
        } else if (arr[mid] < target) left = mid + 1;
        else right = mid - 1;
    }
    return result;
}

// search on answer — binary search on the answer space
// example: minimum max pages in books
bool canAllocate(vector<int>& pages, int students, int maxPages) {
    int count = 1, current = 0;
    for (int p : pages) {
        if (p > maxPages) return false;
        if (current + p > maxPages) { count++; current = p; }
        else current += p;
    }
    return count <= students;
}

int minPages(vector<int>& pages, int students) {
    int left = *max_element(pages.begin(), pages.end());
    int right = accumulate(pages.begin(), pages.end(), 0);
    int result = right;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (canAllocate(pages, students, mid)) {
            result = mid;
            right = mid - 1;
        } else left = mid + 1;
    }
    return result;
}
```

---

## sorting

```cpp
// STL sort — O(n log n)
sort(arr.begin(), arr.end());                          // ascending
sort(arr.begin(), arr.end(), greater<int>());          // descending
sort(arr.begin(), arr.end(), [](int a, int b) {        // custom
    return a > b;
});

// sort objects
sort(people.begin(), people.end(), [](Person& a, Person& b) {
    return a.age < b.age;
});

// counting sort — O(n + k) for small range
void countingSort(vector<int>& arr, int maxVal) {
    vector<int> count(maxVal + 1, 0);
    for (int x : arr) count[x]++;
    int idx = 0;
    for (int i = 0; i <= maxVal; i++)
        while (count[i]--) arr[idx++] = i;
}

// merge sort — O(n log n), stable
void merge(vector<int>& arr, int l, int m, int r) {
    vector<int> left(arr.begin()+l, arr.begin()+m+1);
    vector<int> right(arr.begin()+m+1, arr.begin()+r+1);
    int i = 0, j = 0, k = l;
    while (i < left.size() && j < right.size())
        arr[k++] = left[i] <= right[j] ? left[i++] : right[j++];
    while (i < left.size()) arr[k++] = left[i++];
    while (j < right.size()) arr[k++] = right[j++];
}

void mergeSort(vector<int>& arr, int l, int r) {
    if (l >= r) return;
    int m = l + (r - l) / 2;
    mergeSort(arr, l, m);
    mergeSort(arr, m+1, r);
    merge(arr, l, m, r);
}
```

---

## trees

hierarchical data structure. every node has a value and zero or more children.

```cpp
struct TreeNode {
    int val;
    TreeNode* left;
    TreeNode* right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

// traversals
void inorder(TreeNode* root) {   // left, root, right — sorted for BST
    if (!root) return;
    inorder(root->left);
    cout << root->val << " ";
    inorder(root->right);
}

void preorder(TreeNode* root) {  // root, left, right
    if (!root) return;
    cout << root->val << " ";
    preorder(root->left);
    preorder(root->right);
}

void postorder(TreeNode* root) { // left, right, root
    if (!root) return;
    postorder(root->left);
    postorder(root->right);
    cout << root->val << " ";
}

// level order (BFS)
vector<vector<int>> levelOrder(TreeNode* root) {
    if (!root) return {};
    vector<vector<int>> result;
    queue<TreeNode*> q;
    q.push(root);
    while (!q.empty()) {
        int size = q.size();
        vector<int> level;
        for (int i = 0; i < size; i++) {
            TreeNode* node = q.front(); q.pop();
            level.push_back(node->val);
            if (node->left) q.push(node->left);
            if (node->right) q.push(node->right);
        }
        result.push_back(level);
    }
    return result;
}

// height of tree
int height(TreeNode* root) {
    if (!root) return 0;
    return 1 + max(height(root->left), height(root->right));
}

// check if balanced
bool isBalanced(TreeNode* root) {
    if (!root) return true;
    int lh = height(root->left);
    int rh = height(root->right);
    return abs(lh - rh) <= 1 && isBalanced(root->left) && isBalanced(root->right);
}

// lowest common ancestor
TreeNode* lca(TreeNode* root, TreeNode* p, TreeNode* q) {
    if (!root || root == p || root == q) return root;
    TreeNode* left = lca(root->left, p, q);
    TreeNode* right = lca(root->right, p, q);
    if (left && right) return root;
    return left ? left : right;
}
```

---

## graph

nodes (vertices) connected by edges. used for: maps, social networks, dependencies.

```cpp
// adjacency list representation
int n = 6;  // number of nodes
vector<vector<int>> adj(n);  // adj[u] = list of neighbors

// add edge
adj[0].push_back(1);
adj[1].push_back(0);  // undirected

// BFS — shortest path in unweighted graph
vector<int> bfs(int start, vector<vector<int>>& adj) {
    int n = adj.size();
    vector<int> dist(n, -1);
    queue<int> q;
    dist[start] = 0;
    q.push(start);
    while (!q.empty()) {
        int u = q.front(); q.pop();
        for (int v : adj[u]) {
            if (dist[v] == -1) {
                dist[v] = dist[u] + 1;
                q.push(v);
            }
        }
    }
    return dist;
}

// DFS
vector<bool> visited(n, false);

void dfs(int u, vector<vector<int>>& adj) {
    visited[u] = true;
    cout << u << " ";
    for (int v : adj[u]) {
        if (!visited[v]) dfs(v, adj);
    }
}

// detect cycle in undirected graph
bool hasCycle(int u, int parent, vector<bool>& vis, vector<vector<int>>& adj) {
    vis[u] = true;
    for (int v : adj[u]) {
        if (!vis[v]) {
            if (hasCycle(v, u, vis, adj)) return true;
        } else if (v != parent) return true;
    }
    return false;
}

// topological sort (for DAGs — directed acyclic graphs)
void topoSort(int u, vector<bool>& vis, stack<int>& st, vector<vector<int>>& adj) {
    vis[u] = true;
    for (int v : adj[u])
        if (!vis[v]) topoSort(v, vis, st, adj);
    st.push(u);
}
```

---

## dynamic programming

DP solves complex problems by breaking into overlapping subproblems and caching results.

**when to use:** problem asks for optimal value (max/min), count of ways, or if it's possible. subproblems overlap.

```cpp
// fibonacci — classic DP
// naive: O(2^n)  DP: O(n)

// top-down (memoization)
unordered_map<int, long long> memo;
long long fib(int n) {
    if (n <= 1) return n;
    if (memo.count(n)) return memo[n];
    return memo[n] = fib(n-1) + fib(n-2);
}

// bottom-up (tabulation)
long long fib(int n) {
    if (n <= 1) return n;
    vector<long long> dp(n+1);
    dp[0] = 0; dp[1] = 1;
    for (int i = 2; i <= n; i++)
        dp[i] = dp[i-1] + dp[i-2];
    return dp[n];
}

// 0/1 knapsack
// items with weight and value, bag capacity W
// maximize value without exceeding weight
int knapsack(vector<int>& weights, vector<int>& values, int W) {
    int n = weights.size();
    vector<vector<int>> dp(n+1, vector<int>(W+1, 0));
    for (int i = 1; i <= n; i++) {
        for (int w = 0; w <= W; w++) {
            dp[i][w] = dp[i-1][w];  // don't take item i
            if (weights[i-1] <= w)
                dp[i][w] = max(dp[i][w], dp[i-1][w-weights[i-1]] + values[i-1]);
        }
    }
    return dp[n][W];
}

// longest common subsequence
int lcs(string s, string t) {
    int m = s.length(), n = t.length();
    vector<vector<int>> dp(m+1, vector<int>(n+1, 0));
    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            if (s[i-1] == t[j-1]) dp[i][j] = dp[i-1][j-1] + 1;
            else dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
        }
    }
    return dp[m][n];
}

// coin change — minimum coins to make amount
int coinChange(vector<int>& coins, int amount) {
    vector<int> dp(amount+1, INT_MAX);
    dp[0] = 0;
    for (int i = 1; i <= amount; i++) {
        for (int coin : coins) {
            if (coin <= i && dp[i-coin] != INT_MAX)
                dp[i] = min(dp[i], dp[i-coin] + 1);
        }
    }
    return dp[amount] == INT_MAX ? -1 : dp[amount];
}
```

---

## priority queue (heap)

always gives you the max (or min) element in O(log n).

```cpp
// max heap (default)
priority_queue<int> maxHeap;
maxHeap.push(3);
maxHeap.push(1);
maxHeap.push(5);
maxHeap.top();   // 5
maxHeap.pop();   // removes 5

// min heap
priority_queue<int, vector<int>, greater<int>> minHeap;
minHeap.push(3);
minHeap.top();   // smallest element

// k largest elements
vector<int> kLargest(vector<int>& arr, int k) {
    priority_queue<int, vector<int>, greater<int>> minHeap;
    for (int x : arr) {
        minHeap.push(x);
        if (minHeap.size() > k) minHeap.pop();
    }
    vector<int> result;
    while (!minHeap.empty()) {
        result.push_back(minHeap.top());
        minHeap.pop();
    }
    return result;
}

// custom comparator
auto cmp = [](pair<int,int>& a, pair<int,int>& b) {
    return a.second > b.second;  // min heap by second element
};
priority_queue<pair<int,int>, vector<pair<int,int>>, decltype(cmp)> pq(cmp);
```

---

## STL cheatsheet for competitive programming

```cpp
#include <bits/stdc++.h>
using namespace std;

// containers
vector<int> v;           // dynamic array
array<int, 5> a;         // fixed array
list<int> l;             // doubly linked list
deque<int> dq;           // double-ended queue
stack<int> st;           // LIFO
queue<int> q;            // FIFO
priority_queue<int> pq;  // max heap
set<int> s;              // sorted unique set O(log n)
multiset<int> ms;        // sorted set with duplicates
unordered_set<int> us;   // hash set O(1)
map<int,int> m;          // sorted map O(log n)
unordered_map<int,int> um; // hash map O(1)

// algorithms
sort(v.begin(), v.end());
reverse(v.begin(), v.end());
*max_element(v.begin(), v.end());
*min_element(v.begin(), v.end());
accumulate(v.begin(), v.end(), 0);   // sum
count(v.begin(), v.end(), 5);        // count 5s
find(v.begin(), v.end(), 5);         // iterator to first 5
lower_bound(v.begin(), v.end(), 5);  // first >= 5
upper_bound(v.begin(), v.end(), 5);  // first > 5
binary_search(v.begin(), v.end(), 5); // exists?
next_permutation(v.begin(), v.end()); // next permutation
__gcd(a, b);                          // GCD
__builtin_popcount(n);                // count set bits

// useful tricks
int INF = 1e9;
long long LINF = 1e18;
const double PI = acos(-1.0);
```

---

## problem solving patterns

```
pattern → when to use → technique

two pointers     → sorted array, pairs, palindromes → left/right pointers
sliding window   → subarray/substring problems → expand/shrink window
fast/slow pointer → linked list cycle, middle → two pointer at different speeds
binary search    → sorted array, search on answer → halve search space
BFS              → shortest path, level order → queue
DFS              → connected components, paths → stack/recursion
dynamic programming → optimal, count, possible → cache subproblems
greedy           → local optimal = global optimal → make best choice at each step
backtracking     → all combinations/permutations → try all, undo bad choices
divide and conquer → split, solve, combine → merge sort, quick sort
```

---

```
=^._.^= every problem is a pattern in disguise
```
