C0 = 11600; % A constant
Ac = 1; % Cathode area
I = 60e-3; % Current in A

% Work functions 
Ew_tungsten = 4.5; % Work function of tungsten in eV
Ew_thoriated = 2.6; % Work function of thoriated-tungsten in eV
Ew_oxide = 3.5; % Work function of oxide-coated cathode in eV

% Calculate temperatures
T_tungsten = -11600 * Ew_tungsten / log(I / (C0 * Ac));
T_thoriated = -11600 * Ew_thoriated / log(I / (C0 * Ac));
T_oxide = -11600 * Ew_oxide / log(I / (C0 * Ac));

disp(['Temperature of tungsten cathode: ', num2str(T_tungsten), ' K']);
disp(['Temperature of thoriated-tungsten cathode: ', num2str(T_thoriated), ' K']);
disp(['Temperature of oxide-coated cathode: ', num2str(T_oxide), ' K']);