## Build

```
docker build -t shenshouer/quagga .
```

## Usage

```
bash -c "curl https://raw.githubusercontent.com/jpetazzo/pipework/master/pipework" > pipework
chmod +x pipework

mkdir -p {R1,R2}

echo "hostname R2\npassword zebra" > R1/{bgpd,zebra}.conf

R1/bgpd.conf,R1/bgpd.conf:
hostname R1
password zebra

R2/zebra.conf,R2/zebra.conf:
hostname R2
password zebra


echo "hostname R2\npassword zebra" > R2/{bgpd,zebra}.conf

docker run  -P --hostname=R1 --name=R1 -d -v ~/quagga/R1:/etc/quagga shenshouer/docker-quagga
docker run  -P --hostname=R2 --name=R2 -d -v ~/quagga/R2:/etc/quagga shenshouer/docker-quagga

./pipework br0 R1 192.168.255.1/30
./pipework br0 R2 192.168.255.2/30

docker exec -it R1 sh

ifconfig:

eth0      Link encap:Ethernet  HWaddr 02:42:AC:11:00:03
          inet addr:172.17.0.3  Bcast:0.0.0.0  Mask:255.255.0.0
          inet6 addr: fe80::42:acff:fe11:3%32529/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:16 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:1296 (1.2 KiB)  TX bytes:648 (648.0 B)

eth1      Link encap:Ethernet  HWaddr 3A:8E:F2:DE:D1:A2
          inet addr:192.168.255.1  Bcast:192.168.255.3  Mask:255.255.255.252
          inet6 addr: fe80::388e:f2ff:fede:d1a2%32529/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:17 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1338 (1.3 KiB)  TX bytes:690 (690.0 B)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1%32529/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)


/ # ping 192.168.255.2
PING 192.168.255.2 (192.168.255.2): 56 data bytes
64 bytes from 192.168.255.2: seq=0 ttl=64 time=0.087 ms
64 bytes from 192.168.255.2: seq=1 ttl=64 time=0.058 ms
64 bytes from 192.168.255.2: seq=2 ttl=64 time=0.066 ms
64 bytes from 192.168.255.2: seq=3 ttl=64 time=0.066 ms
64 bytes from 192.168.255.2: seq=4 ttl=64 time=0.126 ms
64 bytes from 192.168.255.2: seq=5 ttl=64 time=0.058 ms
64 bytes from 192.168.255.2: seq=6 ttl=64 time=0.067 ms

```
