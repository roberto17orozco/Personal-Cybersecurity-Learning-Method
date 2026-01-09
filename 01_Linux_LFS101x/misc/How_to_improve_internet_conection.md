# IMPROVING PRIVATE INTERNET CONNECTION

On this file I'll write the actions I took to improve my internet conection after realizing I was using a slower internet 
conection though I've always had a better one.

I was used to connect to a **2.4 Ghz band**  and I have a **5 Ghz band** available.

---

## Detecting the current conection.

* Open `Powershell` on Windows (wich is the main/host OS on my computer)
* `netsh wlan show interfaces`

There is 1 interface in the system:

* Nombre                 : Wi-Fi
* Descripción            : Intel(R) Wi-Fi 6 AX200 160MHz
* GUID                   : 41b55e08-9c5a-4cf4-af1c-f156da50c6f9
* Dirección       : d4:54:8b:1f:7a:98
* Tipo de interfaz         : Principal
* Estado                  : conectado
* SSID                   : INFINITUMA99C_2.4
* AP BSSID               : 80:b5:75:c4:79:90
* Banda                 : 2,4 GHz
* Canal: 5
* cifrado Akm conectado: [ akm = 00-0f-ac:02, cifrado = 00-0f-ac:04 ]
* Tipo de red            : Infraestructura
* Tipo de radio          : 802.11n
* Autenticación          : WPA2-Personal
* Cifrado                : CCMP
* Modo de conexión       : Perfil
* Velocidad de recepción (Mbps)   : 144.4
* Velocidad de transmisión (Mbps) : 144.4
* Señal                           : 99%
* Rssi           : -45
* Perfil                 : INFINITUMA99C_2.4
* MSCS de QoS configurado: 0
* Asignación de QoS configurada: 0
* Asignación de QoS permitida por la directiva : 0


**Notice that current:**

* SSID is INFINITUMA99C_2.4
* Band is 2,4 GHZ
* Chanel is channel 5
* Receiving speed is 144.4
* Sending speed is 144.4
* Signal is at 99%

---

## Searching for a better network and connecting to it.

On my computer I searched for a different network that may be better and faster than the current one; I found **INFINITM99AC_5**
To veify it's propeties I connected my computer to that network.

Then I proceeded like this:

* Open `Powershell` on Windows (wich is the main/host OS on my computer) 
* `netsh wlan show interfaces`

Again,there is only 1 interface running:

* Nombre                   : Wi-Fi
* Descripción            : Intel(R) Wi-Fi 6 AX200 160MHz
* GUID                   : 41b55e08-9c5a-4cf4-af1c-f156da50c6f9
* Dirección       : d4:54:8b:1f:7a:98
* Tipo de interfaz         : Principal
* Estado                  : conectado
* SSID                   : INFINITUMA99C_5
* AP BSSID               : 80:b5:75:c4:79:94
* Banda                 : 5 GHz
* Canal: 64
* cifrado Akm conectado: [ akm = 00-0f-ac:02, cifrado = 00-0f-ac:04 ]
* Tipo de red            : Infraestructura
* Tipo de radio          : 802.11ac
* Autenticación          : WPA2-Personal
* Cifrado                : CCMP
* Modo de conexión       : Perfil
* Velocidad de recepción (Mbps)   : 585
* Velocidad de transmisión (Mbps) : 866.7
* Señal                           : 96%
* Rssi           : -36
* Perfil                 : INFINITUMA99C_5
* MSCS de QoS configurado: 0
* Asignación de QoS configurada: 0
* Asignación de QoS permitida por la directiva : 0  


** Notice that the current configuration indicates this:**

* SSID is INFINITUMA99C_5
* Band is 5 GHz
* Chanel is channel 64
* Receiving speed is 585 Mbps
* Sending speed is 866.7 Mbps
* Signal is at 96%

Now I'm connected to a network with a larger bandwidth (2,4 GHz to 5 GHz) which delivers less interference, lower latency and lower jitter and by consequence a better and faster internet connection. 
Also I'm on a different channel (5 to 64), channel 64 is on DFS (Dynamic Frequency Selection) range, this range is less used by neighbors, has lower interference, offer better stability and allow wider channel bandwidths (40 -80 Mhz).

My **Receiving** (144.4 Mbps to 585 Mbps) and ** Sending** (144.4 Mbps to 866.7 Mbps) speed is faster by far.


Don't know why I was using a 2,4 GHz all this time xD

Thanks for reading.
- Roberto Orozo












