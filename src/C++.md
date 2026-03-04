# C++ for Competitive Programming — Complete Notes

## 1. The Template
```cpp
#include <bits/stdc++.h>
using namespace std;
#define int long long
#define pb push_back
#define pp pop_back
#define ff first
#define ss second
#define all(x) x.begin(), x.end()
#define rall(x) x.rbegin(), x.rend()
#define vi vector<int>
#define vii vector<pair<int,int>>
#define pii pair<int,int>
#define rep(i, a, b) for(int i = a; i < b; i++)
#define mod 1000000007
#define INF 1e18
#define endl "\n"
typedef long long ll;

void solve() { }

signed main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    int t = 1;
    // cin >> t;
    while(t--) solve();
    return 0;
}
```

## 2. Data Types
```cpp
int a = 10;       // whole number (-> long long via define)
double d = 3.14;  // decimal (15-16 digit precision)
char c = 'A';     // single character, single quotes
string s = "hi";  // text, double quotes
bool b = true;    // true/false, prints as 1/0
// int max ~2*10^9 | long long max ~9*10^18
```

## 3. Operators
```cpp
a + b  a - b  a * b  a / b  // basic (/ truncates for int)
a % b  // REMAINDER — most used in DSA
a == b  a != b  a > b  a < b  a >= b  a <= b
a > 5 && b < 5   // AND
a > 5 || b > 5   // OR
!(a > 5)         // NOT
a += 5;  a++;  a--;
// Modulo uses:
n % 2 == 0              // even check
ans = (ans + x) % mod;  // keep in range
(cur + 1) % n           // circular index
```

## 4. Conditions
```cpp
if(x > 0)      cout << "positive";
else if(x < 0) cout << "negative";
else           cout << "zero";

string r = (x % 2 == 0) ? "even" : "odd";  // ternary
// WARNING: = assigns, == compares. if(x = 0) is a bug!
```

## 5. Loops
```cpp
rep(i, 0, n) { }              // 0 to n-1 (use this always)
for(int i = n-1; i >= 0; i--) // reverse
for(auto x : v) cout << x;    // range-based, no index needed
while(condition) { }
// break -> exit loop | continue -> skip iteration
```

## 6. Vectors
```cpp
vi v;               vi v2(5);       vi v3(5,10);
vi v4 = {1,2,3};
v.pb(x);  v.pp();   // add/remove end
v[i];  v.front();  v.back();
v.size();  v.empty();  v.clear();
vector<vi> grid(n, vi(m, 0));  // 2D vector
for(auto x : v) cout << x;
```

## 7. Strings
```cpp
cin >> s;            // one word
getline(cin, s);     // full line
s.size();  s[0];  s.front();  s.back();
s += "world";        // append
s.substr(0, 5);      // first 5 chars
s.find("lo");        // index of match
to_string(42);       // int -> string
stoi("42");          // string -> int
isupper(c) islower(c) isdigit(c) toupper(c) tolower(c)
// ASCII: 'a'=97 'A'=65 '0'=48
// c - 'a' = 0..25 | c - '0' = 0..9
```

## 8. Functions
```cpp
int add(int a, int b) { return a + b; }
void increment(int &x) { x++; }      // by reference -> modifies original
void increment(int x) { x++; }       // by value -> copy, original unchanged
int power(int b, int e = 2) { return pow(b,e); }  // default param
```

## 9. Recursion
```cpp
// Rule: BASE CASE stops it. RECURSIVE CASE shrinks problem.
int factorial(int n) {
    if(n <= 1) return 1;           // base case
    return n * factorial(n - 1);   // recursive case
}
int fib(int n) {
    if(n <= 1) return n;
    return fib(n-1) + fib(n-2);
}
// WARNING: depth limit ~10^5. Go deeper -> use iteration.
```

## 10. Pairs and Tuples
```cpp
pii p = {3, 5};
p.ff   // 3 (first)
p.ss   // 5 (second)
vii v;
v.pb({1,3});  v.pb({2,1});
sort(all(v));  // sorts by first, then second auto
tuple<int,int,int> t = {1,2,3};
get<0>(t);  get<1>(t);  get<2>(t);
auto [a,b,c] = t;  // C++17 unpack
```

## 11. Maps
```cpp
map<string,int> mp;       // sorted by key, O(log n)
mp["apple"] = 5;
mp.count("apple");        // 1 if exists, 0 if not
mp.erase("apple");
for(auto x : mp) cout << x.ff << " " << x.ss;
unordered_map<string,int> ump;  // O(1) avg, unsorted

// Frequency pattern — use constantly
map<int,int> freq;
for(auto x : arr) freq[x]++;
```

## 12. Sets
```cpp
set<int> s;               // unique, sorted, O(log n)
s.insert(3);  s.insert(3);  // second ignored
s.count(3);   s.erase(3);   s.size();
for(auto x : s) cout << x;  // always sorted
s.lower_bound(x);  // first element >= x
s.upper_bound(x);  // first element > x
// unordered_set -> O(1), unsorted
// multiset -> allows duplicates
```

## 13. Stacks and Queues
```cpp
// STACK — LIFO (Last In First Out)
stack<int> st;
st.push(x);  st.top();  st.pop();  st.size();  st.empty();
// Use: matching brackets, DFS, undo

// QUEUE — FIFO (First In First Out)
queue<int> q;
q.push(x);  q.front();  q.back();  q.pop();
// Use: BFS, scheduling

// PRIORITY QUEUE — Max heap by default
priority_queue<int> pq;          // max on top
pq.push(x);  pq.top();  pq.pop();

priority_queue<int, vector<int>, greater<int>> min_pq;  // min on top
// Use: Dijkstra, always getting min/max in O(log n)
```

## 14. STL Algorithms
```cpp
sort(all(v));                    // ascending
sort(rall(v));                   // descending
reverse(all(v));
*min_element(all(v));
*max_element(all(v));
min(a,b);  max(a,b);
count(all(v), x);                // count occurrences
accumulate(all(v), 0LL);         // sum
fill(all(v), 0);                 // set all to 0

// Binary search (MUST sort first)
sort(all(v));
binary_search(all(v), x);        // true/false
lower_bound(all(v), x);          // first >= x
upper_bound(all(v), x);          // first > x
int idx = lower_bound(all(v),x) - v.begin();  // to index

// Remove duplicates
sort(all(v));
v.erase(unique(all(v)), v.end());
```

## 15. Math
```cpp
abs(-5)       sqrt(16)     pow(2,10)    // 5, 4.0, 1024.0
ceil(3.2)     floor(3.8)   // 4, 3
log2(8)       log10(1000)  // 3, 3
__gcd(12, 8)  // 4 — built-in GCD

int lcm(int a, int b) { return (a/__gcd(a,b))*b; }

// Fast power O(log n) — for a^b % mod
int fast_pow(int base, int exp, int mod) {
    int res = 1;  base %= mod;
    while(exp > 0) {
        if(exp%2==1) res = res*base%mod;
        base = base*base%mod;
        exp /= 2;
    }
    return res;
}

// Sieve — all primes up to n
vector<bool> is_prime(n+1, true);
is_prime[0] = is_prime[1] = false;
for(int i=2; i*i<=n; i++)
    if(is_prime[i])
        for(int j=i*i; j<=n; j+=i)
            is_prime[j] = false;
```

## 16. Time Complexity
| Big O | Name | Max n (1s) |
|---|---|---|
| O(1) | Constant | Any |
| O(log n) | Log | 10^18 |
| O(n) | Linear | 10^8 |
| O(n log n) | NlogN | 10^6 |
| O(n^2) | Quadratic | 10^4 |
| O(2^n) | Exponential | 25 |
| O(n!) | Factorial | 12 |

**Rule:** ~10^8 ops/sec. Check constraints FIRST, code SECOND.

## 17. Common Mistakes
```cpp
if(x = 0)          // BUG: assigns. Use if(x == 0)
(ll)a * b          // cast before multiply to prevent overflow
arr[5] on arr[5]   // out of bounds! valid: arr[0] to arr[4]
cout << endl       // slow (flushes). Use "\n"
binary_search without sort first   // wrong result
rep(i, 1, n)       // misses index 0
int sum;           // garbage! always init: int sum = 0
ans + x % mod      // wrong! use: (ans + x) % mod
```

## Quick Reference
```
VECTOR:    pb pp size empty clear front back
SORT:      sort(all) sort(rall) reverse
MINMAX:    *min_element *max_element min() max()
SEARCH:    binary_search lower_bound upper_bound
COUNT:     count(all, x)  accumulate(all, 0LL)
STRING:    size substr find to_string stoi
CHARS:     isupper islower isdigit toupper tolower
MATH:      abs pow sqrt __gcd ceil floor log2
```
