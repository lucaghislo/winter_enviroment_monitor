% plot winter data from data_readings.txt

clear; clc;

DATA = readtable("data_readings.txt", "VariableNamingRule","preserve");

dataora = datetime(DATA.Var1, DATA.Var2, DATA.Var3, DATA.Var4, DATA.Var4, DATA.Var5, DATA.Var6)

humidty = DATA.Var7/100;
temperature = DATA.Var8/100;
pressure = DATA.Var9/1000;
battery = DATA.Var10;

f = figure(Visible="on")

hold on

% humidity [%]
subplot(2, 2, 1)
plot(dataora, humidty)
title('Humidity [%]')

% temperature [°C]
subplot(2, 2, 2)
plot(dataora, temperature)
title('Temperature [°C]')

% pressure [mBar]
subplot(2, 2, 3)
plot(dataora, pressure)
title('Pressure [mBar]')

% battery [%]
subplot(2, 2, 4)
plot(dataora, battery)
title('Battery [%]')

hold off
