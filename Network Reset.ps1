# Reset Winsock catalog
netsh winsock reset

# Reset TCP/IP stack
netsh int ip reset

# Flush DNS resolver cache
ipconfig /flushdns

# Renew DHCP lease
ipconfig /renew