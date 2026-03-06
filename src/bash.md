# Bash and Shell Scripting

> automate everything. never do the same thing twice manually.

---

## what is bash

Bash (Bourne Again SHell) is both a command-line interpreter and a scripting language. when you open a terminal and type commands, you are using bash. when you write a script to automate those commands, you are writing bash.

**shell** — a program that takes your text commands and passes them to the operating system kernel to execute. bash is the most common shell on Linux. zsh is default on Mac.

**why bash matters:**
- automate repetitive tasks (build scripts, deploy scripts, backups)
- system administration (manage files, processes, users)
- glue different programs together
- every Linux server runs bash
- your notes site build script is bash

**bash vs other scripting languages:**
```
bash:   best for file operations, running programs, system tasks
python: best for complex logic, data processing, APIs
both:   bash calls python when logic gets complex
```

---

## how bash works

when you run a command, bash:
1. reads your input
2. parses it (splits into command and arguments)
3. finds the program (searches PATH)
4. executes it
5. shows output

```bash
# this is what happens when you type:
ls -la /home

# bash finds:  /usr/bin/ls     (the actual program)
# arguments:   -la             (flags)
# argument:    /home           (path)
# executes:    /usr/bin/ls -la /home
```

**PATH** — list of directories bash searches for programs:
```bash
echo $PATH
# /usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin

# when you type 'python3', bash searches each directory in order
# finds it at /usr/bin/python3 and runs it
```

---

## essential commands (the basics)

```bash
# navigation
pwd                     # print working directory
ls                      # list files
ls -la                  # list with details and hidden files
ls -lh                  # human readable sizes
cd /path/to/dir         # change directory
cd ~                    # go to home directory
cd -                    # go to previous directory
cd ..                   # go up one level

# files and directories
mkdir mydir             # create directory
mkdir -p a/b/c          # create nested directories
touch file.txt          # create empty file
cp file.txt copy.txt    # copy file
cp -r dir/ newdir/      # copy directory recursively
mv file.txt newname.txt # rename or move
rm file.txt             # delete file
rm -rf directory/       # delete directory (careful!)
ln -s target link       # create symbolic link

# viewing files
cat file.txt            # print entire file
less file.txt           # scroll through file (q to quit)
head file.txt           # first 10 lines
head -20 file.txt       # first 20 lines
tail file.txt           # last 10 lines
tail -f file.txt        # follow file (live updates, logs)
wc -l file.txt          # count lines

# finding things
find . -name "*.md"             # find files by name
find . -type f -name "*.log"    # find files only
find . -type d                  # find directories only
find . -mtime -7                # modified in last 7 days
find . -size +10M               # larger than 10MB
grep "pattern" file.txt         # search in file
grep -r "pattern" .             # search recursively
grep -n "pattern" file.txt      # show line numbers
grep -i "pattern" file.txt      # case insensitive
grep -v "pattern" file.txt      # lines NOT matching

# permissions
chmod +x script.sh      # make executable
chmod 755 script.sh     # rwxr-xr-x
chmod 644 file.txt      # rw-r--r--
chown user:group file   # change owner

# processes
ps aux                  # list all processes
ps aux | grep python    # find python processes
kill 1234               # kill process by PID
kill -9 1234            # force kill
pkill python            # kill by name
top                     # interactive process viewer
htop                    # better interactive viewer

# disk
df -h                   # disk usage (human readable)
du -sh *                # size of each item in current dir
du -sh /path            # size of directory

# network
curl https://example.com           # fetch URL
curl -s https://api.example.com    # silent
curl -X POST -d '{"a":1}' url      # POST request
wget https://example.com/file.zip  # download file
ping google.com                    # check connectivity
ssh user@server                    # connect to server
```

---

## pipes and redirection

pipes and redirection are what make bash powerful. they connect programs together.

**redirection — control where output goes:**
```bash
# stdout (standard output) → file
echo "hello" > file.txt        # write (overwrites)
echo "world" >> file.txt       # append

# stderr (standard error) → file
command 2> errors.log          # redirect errors
command 2>&1                   # redirect stderr to stdout
command > output.log 2>&1      # both to same file
command > /dev/null            # discard output
command 2>/dev/null            # discard errors
command &>/dev/null            # discard everything

# stdin (standard input) from file
command < input.txt

# here string
grep "pattern" <<< "search in this string"

# here document
cat << EOF
line one
line two
line three
EOF
```

**pipes — connect program output to program input:**
```bash
# | sends stdout of left command to stdin of right command

ls -la | grep ".md"            # list only .md files
cat file.txt | wc -l           # count lines
ps aux | grep python           # find process
cat log.txt | sort | uniq      # sort and deduplicate
cat file.txt | sort | uniq -c | sort -rn  # frequency count

# practical examples
ls *.log | xargs rm            # delete all .log files
find . -name "*.pyc" | xargs rm -f   # delete all .pyc files
cat errors.log | grep "ERROR" | tail -20  # last 20 errors
```

---

## text processing

```bash
# grep — search
grep "error" log.txt
grep -E "error|warning" log.txt    # regex, multiple patterns
grep -c "error" log.txt            # count matches
grep -l "error" *.log              # files containing match
grep -B2 -A2 "error" log.txt       # 2 lines before and after

# sed — stream editor, find and replace
sed 's/old/new/' file.txt          # replace first match per line
sed 's/old/new/g' file.txt         # replace all matches
sed 's/old/new/gi' file.txt        # case insensitive
sed -i 's/old/new/g' file.txt      # edit file in place
sed '5d' file.txt                  # delete line 5
sed '/pattern/d' file.txt          # delete lines matching pattern
sed -n '10,20p' file.txt           # print lines 10-20

# awk — process structured text
awk '{print $1}' file.txt          # print first column
awk '{print $1, $3}' file.txt      # print columns 1 and 3
awk -F',' '{print $2}' file.csv    # comma-separated, print col 2
awk '{sum += $1} END {print sum}'  # sum first column
awk 'NR > 1' file.txt              # skip first line
awk '/pattern/ {print}' file.txt   # print matching lines
awk '{print NR, $0}' file.txt      # add line numbers

# sort and unique
sort file.txt                      # alphabetical sort
sort -n file.txt                   # numeric sort
sort -r file.txt                   # reverse
sort -k2 file.txt                  # sort by second column
sort -t',' -k2 file.csv            # CSV, sort by col 2
uniq file.txt                      # remove consecutive duplicates
sort file.txt | uniq               # remove all duplicates
sort file.txt | uniq -c            # count occurrences

# cut — extract columns
cut -d',' -f1 file.csv             # first column of CSV
cut -d':' -f1 /etc/passwd          # usernames
cut -c1-10 file.txt                # first 10 characters

# tr — translate/replace characters
echo "HELLO" | tr 'A-Z' 'a-z'     # to lowercase
echo "hello world" | tr ' ' '_'   # replace spaces
echo "hello" | tr -d 'l'          # delete character
```

---

## writing bash scripts

a bash script is a text file with bash commands, executed in order.

### structure of a script

```bash
#!/bin/bash
# this is the shebang — tells OS to use bash to run this file

# comment explaining what this script does
# author: Abhishek Kumar
# date: 2026-03-06

# ── configuration ──────────────────────────
VARIABLE="value"
ANOTHER_VAR=42

# ── main logic ─────────────────────────────
echo "starting..."

# ── functions ──────────────────────────────
my_function() {
    echo "doing something"
}

my_function
```

**make it executable and run:**
```bash
chmod +x script.sh
./script.sh

# or run with bash directly
bash script.sh
```

---

## variables

```bash
# assignment — NO spaces around =
NAME="abhishek"
AGE=20
PI=3.14

# access with $
echo $NAME
echo "hello $NAME"
echo "hello ${NAME}"          # braces for clarity
echo "hello ${NAME}kumar"     # necessary when followed by text

# command substitution — store output of command
DATE=$(date +%Y-%m-%d)
FILES=$(ls *.md)
COUNT=$(wc -l < file.txt)

# arithmetic
RESULT=$((5 + 3))
RESULT=$((AGE * 2))
RESULT=$(echo "3.14 * 2" | bc)    # floating point (bc)

# readonly variable
readonly MAX_RETRIES=3

# unset variable
unset NAME

# default value
NAME=${NAME:-"stranger"}          # use "stranger" if NAME is empty
PORT=${PORT:-8000}                # use 8000 if PORT not set

# string operations
STR="hello world"
echo ${#STR}                      # length: 11
echo ${STR:0:5}                   # substring: "hello"
echo ${STR:6}                     # from index 6: "world"
echo ${STR/world/there}           # replace: "hello there"
echo ${STR^^}                     # uppercase: "HELLO WORLD"
echo ${STR,,}                     # lowercase: "hello world"
echo ${STR#hello }                # remove prefix: "world"
echo ${STR%world}                 # remove suffix: "hello "
```

---

## special variables

```bash
$0          # script name
$1, $2, $3  # first, second, third argument
$@          # all arguments as separate words
$*          # all arguments as one string
$#          # number of arguments
$?          # exit code of last command (0 = success)
$$          # current process ID (PID)
$!          # PID of last background command
$_          # last argument of previous command

# example usage
echo "script name: $0"
echo "first arg:   $1"
echo "all args:    $@"
echo "arg count:   $#"

# checking exit code
ls /nonexistent 2>/dev/null
echo "exit code: $?"    # 2 (error)
ls /home
echo "exit code: $?"    # 0 (success)
```

---

## conditionals

```bash
# if / elif / else
if [ condition ]; then
    # commands
elif [ other_condition ]; then
    # commands
else
    # commands
fi

# file tests
if [ -f "file.txt" ]; then echo "file exists"; fi
if [ -d "directory" ]; then echo "dir exists"; fi
if [ -e "path" ]; then echo "path exists (file or dir)"; fi
if [ -r "file" ]; then echo "file is readable"; fi
if [ -w "file" ]; then echo "file is writable"; fi
if [ -x "file" ]; then echo "file is executable"; fi
if [ -s "file" ]; then echo "file is not empty"; fi
if [ ! -f "file" ]; then echo "file does not exist"; fi

# string comparisons
if [ "$NAME" = "abhishek" ]; then echo "hello abhi"; fi
if [ "$NAME" != "root" ]; then echo "not root"; fi
if [ -z "$NAME" ]; then echo "name is empty"; fi
if [ -n "$NAME" ]; then echo "name is not empty"; fi

# number comparisons
if [ $AGE -eq 20 ]; then echo "age is 20"; fi
if [ $AGE -ne 20 ]; then echo "not 20"; fi
if [ $AGE -lt 18 ]; then echo "minor"; fi
if [ $AGE -le 18 ]; then echo "18 or less"; fi
if [ $AGE -gt 18 ]; then echo "adult"; fi
if [ $AGE -ge 18 ]; then echo "18 or more"; fi

# compound conditions
if [ $AGE -gt 18 ] && [ "$ROLE" = "admin" ]; then
    echo "adult admin"
fi

if [ $AGE -lt 13 ] || [ "$BANNED" = "true" ]; then
    echo "not allowed"
fi

# modern double brackets (bash specific, more features)
if [[ "$NAME" == *"abhi"* ]]; then echo "contains abhi"; fi   # glob
if [[ "$EMAIL" =~ ^[a-z]+@[a-z]+\.[a-z]+$ ]]; then           # regex
    echo "valid email"
fi
if [[ -f "file.txt" && -r "file.txt" ]]; then
    echo "file exists and is readable"
fi

# one-line shortcuts
[ -f "file.txt" ] && echo "exists"          # if exists, echo
[ -f "file.txt" ] || echo "missing"         # if missing, echo
command && echo "success" || echo "failed"  # ternary-like
```

---

## loops

```bash
# for loop over list
for item in one two three; do
    echo "$item"
done

# for loop over files
for file in *.md; do
    echo "processing: $file"
done

# for loop over array
NAMES=("abhishek" "rahul" "priya")
for name in "${NAMES[@]}"; do
    echo "hello $name"
done

# C-style for loop
for ((i=0; i<10; i++)); do
    echo "$i"
done

# for loop over command output
for user in $(cat /etc/passwd | cut -d: -f1); do
    echo "$user"
done

# while loop
COUNT=0
while [ $COUNT -lt 5 ]; do
    echo "$COUNT"
    COUNT=$((COUNT + 1))
done

# while read — process file line by line
while IFS= read -r line; do
    echo "line: $line"
done < file.txt

# process each line of command output
while IFS='|' read -r name title; do
    echo "name=$name title=$title"
done < data.txt

# until loop — runs until condition is true
until [ -f "done.flag" ]; do
    echo "waiting..."
    sleep 5
done

# break and continue
for i in 1 2 3 4 5; do
    [ $i -eq 3 ] && continue   # skip 3
    [ $i -eq 5 ] && break      # stop at 5
    echo "$i"
done
```

---

## functions

```bash
# define function
greet() {
    echo "hello $1"
}

# call function
greet "abhishek"      # hello abhishek
greet "world"         # hello world

# function with return value
add() {
    echo $(($1 + $2))    # echo is how you "return" a value
}

RESULT=$(add 3 5)     # capture output
echo "$RESULT"        # 8

# function with exit code
file_exists() {
    [ -f "$1" ]        # returns 0 (true) or 1 (false)
}

if file_exists "README.md"; then
    echo "readme found"
fi

# local variables (don't pollute global scope)
calculate() {
    local num1=$1
    local num2=$2
    local result=$((num1 + num2))
    echo "$result"
}

# function with error handling
check_dependency() {
    local cmd=$1
    if ! command -v "$cmd" &>/dev/null; then
        echo "ERROR: $cmd is not installed"
        echo "install with: sudo apt install $cmd"
        exit 1
    fi
}

check_dependency "pandoc"
check_dependency "python3"
```

---

## error handling

```bash
# exit on error — stop script if any command fails
set -e

# exit on undefined variable
set -u

# exit on pipe failure
set -o pipefail

# all three together (put at top of every script)
set -euo pipefail

# trap — run cleanup on exit
cleanup() {
    echo "cleaning up..."
    rm -f "$TMPFILE"
}
trap cleanup EXIT          # runs on any exit
trap cleanup INT TERM      # runs on Ctrl+C or kill

# manual error checking
if ! pandoc input.md -o output.html; then
    echo "ERROR: pandoc failed"
    exit 1
fi

# exit codes
exit 0    # success
exit 1    # general error

# check command exists
if ! command -v git &>/dev/null; then
    echo "git is not installed"
    exit 1
fi
```

---

## arrays

```bash
# declare array
FRUITS=("apple" "banana" "cherry")

# access elements
echo ${FRUITS[0]}          # apple
echo ${FRUITS[1]}          # banana
echo ${FRUITS[-1]}         # cherry (last element)

# all elements
echo ${FRUITS[@]}          # apple banana cherry

# length
echo ${#FRUITS[@]}         # 3

# add element
FRUITS+=("date")

# loop array
for fruit in "${FRUITS[@]}"; do
    echo "$fruit"
done

# loop with index
for i in "${!FRUITS[@]}"; do
    echo "$i: ${FRUITS[$i]}"
done

# associative array (hash map)
declare -A CONFIG
CONFIG["host"]="localhost"
CONFIG["port"]="8000"
CONFIG["debug"]="true"

echo ${CONFIG["host"]}     # localhost
echo ${!CONFIG[@]}         # all keys
echo ${CONFIG[@]}          # all values

for key in "${!CONFIG[@]}"; do
    echo "$key = ${CONFIG[$key]}"
done
```

---

## input and output

```bash
# read user input
read -p "Enter your name: " NAME
echo "Hello $NAME"

# read with timeout
read -t 10 -p "Enter within 10 seconds: " INPUT

# read password (no echo)
read -s -p "Password: " PASSWORD
echo

# read multiple values
read -p "Enter first and last name: " FIRST LAST

# print with formatting
echo "normal text"
echo -e "with \nnewlines \tand tabs"    # -e enables escape sequences
printf "%-20s %5d\n" "item name" 42     # formatted output
printf "Name: %s, Age: %d\n" "$NAME" $AGE

# colors in output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'    # no color / reset

echo -e "${GREEN}success${NC}"
echo -e "${RED}error${NC}"
echo -e "${YELLOW}warning${NC}"
echo -e "${BOLD}bold text${NC}"
```

---

## a real automation example: dev project setup

this script automates everything you do when starting a new project.

```bash
#!/bin/bash
# new-project.sh
# automates setting up a new web project
# usage: ./new-project.sh my-app

set -euo pipefail

# ── colors ────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

# ── helpers ───────────────────────────────────────────────
info()    { echo -e "${BLUE}[info]${NC} $1"; }
success() { echo -e "${GREEN}[done]${NC} $1"; }
warn()    { echo -e "${YELLOW}[warn]${NC} $1"; }
error()   { echo -e "${RED}[error]${NC} $1"; exit 1; }
step()    { echo -e "\n${BOLD}── $1 ──────────────────${NC}"; }

# ── check dependencies ────────────────────────────────────
check_dep() {
    command -v "$1" &>/dev/null || error "$1 is not installed"
}

step "checking dependencies"
check_dep "git"
check_dep "node"
check_dep "npm"
success "all dependencies present"

# ── get project name ──────────────────────────────────────
PROJECT_NAME="${1:-}"

if [ -z "$PROJECT_NAME" ]; then
    read -p "project name: " PROJECT_NAME
fi

if [ -z "$PROJECT_NAME" ]; then
    error "project name cannot be empty"
fi

# sanitize — lowercase, hyphens only
PROJECT_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

# ── check directory doesn't exist ─────────────────────────
if [ -d "$PROJECT_NAME" ]; then
    error "directory '$PROJECT_NAME' already exists"
fi

# ── choose project type ───────────────────────────────────
step "project type"
echo "1) react (vite + tailwind)"
echo "2) vanilla html/css/js"
echo "3) fastapi backend"
read -p "choose [1-3]: " TYPE

# ── create project ────────────────────────────────────────
step "creating project"

case "$TYPE" in
    1)
        info "creating react project..."
        npm create vite@latest "$PROJECT_NAME" -- --template react
        cd "$PROJECT_NAME"

        info "installing dependencies..."
        npm install

        info "installing tailwind..."
        npm install -D tailwindcss postcss autoprefixer
        npx tailwindcss init -p

        # configure tailwind
        cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: { extend: {} },
  plugins: [],
}
EOF
        success "react project created"
        ;;

    2)
        info "creating vanilla project..."
        mkdir -p "$PROJECT_NAME"/{css,js,images}
        cd "$PROJECT_NAME"

        cat > index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${PROJECT_NAME}</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h1>hello world</h1>
    <script src="js/main.js"></script>
</body>
</html>
EOF
        echo "/* styles */" > css/style.css
        echo "// main js" > js/main.js
        success "vanilla project created"
        ;;

    3)
        info "creating fastapi project..."
        mkdir -p "$PROJECT_NAME"
        cd "$PROJECT_NAME"

        python3 -m venv venv
        source venv/bin/activate
        pip install fastapi uvicorn python-dotenv 2>/dev/null

        cat > main.py << 'EOF'
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def root():
    return {"message": "hello world"}
EOF

        cat > requirements.txt << 'EOF'
fastapi
uvicorn
python-dotenv
EOF

        success "fastapi project created"
        ;;

    *)
        error "invalid choice"
        ;;
esac

# ── create .env ───────────────────────────────────────────
step "environment files"
cat > .env << EOF
# ${PROJECT_NAME} environment variables
# DO NOT COMMIT THIS FILE
EOF

# ── create .gitignore ─────────────────────────────────────
cat > .gitignore << 'EOF'
node_modules/
dist/
.env
.env.local
.env.production
*.log
.DS_Store
__pycache__/
*.pyc
venv/
.venv/
EOF

success ".gitignore created"

# ── initialize git ────────────────────────────────────────
step "git setup"
git init
git add .
git commit -m "initial commit: ${PROJECT_NAME}"
success "git initialized"

# ── summary ───────────────────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}project ready!${NC}"
echo -e "  location:  $(pwd)"
echo ""

case "$TYPE" in
    1) echo -e "  run:  ${YELLOW}cd $PROJECT_NAME && npm run dev${NC}" ;;
    2) echo -e "  run:  ${YELLOW}cd $PROJECT_NAME && python3 -m http.server 3000${NC}" ;;
    3) echo -e "  run:  ${YELLOW}cd $PROJECT_NAME && uvicorn main:app --reload${NC}" ;;
esac

echo ""
```

---

## another example: automated backup script

```bash
#!/bin/bash
# backup.sh — backs up important directories to a timestamped archive

set -euo pipefail

# ── config ────────────────────────────────────────────────
BACKUP_DIR="$HOME/backups"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
LOGFILE="$BACKUP_DIR/backup.log"

# directories to back up
SOURCES=(
    "$HOME/notes-site"
    "$HOME/studentos"
    "$HOME/.config/i3"
    "$HOME/.vimrc"
)

# ── setup ─────────────────────────────────────────────────
mkdir -p "$BACKUP_DIR"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
}

# ── check space ───────────────────────────────────────────
AVAILABLE=$(df -m "$BACKUP_DIR" | awk 'NR==2 {print $4}')
if [ "$AVAILABLE" -lt 500 ]; then
    log "ERROR: less than 500MB available"
    exit 1
fi

# ── create backup ─────────────────────────────────────────
ARCHIVE="$BACKUP_DIR/backup_${TIMESTAMP}.tar.gz"

log "starting backup → $ARCHIVE"

# build the tar command dynamically
TAR_ARGS=()
for src in "${SOURCES[@]}"; do
    if [ -e "$src" ]; then
        TAR_ARGS+=("$src")
        log "including: $src"
    else
        log "skipping (not found): $src"
    fi
done

tar -czf "$ARCHIVE" "${TAR_ARGS[@]}" 2>/dev/null

SIZE=$(du -sh "$ARCHIVE" | cut -f1)
log "backup complete: $ARCHIVE ($SIZE)"

# ── keep only last 7 backups ──────────────────────────────
log "cleaning old backups..."
ls -t "$BACKUP_DIR"/backup_*.tar.gz | tail -n +8 | while read -r old; do
    rm "$old"
    log "deleted old backup: $(basename $old)"
done

log "done."
echo "backup saved: $ARCHIVE ($SIZE)"
```

---

## useful patterns

```bash
# check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "please run as root"
    exit 1
fi

# check number of arguments
if [ "$#" -ne 2 ]; then
    echo "usage: $0 <source> <destination>"
    exit 1
fi

# create temp file and auto-delete on exit
TMPFILE=$(mktemp)
trap "rm -f $TMPFILE" EXIT

# run command, retry on failure
retry() {
    local max=$1; shift
    local delay=$2; shift
    local count=0
    until "$@"; do
        count=$((count + 1))
        [ $count -ge $max ] && return 1
        echo "attempt $count failed, retrying in ${delay}s..."
        sleep "$delay"
    done
}

retry 3 5 curl https://api.example.com/health

# spinner for long operations
spinner() {
    local pid=$1
    local chars="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
    while kill -0 "$pid" 2>/dev/null; do
        for char in $(echo "$chars" | grep -o .); do
            printf "\r%s working..." "$char"
            sleep 0.1
        done
    done
    printf "\r"
}

some_long_command &
spinner $!
wait $!

# parallel execution
for file in *.md; do
    process_file "$file" &    # run in background
done
wait                          # wait for all to finish

# progress bar
show_progress() {
    local current=$1
    local total=$2
    local width=40
    local pct=$((current * 100 / total))
    local filled=$((current * width / total))
    local bar=$(printf '%*s' "$filled" '' | tr ' ' '█')
    local empty=$(printf '%*s' "$((width - filled))" '' | tr ' ' '░')
    printf "\r[%s%s] %d%% (%d/%d)" "$bar" "$empty" "$pct" "$current" "$total"
}

TOTAL=100
for i in $(seq 1 $TOTAL); do
    sleep 0.05
    show_progress $i $TOTAL
done
echo ""
```

---

## cron jobs — schedule scripts

cron runs scripts automatically on a schedule.

```bash
# edit crontab
crontab -e

# cron syntax:
# ┌───── minute (0-59)
# │ ┌─── hour (0-23)
# │ │ ┌─ day of month (1-31)
# │ │ │ ┌ month (1-12)
# │ │ │ │ ┌ day of week (0=Sunday)
# │ │ │ │ │
# * * * * * command

# examples
0 * * * *     ~/backup.sh              # every hour
0 2 * * *     ~/backup.sh              # every day at 2am
0 2 * * 0     ~/weekly-backup.sh       # every Sunday at 2am
*/15 * * * *  ~/check-server.sh        # every 15 minutes
0 9 * * 1-5   ~/standup-reminder.sh    # weekdays at 9am

# run build script every time you push (via git hook instead)
# .git/hooks/pre-push
#!/bin/bash
./build.sh
```

---

## debugging scripts

```bash
# run with debug output
bash -x script.sh              # trace every command
bash -v script.sh              # verbose (show lines as read)
bash -n script.sh              # syntax check only (don't run)

# enable debug inside script
set -x                         # start tracing
# ... your code ...
set +x                         # stop tracing

# print debug info
echo "DEBUG: variable=$VARIABLE"    # simple
>&2 echo "DEBUG: something"         # print to stderr
```

---

## quick reference

```bash
# set options (put at top of every script)
set -euo pipefail

# string tests
[ -z "$VAR" ]    # empty
[ -n "$VAR" ]    # not empty
[ "$A" = "$B" ]  # equal
[ "$A" != "$B" ] # not equal

# file tests
[ -f file ]   # is regular file
[ -d dir ]    # is directory
[ -e path ]   # exists
[ -r file ]   # readable
[ -w file ]   # writable
[ -x file ]   # executable

# number tests
[ $A -eq $B ]  # equal
[ $A -ne $B ]  # not equal
[ $A -lt $B ]  # less than
[ $A -le $B ]  # less than or equal
[ $A -gt $B ]  # greater than
[ $A -ge $B ]  # greater than or equal

# arithmetic
$(( a + b ))   # add
$(( a - b ))   # subtract
$(( a * b ))   # multiply
$(( a / b ))   # divide (integer)
$(( a % b ))   # modulo
$(( a ** b ))  # power
```

---

```
=^._.^= automate the boring. focus on the interesting.
```
