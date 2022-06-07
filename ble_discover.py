import asyncio
import time
import datetime
from bleak import BleakClient

address = "CE:69:45:B5:8A:46" # change to winter_24 MAC
HUMIDITY_SERVICE_UUID = "00002a6f-0000-1000-8000-00805f9b34fb"
TEMPERATURE_SERVICE_UUID = "00002a6e-0000-1000-8000-00805f9b34fb"
PRESSURE_SERVICE_UUID = "00002a6d-0000-1000-8000-00805f9b34fb"
BATTERY_SERVICE_UUID = "00002a19-0000-1000-8000-00805f9b34fb"

async def main(address):
    while(True):
        try:
            async with BleakClient(address) as client:
                humidity_value = await client.read_gatt_char(HUMIDITY_SERVICE_UUID)
                temperature_value = await client.read_gatt_char(TEMPERATURE_SERVICE_UUID)
                pressure_value = await client.read_gatt_char(PRESSURE_SERVICE_UUID)
                battery_value = await client.read_gatt_char(BATTERY_SERVICE_UUID)

                now = datetime.datetime.now()

                humidity_int = int.from_bytes(humidity_value, byteorder='big', signed=False)
                temperature_int = int.from_bytes(temperature_value, byteorder='big', signed=False)
                pressure_int = int.from_bytes(pressure_value, byteorder='big', signed=False)
                battery_int = int.from_bytes(battery_value, byteorder='big', signed=False)

                f = open("humidity_readings.txt", "a")

                print(now)
                print("   humidity: " + str(humidity_int/100) + " %")
                print("temperature: " + str(temperature_int/100) + " °C")
                print("   pressure: " + str(pressure_int/1000) + " mBar")

                if(battery_int == 102):
                    print("    battery: cable\n")
                else:
                    print("    battery: " + str(battery_int) + " %\n")

                f.write(str(now.year) + "\t" + str(now.month) + "\t" + str(now.day) + "\t" + str(now.hour) + "\t" + str(now.minute) + "\t" + str(now.second) + "\t" + str(humidity_int) + "\t" + str(temperature_int) + "\t" + str(pressure_int) + "\t" + str(battery_int) + "\n")

                f.close()
                
        except:
            print("winter_GAPS not available")

asyncio.run(main(address))
