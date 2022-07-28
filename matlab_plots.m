% plot winter data from data_readings.txt

% This script changes all interpreters from tex to latex. 
list_factory = fieldnames(get(groot,'factory'));
index_interpreter = find(contains(list_factory,'Interpreter'));
for i = 1:length(index_interpreter)
    default_name = strrep(list_factory{index_interpreter(i)},'factory','default');
    set(groot, default_name,'latex');
end

clear; clc;

DATA = readtable("data_readings.txt", "VariableNamingRule", "preserve");
DATA = DATA(1:end, :);

dataora = datetime(DATA.Var1, DATA.Var2, DATA.Var3, DATA.Var4, DATA.Var5, DATA.Var6);

% raw data
%humidty = DATA.Var7/100;
%temperature = DATA.Var8/100;
%pressure = DATA.Var9/1000;
%battery = DATA.Var10;

% smooth data
humidty = smoothdata(DATA.Var7/100);
temperature = smoothdata(DATA.Var8/100);
pressure = smoothdata(DATA.Var9/1000);
battery = DATA.Var10;

f = figure(Visible="on");

% humidity [%]
subplot(2, 2, 1);
plot(dataora, humidty, 'LineWidth',1.5, 'Color', 'red');
title('\textbf{Humidity [$\%$]}');
axis('padded')
grid("on")
set(gca,'FontSize', 12)

% temperature [°C]
subplot(2, 2, 2);
plot(dataora, temperature, 'LineWidth',1.5, 'Color', 'green');
title('\textbf{Temperature [$^{\circ}$C]}');
grid("on")
set(gca,'FontSize', 12)

% pressure [mBar]
subplot(2, 2, 3);
plot(dataora, pressure, 'LineWidth',1.5, 'Color', 'blue');
title('\textbf{Pressure [mBar]}');
grid("on")
set(gca,'FontSize', 12)

% battery [%]
subplot(2, 2, 4);
plot(dataora, battery, 'LineWidth',1.5, 'Color', 'magenta');
title('\textbf{Battery [$\%$]}');
grid("on")
set(gca,'FontSize', 12)

sgtitle('\textbf{GAPS Module Monitor}');
set(gca,'FontSize', 12)

f.Position = [0 0 1920  1080];
exportgraphics(gcf,'winter_plot.pdf','ContentType','vector');
