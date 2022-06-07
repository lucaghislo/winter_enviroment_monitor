import asyncio
from bleak import BleakClient

address = "CE:69:45:B5:8A:46" # change to winter_24 MAC
HUMIDITY_SERVICE_UUID = "00002a6f-0000-1000-8000-00805f9b34fb"

async def main(address):
    async with BleakClient(address) as client:
        humidity_value = await client.read_gatt_char(HUMIDITY_SERVICE_UUID)
        #print("Model Number: {0}".format("".join(map(chr, humidity_value))))
        print(humidity_value)

asyncio.run(main(address))