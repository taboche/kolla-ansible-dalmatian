# kolla-ansible-dalmatian
############################
# 1. Basic Resolution Check
############################

# Standard lookup (uses system resolver)
dig vm01.cloud.example.com

# Short answer only
dig vm01.cloud.example.com +short

# Check TTL
dig vm01.cloud.example.com


#########################################
# 2. Query Specific Authoritative Server
#########################################

# Bypass recursion and query a specific DNS server
dig vm01.cloud.example.com @10.10.10.11 +norecurse

# Query each authoritative node directly
dig vm01.cloud.example.com @bind1 +norecurse
dig vm01.cloud.example.com @bind2 +norecurse
dig vm01.cloud.example.com @bind3 +norecurse


############################
# 3. Trace Delegation Path
############################

# Show full delegation chain from root
dig vm01.cloud.example.com +trace

# Check which server is authoritative
dig vm01.cloud.example.com +authority


############################
# 4. Check SOA Serial Numbers
############################

# Compare zone serial across all servers
dig cloud.example.com SOA @bind1
dig cloud.example.com SOA @bind2
dig cloud.example.com SOA @bind3

# Reverse zone example
dig 10.168.192.in-addr.arpa SOA @bind1


############################
# 5. Full Zone Transfer (Authoritative Truth)
############################

# Dump entire zone from a server
dig AXFR cloud.example.com @bind1

# Reverse zone AXFR
dig AXFR 10.168.192.in-addr.arpa @bind1


############################
# 6. Reverse Lookup Test
############################

dig -x 192.168.10.25
dig -x 192.168.10.25 @bind1 +norecurse


############################
# 7. Check What Resolver Is Using
############################

# See which resolver your host uses
cat /etc/resolv.conf

# Query default resolver directly
dig vm01.cloud.example.com @$(awk '/nameserver/{print $2; exit}' /etc/resolv.conf)


############################
# 8. BIND Runtime Inspection (On DNS Server)
############################

# Show server status
rndc status

# Show zone status
rndc zonestatus cloud.example.com

# Dump runtime DB to file
rndc dumpdb -zones
cat /var/named/data/cache_dump.db | grep vm01

# Flush cache (if recursion enabled)
rndc flush


############################
# 9. Verify Listening and Traffic
############################

# Confirm named is listening
ss -plnt | grep :53

# Live DNS traffic capture
tcpdump -ni any port 53


############################
# 10. DNSSEC (If Enabled)
############################

# Check DNSSEC signatures
dig vm01.cloud.example.com +dnssec

# Validate chain
dig cloud.example.com DNSKEY


############################
# 11. Compare With Designate DB
############################

# Verify OpenStack record
openstack recordset list <zone-id>
openstack recordset show <recordset-id>
