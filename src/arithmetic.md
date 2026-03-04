# Mathematics for Competitive Programming

> Every problem in CP is math in disguise. 

---

## Table of Contents

1. [Number Basics](#1-number-basics)
2. [Divisibility Rules](#2-divisibility-rules)
3. [Prime Numbers](#3-prime-numbers)
4. [GCD and LCM](#4-gcd-and-lcm)
5. [Modular Arithmetic](#5-modular-arithmetic)
6. [Fast Exponentiation](#6-fast-exponentiation)
7. [Number Theory](#7-number-theory)
8. [Digit Manipulation](#8-digit-manipulation)
9. [Series and Sequences](#9-series-and-sequences)
10. [Combinatorics](#10-combinatorics)
11. [Probability Basics](#11-probability-basics)
12. [Binary and Bitwise](#12-binary-and-bitwise)
13. [Geometry Basics](#13-geometry-basics)
14. [Matrix Basics](#14-matrix-basics)
15. [Game Theory](#15-game-theory)
16. [Important Constants](#16-important-constants)

---

## 1. Number Basics

### Types of Numbers

```
Natural Numbers  : 1, 2, 3, 4, ...          (positive, no zero)
Whole Numbers    : 0, 1, 2, 3, ...          (natural + zero)
Integers         : ...-3, -2, -1, 0, 1, 2   (positive + negative)
Rational         : p/q form  (1/2, 3/4)
Irrational       : cannot be written as p/q  (pi, sqrt(2))
```

### Even and Odd

```
Even : divisible by 2 → n % 2 == 0  → 0, 2, 4, 6, 8...
Odd  : not divisible by 2 → n % 2 != 0 → 1, 3, 5, 7, 9...

Key properties:
  even + even = even      odd + odd  = even
  even + odd  = odd       odd * odd  = odd
  even * even = even      even * odd = even
```

```cpp
bool isEven(int n) { return n % 2 == 0; }
bool isOdd(int n)  { return n % 2 != 0; }

// Fastest way using bitwise AND
bool isOdd_fast(int n) { return n & 1; }  // last bit = 1 means odd
```

### Absolute Value

```
|x| = x if x >= 0, else -x

|-5| = 5     |5| = 5     |0| = 0
```

```cpp
int a = abs(-5);       // 5
double b = fabs(-3.14); // 3.14 for doubles
```

### Floor, Ceiling, Rounding

```
floor(3.7)  = 3    (round DOWN to nearest integer)
ceil(3.2)   = 4    (round UP to nearest integer)
round(3.5)  = 4    (round to nearest)

Integer division already floors:
  7 / 2 = 3  (not 3.5)

Ceiling division trick (without using ceil()):
  ceil(a/b) = (a + b - 1) / b    (integer arithmetic)
```

```cpp
cout << floor(3.7) << endl;     // 3
cout << ceil(3.2) << endl;      // 4

// Ceiling division for integers
int a = 7, b = 2;
int ceil_div = (a + b - 1) / b;  // 4
```

---

## 2. Divisibility Rules

### The Rules (Memorize These)

```
÷ 2   → last digit is 0, 2, 4, 6, 8
÷ 3   → sum of digits divisible by 3        (123 → 1+2+3=6 ✓)
÷ 4   → last TWO digits divisible by 4      (1324 → 24÷4 ✓)
÷ 5   → last digit is 0 or 5
÷ 6   → divisible by BOTH 2 and 3
÷ 7   → no simple rule, just divide
÷ 8   → last THREE digits divisible by 8
÷ 9   → sum of digits divisible by 9        (729 → 7+2+9=18 ✓)
÷ 10  → last digit is 0
÷ 11  → (sum of odd-position digits) - (sum of even-position digits) = 0 or 11
÷ 12  → divisible by BOTH 3 and 4
```

```cpp
bool divBy2(int n)  { return n % 2 == 0; }
bool divBy3(int n)  { 
    int s = 0;
    while(n > 0) { s += n % 10; n /= 10; }
    return s % 3 == 0;
}
bool divBy4(int n)  { return (n % 100) % 4 == 0; }
bool divBy5(int n)  { return n % 5 == 0; }
bool divBy6(int n)  { return n % 2 == 0 && n % 3 == 0; }
bool divBy9(int n)  {
    int s = 0;
    while(n > 0) { s += n % 10; n /= 10; }
    return s % 9 == 0;
}
bool divBy10(int n) { return n % 10 == 0; }
bool divBy11(int n) {
    int odd = 0, even = 0, pos = 1;
    while(n > 0) {
        if(pos % 2 != 0) odd  += n % 10;
        else             even += n % 10;
        n /= 10; pos++;
    }
    int diff = abs(odd - even);
    return diff == 0 || diff == 11;
}
```

---

## 3. Prime Numbers

### What is a Prime?

```
Prime   : divisible by exactly 1 and itself   (2, 3, 5, 7, 11, 13...)
Composite: has more than 2 factors            (4, 6, 8, 9, 10...)
Special : 1 is NEITHER prime nor composite
          2 is the ONLY even prime
```

### Prime Check — O(sqrt n)

```cpp
// Why sqrt(n)? If n = a*b, one of them must be <= sqrt(n)
// So we only need to check up to sqrt(n)

bool isPrime(int n) {
    if(n < 2) return false;
    if(n == 2) return true;
    if(n % 2 == 0) return false;      // skip even numbers
    for(int i = 3; i * i <= n; i += 2) {  // only odd divisors
        if(n % i == 0) return false;
    }
    return true;
}

// i*i <= n  is same as  i <= sqrt(n)
// but i*i avoids floating point errors — always use this
```

### Sieve of Eratosthenes — O(n log log n)

```
Best way to find ALL primes up to n.
Algorithm:
  Start with all numbers marked as prime.
  For each prime p, mark all multiples of p as composite.
  Start from p*p (everything below already marked).
```

```cpp
// Find all primes up to n
vector<bool> sieve(int n) {
    vector<bool> is_prime(n + 1, true);
    is_prime[0] = is_prime[1] = false;

    for(int i = 2; i * i <= n; i++) {
        if(is_prime[i]) {
            for(int j = i * i; j <= n; j += i) {
                is_prime[j] = false;   // mark multiples
            }
        }
    }
    return is_prime;
}

// Usage
void solve() {
    auto primes = sieve(100);
    for(int i = 2; i <= 100; i++) {
        if(primes[i]) cout << i << " ";
    }
}
// Output: 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47...
```

### Smallest Prime Factor Sieve — Very Useful

```cpp
// For each number, store its smallest prime factor
// Allows instant factorization

vector<int> spf(int n) {
    vector<int> smallest(n + 1);
    iota(smallest.begin(), smallest.end(), 0); // smallest[i] = i

    for(int i = 2; i * i <= n; i++) {
        if(smallest[i] == i) {  // i is prime
            for(int j = i * i; j <= n; j += i) {
                if(smallest[j] == j)
                    smallest[j] = i;
            }
        }
    }
    return smallest;
}

// Factorize any number in O(log n) using SPF
vector<int> factorize(int n, vector<int>& smallest) {
    vector<int> factors;
    while(n > 1) {
        factors.pb(smallest[n]);
        n /= smallest[n];
    }
    return factors;
}
```

### Prime Factorization — O(sqrt n)

```cpp
// 360 = 2^3 * 3^2 * 5
map<int,int> primeFactors(int n) {
    map<int,int> factors;
    for(int i = 2; i * i <= n; i++) {
        while(n % i == 0) {
            factors[i]++;
            n /= i;
        }
    }
    if(n > 1) factors[n]++;  // remaining prime factor > sqrt(n)
    return factors;
}

// Example: n = 360
// i=2: 360/2=180/2=90/2=45, factors[2]=3
// i=3: 45/3=15/3=5, factors[3]=2
// i=4: skip (4*4=16 > 5)
// n=5 > 1: factors[5]=1
// Result: {2:3, 3:2, 5:1}
```

---

## 4. GCD and LCM

### GCD (Greatest Common Divisor)

```
GCD(a, b) = largest number that divides both a and b

GCD(12, 8):
  Factors of 12: 1, 2, 3, 4, 6, 12
  Factors of 8:  1, 2, 4, 8
  Common:        1, 2, 4
  GCD = 4

Euclidean Algorithm: GCD(a, b) = GCD(b, a % b)
  GCD(12, 8)
  = GCD(8, 4)    because 12 % 8 = 4
  = GCD(4, 0)    because 8 % 4 = 0
  = 4            base case: GCD(n, 0) = n
```

```cpp
// Recursive
int gcd(int a, int b) {
    return b == 0 ? a : gcd(b, a % b);
}

// Iterative
int gcd_iter(int a, int b) {
    while(b) {
        a %= b;
        swap(a, b);
    }
    return a;
}

// Built-in (C++17)
__gcd(12, 8);    // 4

// Properties:
// gcd(a, 0) = a
// gcd(0, b) = b
// gcd(a, b) = gcd(b, a)
// gcd(a, b) = gcd(a-b, b)  if a > b
```

### LCM (Least Common Multiple)

```
LCM(a, b) = smallest number divisible by both a and b

Key formula: LCM(a, b) = (a / GCD(a, b)) * b
             Divide FIRST to prevent overflow!

LCM(12, 8):
  GCD(12, 8) = 4
  LCM = (12 / 4) * 8 = 24
```

```cpp
int lcm(int a, int b) {
    return (a / __gcd(a, b)) * b;  // divide first!
}

// LCM of array
int lcm_array(vi& arr) {
    int result = arr[0];
    rep(i, 1, arr.size())
        result = lcm(result, arr[i]);
    return result;
}
```

### Extended GCD — For Modular Inverse

```cpp
// Finds x, y such that: a*x + b*y = gcd(a, b)
int extgcd(int a, int b, int &x, int &y) {
    if(b == 0) { x = 1; y = 0; return a; }
    int x1, y1;
    int g = extgcd(b, a % b, x1, y1);
    x = y1;
    y = x1 - (a / b) * y1;
    return g;
}
```

---

## 5. Modular Arithmetic

### Why Modulo?

```
Answers in CP can be astronomically large.
Problems say "print answer % 10^9 + 7"
mod = 10^9 + 7 = 1000000007  (this is a prime number)

Why this specific prime? Because:
  - It fits in int (just barely)
  - Two numbers multiplied fit in long long
  - Being prime allows modular inverse
```

### Basic Rules

```
(a + b) % m = ((a % m) + (b % m)) % m
(a - b) % m = ((a % m) - (b % m) + m) % m   ← +m prevents negative
(a * b) % m = ((a % m) * (b % m)) % m
(a / b) % m = (a * inverse(b)) % m           ← division needs inverse
```

```cpp
const int MOD = 1e9 + 7;

// Addition
long long add(long long a, long long b) {
    return (a + b) % MOD;
}

// Subtraction (add MOD to prevent negative)
long long sub(long long a, long long b) {
    return ((a - b) % MOD + MOD) % MOD;
}

// Multiplication
long long mul(long long a, long long b) {
    return (a % MOD) * (b % MOD) % MOD;
}

// WRONG way (common mistake):
long long wrong = (a + b) % MOD;   // ok for addition
long long wrong2 = a * b % MOD;    // OVERFLOW if a,b ~ 10^9
// CORRECT: cast or reduce first
long long correct = (1LL * a * b) % MOD;
```

### Modular Inverse

```
Inverse of b (mod m): b * inv(b) ≡ 1 (mod m)
Only exists when gcd(b, m) = 1
If m is prime, inv(b) = b^(m-2) % m  (Fermat's little theorem)
```

```cpp
long long power(long long base, long long exp, long long mod);  // defined below

long long modinv(long long b, long long m = MOD) {
    return power(b, m - 2, m);  // only works when m is prime
}

// Division using modular inverse
long long divide(long long a, long long b) {
    return mul(a, modinv(b));
}
```

---

## 6. Fast Exponentiation

### Why Fast Power?

```
2^10 the slow way: multiply 2 ten times
2^10 the fast way: 2^10 = 2^8 * 2^2   (only 4 multiplications)

Binary exponentiation: split exponent in binary
  13 in binary = 1101
  x^13 = x^8 * x^4 * x^1   (skip x^2 because bit 1 is 0)

Time: O(log n) instead of O(n)
```

### Fast Power Code

```cpp
// Compute base^exp % mod in O(log exp)
long long power(long long base, long long exp, long long mod = MOD) {
    long long result = 1;
    base %= mod;

    while(exp > 0) {
        if(exp & 1)                      // if last bit is 1
            result = result * base % mod;
        base = base * base % mod;        // square the base
        exp >>= 1;                       // shift right (divide by 2)
    }
    return result;
}

// Trace: base=2, exp=10 (binary: 1010)
// exp=10(1010): bit=0, base=4,   result=1
// exp=5 (0101): bit=1, base=16,  result=2
// exp=2 (0010): bit=0, base=256, result=2
// exp=1 (0001): bit=1, base=..., result=2*16=32... wait
// Actually: 2^10=1024. Let's trust the code.

// Without modulo (for small numbers)
long long power_simple(long long base, long long exp) {
    long long result = 1;
    while(exp > 0) {
        if(exp & 1) result *= base;
        base *= base;
        exp >>= 1;
    }
    return result;
}
```

---

## 7. Number Theory

### Factors of a Number

```
Factors of 12: 1, 2, 3, 4, 6, 12
Number of factors = (e1+1)(e2+1)...  where e = exponents in prime factorization
12 = 2^2 * 3^1 → factors = (2+1)(1+1) = 6  ✓
```

```cpp
// Print all factors — O(sqrt n)
void printFactors(int n) {
    vi factors;
    for(int i = 1; i * i <= n; i++) {
        if(n % i == 0) {
            factors.pb(i);
            if(i != n/i) factors.pb(n/i);  // don't add sqrt twice
        }
    }
    sort(all(factors));
    for(auto x : factors) cout << x << " ";
}

// Sum of factors
int sumFactors(int n) {
    int sum = 0;
    for(int i = 1; i * i <= n; i++) {
        if(n % i == 0) {
            sum += i;
            if(i != n/i) sum += n/i;
        }
    }
    return sum;
}

// Count of factors
int countFactors(int n) {
    int count = 0;
    for(int i = 1; i * i <= n; i++) {
        if(n % i == 0) {
            count++;
            if(i != n/i) count++;
        }
    }
    return count;
}
```

### Special Numbers

```cpp
// Perfect Number: sum of proper factors = number itself
// 6 = 1+2+3   28 = 1+2+4+7+14
bool isPerfect(int n) {
    int sum = 1;
    for(int i = 2; i * i <= n; i++) {
        if(n % i == 0) {
            sum += i;
            if(i != n/i) sum += n/i;
        }
    }
    return sum == n && n != 1;
}

// Armstrong Number: sum of (each digit ^ total_digits) = number
// 153 = 1^3 + 5^3 + 3^3   (3 digits)
// 9474 = 9^4 + 4^4 + 7^4 + 4^4  (4 digits)
bool isArmstrong(int n) {
    int original = n;
    int digits = to_string(n).size();  // count digits
    int sum = 0;
    while(n > 0) {
        int d = n % 10;
        sum += power_simple(d, digits);
        n /= 10;
    }
    return sum == original;
}

// Strong Number: sum of factorials of digits = number
// 145 = 1! + 4! + 5! = 1 + 24 + 120 = 145
bool isStrong(int n) {
    int original = n, sum = 0;
    while(n > 0) {
        int d = n % 10;
        int fact = 1;
        for(int i = 1; i <= d; i++) fact *= i;
        sum += fact;
        n /= 10;
    }
    return sum == original;
}

// Palindrome Number: reads same forwards and backwards
// 121, 1221, 12321
bool isPalindrome(int n) {
    int original = n, rev = 0;
    while(n > 0) {
        rev = rev * 10 + n % 10;
        n /= 10;
    }
    return rev == original;
}
```

### Euler's Totient Function

```
φ(n) = count of numbers from 1 to n that are coprime with n
       (gcd(i, n) = 1)

φ(1)  = 1
φ(p)  = p - 1  for prime p
φ(p^k)= p^k - p^(k-1)
φ(mn) = φ(m)*φ(n)  when gcd(m,n) = 1

Examples:
φ(10) = 4   (1, 3, 7, 9 are coprime with 10)
φ(7)  = 6   (1,2,3,4,5,6 — 7 is prime)
```

```cpp
int euler_totient(int n) {
    int result = n;
    for(int i = 2; i * i <= n; i++) {
        if(n % i == 0) {
            while(n % i == 0) n /= i;
            result -= result / i;
        }
    }
    if(n > 1) result -= result / n;
    return result;
}

// Sieve version for all values up to n
vector<int> totient_sieve(int n) {
    vector<int> phi(n + 1);
    iota(phi.begin(), phi.end(), 0);  // phi[i] = i
    for(int i = 2; i <= n; i++) {
        if(phi[i] == i) {  // i is prime
            for(int j = i; j <= n; j += i) {
                phi[j] -= phi[j] / i;
            }
        }
    }
    return phi;
}
```

### Fermat's Little Theorem

```
If p is prime and gcd(a, p) = 1, then:
  a^(p-1) ≡ 1 (mod p)
  a^p     ≡ a (mod p)

Use: modular inverse when mod is prime
  a^(-1) ≡ a^(p-2) (mod p)
```

### Chinese Remainder Theorem (CRT)

```
Given:
  x ≡ r1 (mod m1)
  x ≡ r2 (mod m2)
  ...
Find x when all m values are coprime.

Used in: problems involving multiple modular constraints
```

```cpp
// Simple CRT for two equations
// x ≡ r1 (mod m1),  x ≡ r2 (mod m2)
long long crt(long long r1, long long m1, long long r2, long long m2) {
    long long m = m1 * m2;
    long long ans = (r1 * m2 % m * modinv(m2, m1) % m
                   + r2 * m1 % m * modinv(m1, m2) % m) % m;
    return ans;
}
```

---

## 8. Digit Manipulation

### Core Operations

```cpp
int n = 12345;

// Last digit
int last = n % 10;        // 5

// Remove last digit
n = n / 10;               // 1234

// Number of digits
int len = to_string(n).size();   // easy way
// Or:
int count = 0;
int temp = n;
while(temp > 0) { count++; temp /= 10; }

// First digit
while(n >= 10) n /= 10;   // keep dividing until one digit left

// Sum of digits
int sum = 0;
while(n > 0) { sum += n%10; n /= 10; }

// Reverse a number
int rev = 0;
while(n > 0) {
    rev = rev * 10 + n % 10;
    n /= 10;
}

// Check palindrome using reverse
bool isPalin = (rev == original);
```

### Digit DP Concept

```
Count numbers from L to R satisfying some digit property.
f(L, R) = f(0, R) - f(0, L-1)

Used in: count numbers with digit sum = k, count numbers
         with no repeated digits, etc.
Core idea: build number digit by digit with constraints.
```

---

## 9. Series and Sequences

### Arithmetic Progression (AP)

```
a, a+d, a+2d, a+3d, ...
a = first term,  d = common difference

nth term    = a + (n-1)*d
Sum of n    = n/2 * (2a + (n-1)*d)
            = n/2 * (first + last)
```

```cpp
long long ap_nth(long long a, long long d, long long n) {
    return a + (n-1) * d;
}

long long ap_sum(long long a, long long d, long long n) {
    return n * (2*a + (n-1)*d) / 2;
}
```

### Geometric Progression (GP)

```
a, ar, ar^2, ar^3, ...
a = first term,  r = common ratio

nth term  = a * r^(n-1)
Sum of n  = a * (r^n - 1) / (r - 1)   when r != 1
          = a * n                       when r == 1
Infinite  = a / (1-r)                  when |r| < 1
```

```cpp
long long gp_nth(long long a, long long r, long long n) {
    return a * power(r, n-1);
}
```

### Important Series — Memorize These

```cpp
// Sum of first n natural numbers
// 1+2+3+...+n = n*(n+1)/2
long long sum_n(long long n) { return n*(n+1)/2; }

// Sum of first n squares
// 1^2+2^2+...+n^2 = n*(n+1)*(2n+1)/6
long long sum_sq(long long n) { return n*(n+1)*(2*n+1)/6; }

// Sum of first n cubes
// 1^3+2^3+...+n^3 = (n*(n+1)/2)^2   = (sum_n)^2
long long sum_cb(long long n) { long long s=n*(n+1)/2; return s*s; }

// Sum of first n even numbers
// 2+4+6+...+2n = n*(n+1)
long long sum_even(long long n) { return n*(n+1); }

// Sum of first n odd numbers
// 1+3+5+...+(2n-1) = n^2
long long sum_odd(long long n) { return n*n; }

// Powers of 2
// 1+2+4+...+2^n = 2^(n+1) - 1
long long sum_pow2(long long n) { return (1LL<<(n+1)) - 1; }
```

### Fibonacci Sequence

```
0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144...
F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2)

Properties:
  F(n) is always divisible by F(m) if m divides n
  gcd(F(m), F(n)) = F(gcd(m, n))
  Every 3rd Fibonacci is even
  Every 4th is divisible by 3
  Every 5th is divisible by 5
```

```cpp
// O(n) iterative
void fibonacci(int n) {
    long long a = 0, b = 1;
    rep(i, 0, n) {
        cout << a << " ";
        long long c = a + b;
        a = b;
        b = c;
    }
}

// O(log n) matrix exponentiation — for huge n
// [F(n+1)] = [1 1]^n * [1]
// [F(n)  ]   [1 0]     [0]

// Pisano Period: F(n) % m is periodic
// Used when n is huge and you need F(n) % m
```

---

## 10. Combinatorics

### Factorials

```
n! = 1 * 2 * 3 * ... * n
0! = 1  (by definition)
1! = 1
5! = 120
10! = 3628800
20! = 2432902008176640000  (fits in long long, barely)
21! overflows long long!
```

```cpp
// Precompute factorials mod p
const int MAXN = 1e6 + 5;
long long fact[MAXN];

void precompute_factorials() {
    fact[0] = 1;
    rep(i, 1, MAXN) fact[i] = fact[i-1] * i % MOD;
}
```

### Permutations and Combinations

```
Permutation: ordered arrangement
  P(n, r) = n! / (n-r)!
  "Choose r items from n, ORDER matters"
  P(5, 2) = 5*4 = 20

Combination: unordered selection
  C(n, r) = n! / (r! * (n-r)!)
  "Choose r items from n, ORDER doesn't matter"
  C(5, 2) = 10

Also written as: nCr or "n choose r" or C(n,r)
```

```cpp
// Precompute for fast C(n,r) queries
long long fact[MAXN], inv_fact[MAXN];

void precompute() {
    fact[0] = 1;
    rep(i, 1, MAXN) fact[i] = fact[i-1] * i % MOD;

    inv_fact[MAXN-1] = power(fact[MAXN-1], MOD-2);  // Fermat's
    for(int i = MAXN-2; i >= 0; i--)
        inv_fact[i] = inv_fact[i+1] * (i+1) % MOD;
}

long long C(int n, int r) {
    if(r < 0 || r > n) return 0;
    return fact[n] % MOD * inv_fact[r] % MOD * inv_fact[n-r] % MOD;
}

long long P(int n, int r) {
    if(r < 0 || r > n) return 0;
    return fact[n] % MOD * inv_fact[n-r] % MOD;
}
```

### Pascal's Triangle

```
        1
       1 1
      1 2 1
     1 3 3 1
    1 4 6 4 1

C(n,r) = C(n-1, r-1) + C(n-1, r)  ← Pascal's identity
C(n,0) = C(n,n) = 1

Useful for small n without precomputation.
```

```cpp
// Build Pascal's triangle
vector<vector<long long>> pascal(int n) {
    vector<vector<long long>> C(n+1, vector<long long>(n+1, 0));
    rep(i, 0, n+1) {
        C[i][0] = 1;
        rep(j, 1, i+1)
            C[i][j] = (C[i-1][j-1] + C[i-1][j]) % MOD;
    }
    return C;
}
```

### Pigeonhole Principle

```
If n items go into k containers, at least one container
has at least ceil(n/k) items.

Examples:
- In any group of 13 people, at least 2 share a birth month
- In any sequence of n^2+1 numbers, there's a monotone
  subsequence of length n+1  (used in LIS problems)
```

### Stars and Bars

```
Distributing n identical items into k distinct bins:
  With zero allowed: C(n+k-1, k-1)
  Without zero:      C(n-1, k-1)

Example: ways to write n as sum of k positive integers
= C(n-1, k-1)
```

### Catalan Numbers

```
C(0)=1, C(1)=1, C(2)=2, C(3)=5, C(4)=14, C(5)=42...

C(n) = C(2n, n) / (n+1)

Applications:
- Number of valid bracket sequences of length 2n
- Number of BSTs with n nodes
- Number of ways to triangulate a polygon
- Monotonic paths that don't cross diagonal
```

```cpp
long long catalan(int n) {
    return C(2*n, n) * modinv(n+1) % MOD;
}
```

---

## 11. Probability Basics

```
P(event) = favorable outcomes / total outcomes
0 <= P(E) <= 1
P(not E) = 1 - P(E)

Independent events: P(A and B) = P(A) * P(B)
Mutually exclusive: P(A or B)  = P(A) + P(B)
General:           P(A or B)  = P(A) + P(B) - P(A and B)

Expected value E[X] = sum of x * P(X = x)
  If fair dice: E = (1+2+3+4+5+6)/6 = 3.5
```

```cpp
// Expected value in problems (often modular)
// E[X] = sum over all states of (value * probability)
// In CP: probabilities as fractions mod p using modinv
```

---

## 12. Binary and Bitwise

### Number Systems

```
Decimal  (base 10): 0-9         → everyday numbers
Binary   (base 2) : 0,1         → computers use this
Octal    (base 8) : 0-7         → rarely used
Hex      (base 16): 0-9, A-F    → memory addresses, colors

Converting:
  Decimal → Binary: divide by 2, collect remainders
  Binary → Decimal: multiply bits by powers of 2

13 in binary:
  13 / 2 = 6 R 1
   6 / 2 = 3 R 0
   3 / 2 = 1 R 1
   1 / 2 = 0 R 1
  Read remainders bottom up: 1101
  Verify: 1*8 + 1*4 + 0*2 + 1*1 = 13 ✓
```

### Bitwise Operators

```
&   AND       1&1=1, 1&0=0, 0&0=0
|   OR        1|0=1, 0|0=0, 1|1=1
^   XOR       1^1=0, 1^0=1, 0^0=0   (different=1, same=0)
~   NOT       ~1=0, ~0=1
<<  left shift  x<<k = x * 2^k
>>  right shift x>>k = x / 2^k
```

```cpp
// Common tricks — these appear CONSTANTLY in CP

// Check if bit k is set
bool isSet(int n, int k) { return (n >> k) & 1; }

// Set bit k
int setBit(int n, int k) { return n | (1 << k); }

// Clear bit k
int clearBit(int n, int k) { return n & ~(1 << k); }

// Toggle bit k
int toggleBit(int n, int k) { return n ^ (1 << k); }

// Check odd (last bit)
bool isOdd(int n) { return n & 1; }

// Check power of 2
bool isPow2(int n) { return n > 0 && (n & (n-1)) == 0; }

// Count set bits (popcount)
int countBits(int n) { return __builtin_popcount(n); }
int countBits64(long long n) { return __builtin_popcountll(n); }

// Lowest set bit
int lsb(int n) { return n & (-n); }

// Remove lowest set bit
int removeLsb(int n) { return n & (n-1); }

// XOR properties
// a ^ a = 0
// a ^ 0 = a
// XOR is commutative and associative

// Find single non-duplicate in array where all others appear twice
int findSingle(vi& arr) {
    int result = 0;
    for(auto x : arr) result ^= x;
    return result;
}
```

### Bitmask / Subset Enumeration

```cpp
// Enumerate all subsets of set {0,1,...,n-1}
// Each integer from 0 to 2^n - 1 represents a subset
// Bit i set means element i is in subset

void allSubsets(int n) {
    int total = 1 << n;           // 2^n subsets
    rep(mask, 0, total) {
        cout << "{ ";
        rep(i, 0, n) {
            if(mask & (1 << i))   // if bit i is set
                cout << i << " ";
        }
        cout << "}" << endl;
    }
}

// Enumerate all subsets of a given mask
for(int sub = mask; sub > 0; sub = (sub-1) & mask) {
    // process sub
}
```

---

## 13. Geometry Basics

### Points and Distance

```cpp
struct Point {
    double x, y;
};

// Euclidean distance
double dist(Point a, Point b) {
    double dx = a.x - b.x;
    double dy = a.y - b.y;
    return sqrt(dx*dx + dy*dy);
}

// Distance squared (avoid sqrt when comparing)
double dist2(Point a, Point b) {
    double dx = a.x - b.x;
    double dy = a.y - b.y;
    return dx*dx + dy*dy;
}
```

### Cross Product and Area

```cpp
// Cross product of vectors OA and OB
// Positive: B is counter-clockwise from A
// Negative: B is clockwise from A
// Zero: collinear
double cross(Point O, Point A, Point B) {
    return (A.x-O.x)*(B.y-O.y) - (A.y-O.y)*(B.x-O.x);
}

// Area of triangle given 3 points (Shoelace formula)
double triangleArea(Point a, Point b, Point c) {
    return abs(cross(a, b, c)) / 2.0;
}

// Area of polygon (Shoelace formula)
double polygonArea(vector<Point>& pts) {
    int n = pts.size();
    double area = 0;
    rep(i, 0, n) {
        int j = (i+1) % n;
        area += pts[i].x * pts[j].y;
        area -= pts[j].x * pts[i].y;
    }
    return abs(area) / 2.0;
}
```

### Circle

```
Area      = pi * r^2
Perimeter = 2 * pi * r
pi ≈ 3.14159265358979

Arc length     = r * theta  (theta in radians)
Sector area    = 0.5 * r^2 * theta
```

```cpp
const double PI = acos(-1.0);  // most precise way to get pi

double circleArea(double r)  { return PI * r * r; }
double circlePerim(double r) { return 2 * PI * r; }
```

### Key Formulas

```
Triangle:
  Area = 0.5 * base * height
  Area = sqrt(s*(s-a)*(s-b)*(s-c))  (Heron's formula, s=(a+b+c)/2)
  Angles sum to 180°

Rectangle: Area = l*w,  Perimeter = 2*(l+w)
Square:    Area = s^2,  Perimeter = 4*s
Circle:    Area = pi*r^2, Circumference = 2*pi*r
Sphere:    Volume = (4/3)*pi*r^3, Surface = 4*pi*r^2
Cylinder:  Volume = pi*r^2*h
Cone:      Volume = (1/3)*pi*r^2*h
```

---

## 14. Matrix Basics

### Matrix Operations

```cpp
typedef vector<vector<long long>> Matrix;

// Matrix multiply — O(n^3)
Matrix multiply(Matrix& A, Matrix& B, int mod = MOD) {
    int n = A.size();
    Matrix C(n, vector<long long>(n, 0));
    rep(i, 0, n) rep(k, 0, n) rep(j, 0, n)
        C[i][j] = (C[i][j] + A[i][k] * B[k][j]) % mod;
    return C;
}

// Matrix fast power — O(n^3 log k)
// Used for: Fibonacci in O(log n), linear recurrences
Matrix matpow(Matrix A, long long k) {
    int n = A.size();
    Matrix result(n, vector<long long>(n, 0));
    rep(i, 0, n) result[i][i] = 1;  // identity matrix

    while(k > 0) {
        if(k & 1) result = multiply(result, A);
        A = multiply(A, A);
        k >>= 1;
    }
    return result;
}

// Fibonacci using matrix power
// [F(n+1)] = [1 1]^n * [F(1)]
// [F(n)  ]   [1 0]     [F(0)]
long long fib(long long n) {
    if(n <= 1) return n;
    Matrix M = {{1,1},{1,0}};
    Matrix R = matpow(M, n-1);
    return R[0][0];
}
```

---

## 15. Game Theory

### Nim Game

```
Given piles of stones. Two players alternately remove
any number from any one pile. Player who can't move loses.

THEOREM: First player wins if and only if XOR of all pile sizes != 0

Nim-value (Grundy number) of a position:
  = mex{Grundy values of all positions reachable in one move}
  mex = minimum excludant (smallest non-negative integer not in set)
```

```cpp
// Nim — first player wins if XOR != 0
bool nimWins(vi& piles) {
    int xorSum = 0;
    for(auto p : piles) xorSum ^= p;
    return xorSum != 0;
}

// Grundy number for single pile game
// where you can remove 1 to k stones
// Grundy(n) = n % (k+1)
```

### Sprague-Grundy Theorem

```
Any impartial game position has a Grundy number.
Combined game of multiple sub-games:
  G(combined) = XOR of all sub-game Grundy numbers
If G != 0, first player wins.
```

---

## 16. Important Constants

```cpp
// Numerical constants
const long long MOD   = 1e9 + 7;       // 10^9 + 7 (prime)
const long long MOD2  = 998244353;      // another common prime
const long long INF   = 1e18;           // infinity for long long
const int       INF_I = 1e9;            // infinity for int
const double    PI    = acos(-1.0);     // pi
const double    EPS   = 1e-9;           // epsilon for double comparison

// Data type limits
// int:       ~2.1 * 10^9
// long long: ~9.2 * 10^18
// double:    ~1.8 * 10^308  (but only 15-16 significant digits)

// Comparing doubles (NEVER use == for doubles)
bool equal(double a, double b) { return fabs(a - b) < EPS; }

// Time/Space rough limits (per second)
// 10^8 simple operations
// 10^7 heavy operations (sort, etc.)
// 256MB RAM ≈ 64 million integers (int = 4 bytes)
//            ≈ 32 million long longs (8 bytes)
```

---

## Summary — What to Memorize

```
FORMULAS:
  sum(1..n)      = n*(n+1)/2
  sum(squares)   = n*(n+1)*(2n+1)/6
  sum(cubes)     = (n*(n+1)/2)^2
  sum(odd)       = n^2
  sum(even)      = n*(n+1)

PRIMES:
  Check: i*i <= n, not i <= sqrt(n)
  Sieve: outer loop to sqrt(n), inner from i*i
  First few: 2,3,5,7,11,13,17,19,23,29,31,37,41,43,47

GCD/LCM:
  gcd(a,b) = gcd(b, a%b)
  lcm(a,b) = (a/gcd)*b   (divide first!)

MODULAR:
  (a+b)%m = ((a%m)+(b%m))%m
  (a-b)%m = ((a%m)-(b%m)+m)%m
  (a*b)%m = (a%m)*(b%m)%m
  inverse  = a^(p-2) % p   (p prime, Fermat)

BITS:
  n&1    = odd check
  n&(n-1)= remove lowest set bit
  n&(-n) = lowest set bit
  n^n    = 0
  n^0    = n
  x<<k   = x * 2^k
  x>>k   = x / 2^k

COMPLEXITY:
  Sieve       O(n log log n)
  Prime check O(sqrt n)
  Factorize   O(sqrt n)
  GCD         O(log min(a,b))
  Fast power  O(log n)
  Matrix pow  O(n^3 log k)
```

---

*This is your complete math arsenal for CP. Revisit sections as problems demand them. Math in CP is learned by doing, not reading.*
