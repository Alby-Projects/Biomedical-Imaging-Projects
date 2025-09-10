T = 1000:2000; % Temperature range in Kelvin

C0 = 11600;
Ac = 0.01;
Ew = 4.5;

I_tungsten = C0 * Ac * T.^2 .* exp(-11600 * Ew ./ T);

Ew_oxide = 3.5; % Work function of the oxide emitter in eV
I_oxide = C0 * Ac * T.^2 .* exp(-11600 * Ew_oxide ./ T);

figure;
plot(T, I_tungsten, T, I_oxide);

xlabel('Temperature (K)');
ylabel('Beam Current (A)');
title('Beam Current of Tungsten and Oxide-Coated Emitter as a Function of Temperature');
legend('Tungsten Cathode', 'Oxide-Coated Emitter');