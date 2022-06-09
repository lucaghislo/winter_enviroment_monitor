% plot winter data from data_readings.txt

clear; clc;

DATA = readtable("data_readings.txt", "VariableNamingRule", "preserve");

dataora = datetime(DATA.Var1, DATA.Var2, DATA.Var3, DATA.Var4, DATA.Var4, DATA.Var5, DATA.Var6);

humidty = smoothdata(DATA.Var7/100);
temperature = smoothdata(DATA.Var8/100);
pressure = smoothdata(DATA.Var9/1000);
battery = smoothdata(DATA.Var10);

f = figure(Visible="on");

% humidity [%]
subplot(2, 2, 1);
plot(dataora, humidty, 'LineWidth',1.5, 'Color', 'red');
title('Humidity [%]');

% temperature [°C]
subplot(2, 2, 2);
plot(dataora, temperature, 'LineWidth',1.5, 'Color', 'green');
title('Temperature [°C]');

% pressure [mBar]
subplot(2, 2, 3);
plot(dataora, pressure, 'LineWidth',1.5, 'Color', 'blue');
title('Pressure [mBar]');

% battery [%]
subplot(2, 2, 4);
plot(dataora, battery, 'LineWidth',1.5, 'Color', 'magenta');
title('Battery [%]');

sgtitle('Winter Enviroment Monitor');
