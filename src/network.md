# Networking

> how computers talk to each other.

---

## what is a network

a network is two or more computers connected together to share data and resources. the internet is just the world's largest network.

**types of networks:**
- **LAN** (Local Area Network) → your home/office network
- **WAN** (Wide Area Network) → connects cities/countries (internet)
- **MAN** (Metropolitan Area Network) → city-wide network
- **PAN** (Personal Area Network) → Bluetooth, very short range

---

## OSI model

the 7-layer model that explains how data travels from one computer to another. think of it as 7 departments — each has one job.

```
Layer 7 │ Application  │ what the user sees (HTTP, FTP, SMTP)
Layer 6 │ Presentation │ encryption, compression (SSL/TLS)
Layer 5 │ Session      │ managing connections (sessions)
Layer 4 │ Transport    │ end-to-end delivery (TCP, UDP)
Layer 3 │ Network      │ routing between networks (IP)
Layer 2 │ Data Link    │ node-to-node (MAC address, Ethernet)
Layer 1 │ Physical     │ actual bits on wire (cables, WiFi)
```

**mnemonic:** "All People Seem To Need Data Processing"

**how it works in practice:**
```
you send "GET / HTTP/1.1"

Layer 7: HTTP adds request headers
Layer 6: TLS encrypts the data
Layer 5: session is managed
Layer 4: TCP breaks into segments, adds port numbers
Layer 3: IP adds source/destination IP address
Layer 2: Ethernet adds MAC addresses
Layer 1: converted to electrical signals and sent
```

on the receiving end, it's unwrapped from layer 1 back to layer 7.

---

## TCP/IP model

the practical 4-layer model actually used on the internet:

```
Application  → HTTP, HTTPS, DNS, FTP, SMTP, SSH (OSI layers 5-7)
Transport    → TCP, UDP (OSI layer 4)
Internet     → IP, ICMP, ARP (OSI layer 3)
Network      → Ethernet, WiFi (OSI layers 1-2)
```

---

## IP addresses

every device on a network has an IP address — like a postal address for computers.

**IPv4:**
```
192.168.1.100
  ↑   ↑  ↑  ↑
  4 octets, each 0-255
  32 bits total
  ~4.3 billion addresses (running out)
```

**IPv6:**
```
2001:0db8:85a3:0000:0000:8a2e:0370:7334
  64 bits network + 64 bits host
  128 bits total
  340 undecillion addresses
```

**special addresses:**
```
127.0.0.1          → localhost (your own machine)
0.0.0.0            → all interfaces
255.255.255.255    → broadcast
192.168.x.x        → private (home networks)
10.x.x.x           → private (corporate)
172.16.x.x - 172.31.x.x → private
```

**CIDR notation:**
```
192.168.1.0/24
            ↑ 24 bits for network, 8 bits for hosts
            = 256 addresses (192.168.1.0 to 192.168.1.255)

192.168.0.0/16  → 65536 addresses
10.0.0.0/8      → 16 million addresses
```

**subnetting:**
dividing a network into smaller networks
```
192.168.1.0/24 can be split into:
192.168.1.0/25   → first 128 addresses
192.168.1.128/25 → last 128 addresses
```

---

## MAC address

physical address burned into network hardware (NIC card)

```
AA:BB:CC:DD:EE:FF
↑↑↑↑↑↑  ↑↑↑↑↑↑
vendor  device unique

48 bits, written in hex
globally unique (in theory)
```

- IP address = logical, can change
- MAC address = physical, permanent
- ARP (Address Resolution Protocol) maps IP → MAC

---

## TCP vs UDP

**TCP (Transmission Control Protocol)**
connection-oriented, reliable, ordered delivery

```
1. three-way handshake to connect:
   client → SYN    → server
   client ← SYN-ACK ← server
   client → ACK    → server

2. data sent in segments
3. receiver sends ACK for each segment
4. lost segments are retransmitted
5. four-way handshake to close

use for: HTTP, SSH, email, file transfer
anything where accuracy matters
```

**UDP (User Datagram Protocol)**
connectionless, no guarantee of delivery, very fast

```
just sends packets — no handshake, no ACK, no retransmit
if packet is lost → it's lost

use for: video streaming, gaming, DNS, VoIP
anything where speed > accuracy
live video with one dropped frame is better than
waiting for retransmission (would cause freeze)
```

| feature | TCP | UDP |
|---|---|---|
| connection | yes | no |
| reliable | yes | no |
| ordered | yes | no |
| speed | slower | faster |
| overhead | high | low |
| use | HTTP, SSH | video, games |

---

## ports

ports identify which application gets the incoming data.

```
IP address = which machine
Port       = which application on that machine

192.168.1.100:80  → machine at 192.168.1.100, web server
```

**well-known ports (0-1023):**
```
20, 21  → FTP (file transfer)
22      → SSH (secure shell)
23      → Telnet (insecure, avoid)
25      → SMTP (send email)
53      → DNS (domain names)
67, 68  → DHCP (IP assignment)
80      → HTTP (web)
110     → POP3 (receive email)
143     → IMAP (receive email)
443     → HTTPS (secure web)
3306    → MySQL
5432    → PostgreSQL
6379    → Redis
27017   → MongoDB
8080    → HTTP alternate
```

**registered ports (1024-49151)** → applications
**dynamic ports (49152-65535)** → temporary, assigned by OS

---

## DNS (Domain Name System)

translates human-readable domain names to IP addresses.

```
google.com → 142.250.80.46
```

**DNS hierarchy:**
```
. (root)
├── com
│   ├── google.com
│   │   ├── www.google.com
│   │   └── mail.google.com
│   └── github.com
├── org
│   └── wikipedia.org
└── in
    └── irctc.co.in
```

**DNS resolution process:**
```
1. browser cache
2. OS cache (/etc/hosts)
3. recursive resolver (your ISP/8.8.8.8)
4. root nameserver → where is .com?
5. TLD nameserver (.com) → where is google.com?
6. authoritative nameserver → google.com is 142.250.80.46
7. response cached and returned
```

**DNS record types:**
```
A     → domain to IPv4 address
AAAA  → domain to IPv6 address
CNAME → alias to another domain (www → example.com)
MX    → mail server for domain
TXT   → arbitrary text (SPF, DKIM, verification)
NS    → nameservers for domain
PTR   → reverse DNS (IP to domain)
SOA   → start of authority record
SRV   → service record (host, port, priority)
```

**TTL (Time To Live)** → how long to cache the record (in seconds)

**DNS tools:**
```bash
dig google.com          # detailed DNS lookup
dig google.com MX       # specific record type
dig @8.8.8.8 google.com # use specific resolver
nslookup google.com     # simple lookup
host google.com         # simple lookup
```

---

## HTTP

the protocol for web communication. stateless request-response protocol.

**HTTP request structure:**
```
GET /users/123 HTTP/1.1          ← method, path, version
Host: api.example.com            ←
Authorization: Bearer token      ← headers
Content-Type: application/json   ←
                                 ← blank line
{ "name": "abhishek" }           ← body (for POST/PUT)
```

**HTTP response structure:**
```
HTTP/1.1 200 OK                  ← version, status code
Content-Type: application/json   ← headers
Content-Length: 45               ←
                                 ← blank line
{ "id": 123, "name": "abhishek" } ← body
```

**HTTP methods:**
```
GET     → read data (safe, idempotent)
POST    → create data
PUT     → replace data (idempotent)
PATCH   → update partial data
DELETE  → delete data (idempotent)
HEAD    → like GET but no body (check if resource exists)
OPTIONS → what methods are allowed
```

**idempotent** = same request multiple times = same result
(GET, PUT, DELETE are idempotent. POST is not)

**status codes:**
```
1xx → informational
100 Continue

2xx → success
200 OK
201 Created
204 No Content

3xx → redirect
301 Moved Permanently
302 Found (temporary redirect)
304 Not Modified (cached)

4xx → client error
400 Bad Request
401 Unauthorized (not logged in)
403 Forbidden (logged in but no permission)
404 Not Found
405 Method Not Allowed
409 Conflict
422 Unprocessable Entity
429 Too Many Requests

5xx → server error
500 Internal Server Error
502 Bad Gateway
503 Service Unavailable
504 Gateway Timeout
```

**HTTP headers:**
```
Request headers:
Authorization: Bearer <token>
Content-Type: application/json
Accept: application/json
User-Agent: Mozilla/5.0...
Cookie: session=abc
Origin: https://myapp.com
If-Modified-Since: ...

Response headers:
Content-Type: application/json
Cache-Control: max-age=3600
Set-Cookie: session=abc; HttpOnly
Access-Control-Allow-Origin: *
Location: /users/123  (for 301/302)
```

---

## HTTPS and TLS

HTTP + TLS (Transport Layer Security) = HTTPS

TLS provides:
- **encryption** → data is unreadable if intercepted
- **authentication** → server is who it claims to be (certificate)
- **integrity** → data hasn't been tampered with

**TLS handshake:**
```
1. client hello → supported TLS versions, cipher suites
2. server hello → chosen version, cipher, certificate
3. client verifies certificate with CA
4. key exchange → agree on session key
5. encrypted communication begins
```

**certificates:**
- issued by Certificate Authority (CA) like Let's Encrypt, DigiCert
- contains: domain, public key, issuer, expiry
- self-signed = no CA, browser shows warning

**getting HTTPS for free:**
```bash
# Let's Encrypt with Certbot
sudo apt install certbot
sudo certbot --nginx -d example.com
# auto-renews every 90 days
```

---

## HTTP versions

**HTTP/1.0**
- new TCP connection for every request
- slow, lots of overhead

**HTTP/1.1**
- persistent connections (keep-alive)
- pipelining (send multiple requests without waiting)
- still has head-of-line blocking

**HTTP/2**
- multiplexing: multiple requests over one connection simultaneously
- header compression (HPACK)
- server push
- binary protocol (not text)
- ~30% faster than HTTP/1.1

**HTTP/3**
- uses QUIC instead of TCP
- UDP-based (faster)
- no head-of-line blocking at transport layer
- better on mobile/lossy networks

---

## WebSockets

persistent bidirectional connection between client and server.

```
1. HTTP upgrade request:
   GET /chat HTTP/1.1
   Upgrade: websocket
   Connection: Upgrade

2. server responds 101 Switching Protocols

3. persistent TCP connection open
   client ←→ server (both can send anytime)

4. close when done
```

**when to use:**
- real-time chat
- live notifications
- multiplayer games
- live trading/stock prices
- collaborative editing (Google Docs style)

**vs polling:**
```
polling:  client asks every 1 second → wasteful
long polling: client asks, server holds → better
WebSocket: server pushes when needed → best
```

---

## CORS (Cross-Origin Resource Sharing)

browser security feature that blocks requests from different origins.

**same origin:** same protocol + domain + port
```
https://app.com → https://app.com/api   → same origin ✓
https://app.com → https://api.app.com   → different ✗
https://app.com → http://app.com        → different ✗
https://app.com → https://app.com:3000  → different ✗
```

**preflight request:** for non-simple requests, browser sends OPTIONS first
```
OPTIONS /api/users
Origin: https://myapp.com
Access-Control-Request-Method: POST
```

**server must respond with:**
```
Access-Control-Allow-Origin: https://myapp.com
Access-Control-Allow-Methods: GET, POST, PUT, DELETE
Access-Control-Allow-Headers: Authorization, Content-Type
```

**in practice (Express.js):**
```javascript
const cors = require('cors')
app.use(cors({
  origin: 'https://myapp.com',
  methods: ['GET', 'POST', 'PUT', 'DELETE']
}))
```

---

## firewalls

controls incoming and outgoing network traffic based on rules.

**types:**
- **packet filtering** → filter by IP, port, protocol (fast, basic)
- **stateful** → tracks connections, more intelligent
- **application firewall (WAF)** → understands HTTP, blocks SQL injection etc.

**iptables (Linux):**
```bash
# list rules
iptables -L

# allow port 80
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# block IP
iptables -A INPUT -s 1.2.3.4 -j DROP

# allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
```

**ufw (simpler):**
```bash
ufw enable
ufw allow 22
ufw allow 80/tcp
ufw allow 443/tcp
ufw deny 3306          # block MySQL from outside
ufw status verbose
```

---

## NAT (Network Address Translation)

translates private IP addresses to public IPs.

```
your laptop: 192.168.1.5 (private)
      ↓
router does NAT
      ↓
internet sees: 203.0.113.5 (public)

multiple devices share one public IP
```

**why:** IPv4 addresses are limited. NAT lets thousands of devices share one public IP.

**port forwarding:** map external port to internal IP:port
```
external: 203.0.113.5:8080
               ↓ forward
internal: 192.168.1.10:80
```

---

## VPN (Virtual Private Network)

creates encrypted tunnel over public internet, makes you appear to be on a private network.

```
your device → encrypted tunnel → VPN server → internet
```

**how it works:**
1. connect to VPN server
2. all traffic encrypted and sent to VPN server
3. VPN server forwards to destination
4. response comes back through VPN

**protocols:**
- **OpenVPN** → open source, widely used
- **WireGuard** → modern, fast, simple
- **IPSec** → widely supported, complex
- **SSL/TLS VPN** → through browser

**use cases:**
- secure connection on public WiFi
- access private company network remotely
- bypass geo-restrictions

---

## proxies

**forward proxy:**
```
client → proxy → server
```
client hides behind proxy. server sees proxy's IP.
use: privacy, content filtering, caching

**reverse proxy:**
```
client → reverse proxy → backend servers
```
server hides behind proxy. client sees proxy's IP.
use: load balancing, SSL termination, caching, security

**Nginx as reverse proxy:**
```nginx
server {
    listen 80;
    server_name example.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

---

## network tools

```bash
# connectivity
ping google.com              # basic connectivity
ping -c 4 google.com         # 4 packets
ping6 google.com             # IPv6

# route tracing
traceroute google.com        # trace path to host
mtr google.com               # real-time traceroute

# DNS
dig google.com               # DNS lookup
dig google.com A             # specific record
dig google.com MX            # mail records
nslookup google.com          # simple lookup
host google.com

# port scanning
nmap localhost               # scan local machine
nmap -p 80,443 example.com   # specific ports
nmap -sV localhost           # service versions
nmap -A localhost            # aggressive scan

# connections
ss -tulnp                    # listening sockets (modern)
netstat -tulnp               # older
ss -s                        # summary

# HTTP testing
curl https://example.com                    # fetch URL
curl -I https://example.com                 # headers only
curl -X POST -d '{}' -H "Content-Type: application/json" url
curl -v https://example.com                 # verbose
wget https://example.com/file              # download
httpie https://example.com                 # better than curl

# bandwidth
iftop                        # per-connection bandwidth
nethogs                      # per-process bandwidth
iperf3 -s                    # bandwidth test server
iperf3 -c server-ip          # bandwidth test client

# packet capture
tcpdump -i eth0              # capture all packets
tcpdump -i eth0 port 80      # only port 80
tcpdump -i eth0 host 1.2.3.4 # only from IP
wireshark                    # GUI packet analyzer
```

---

## network protocols summary

```
FTP   (21)  → file transfer (unencrypted, old)
SFTP  (22)  → file transfer over SSH
SSH   (22)  → secure remote shell
SMTP  (25)  → send email
DNS   (53)  → domain name resolution
DHCP  (67)  → auto IP assignment
HTTP  (80)  → web traffic
POP3  (110) → retrieve email (download)
IMAP  (143) → retrieve email (sync)
HTTPS (443) → secure web traffic
SMB   (445) → Windows file sharing
LDAP  (389) → directory services
RDP   (3389)→ Windows remote desktop
```

---

## DHCP (Dynamic Host Configuration Protocol)

automatically assigns IP addresses to devices on a network.

```
1. new device joins network (DHCP Discover broadcast)
2. DHCP server offers IP address (DHCP Offer)
3. device accepts offer (DHCP Request)
4. server confirms (DHCP ACK)
5. device uses IP until lease expires
```

without DHCP you'd have to manually set IP on every device.

---

## ARP (Address Resolution Protocol)

maps IP addresses to MAC addresses on local network.

```
"who has 192.168.1.1?" (broadcast)
"I have 192.168.1.1, my MAC is AA:BB:CC:DD:EE:FF"
```

cached in ARP table:
```bash
arp -a      # view ARP table
arp -n      # without resolving hostnames
```

**ARP poisoning:** attacker sends fake ARP replies to redirect traffic (MITM attack)

---

## BGP (Border Gateway Protocol)

the routing protocol of the internet. routers use BGP to decide how to forward packets between autonomous systems (large networks like ISPs).

```
AS1 (Jio) ←→ BGP ←→ AS2 (Google)
```

**autonomous system (AS)** = large network under single management (ISP, university, company)

BGP is why the internet "heals" when routes go down — BGP converges on new paths.

---

## network security

**common attacks:**

**DDoS (Distributed Denial of Service)**
```
millions of infected devices (botnet)
flood target with traffic
target can't serve real users
```
mitigation: CDN, rate limiting, scrubbing centers, Cloudflare

**man-in-the-middle (MITM)**
```
attacker intercepts communication between A and B
A → [attacker] → B
```
mitigation: HTTPS, certificate pinning, VPN

**DNS spoofing**
```
attacker poisons DNS cache
google.com → attacker's IP instead of Google's
```
mitigation: DNSSEC, use trusted DNS resolver

**port scanning**
```
attacker scans all ports to find open services
```
mitigation: firewall, close unused ports, fail2ban

**SQL injection (application layer)**
```
input: '; DROP TABLE users; --
```
mitigation: parameterized queries, input validation

**SSL stripping**
```
downgrade HTTPS to HTTP
```
mitigation: HSTS (HTTP Strict Transport Security)

---

## cloud networking basics

**VPC (Virtual Private Cloud)**
your own isolated network in the cloud

```
VPC: 10.0.0.0/16
├── public subnet: 10.0.1.0/24   (has internet gateway)
│   └── web servers, load balancers
└── private subnet: 10.0.2.0/24  (no direct internet)
    └── databases, app servers
```

**security groups** = virtual firewall for cloud instances
**network ACL** = subnet-level firewall

**internet gateway** = allows public subnet to reach internet
**NAT gateway** = allows private subnet to reach internet (outbound only)

**load balancer types in cloud:**
- **ALB** (Application Load Balancer) → HTTP/HTTPS, L7
- **NLB** (Network Load Balancer) → TCP/UDP, L4, very fast
- **GLB** (Gateway Load Balancer) → for firewalls/inspection

---

```
=^._.^= the internet is just computers talking nicely
```
