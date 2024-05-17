function simulador_contagios()

    % Parámetros iniciales
    poblacion = 1000; % Población total
    infectados_iniciales = poblacion*0.1; % Número inicial de infectados
    recuperados_iniciales = 0; % Número inicial de recuperados
    susceptibles_iniciales = poblacion - infectados_iniciales - recuperados_iniciales; % Número inicial de susceptibles
    tasa_transmision = 0.1; % Tasa de transmisión (%)
    tasa_mortandad = 0.3; % Tasa de mortandad (%)
    efectividad_vacuna = 0.7; % Efectividad de la vacuna (%)
    tasa_vacunacion = 0.2; % Tasa de vacunación (%)
    tasa_distanciamiento = 0.5; % Tasa de respeto al distanciamiento (%)

    % Crear GUI
    format('longG')
    fig = uifigure('Name', 'Simulador de contagios', 'Position', [500, 500, 500, 500]);
    actualizar_button = uibutton(fig, 'push', 'Text', 'Actualizar resultados', ...
        'Position', [50, 460, 150, 22], 'ButtonPushedFcn', @(src,event) actualizar_resultados());
    poblacion_box = uieditfield(fig, 'numeric', 'Value', poblacion, 'Limits', [0, Inf], ...
        'Position', [230, 430, 260, 22]);
    poblacion_label = uilabel(fig, 'Text', 'Población:', 'Position', [50, 430, 180, 22]);

    mortandad_box = uieditfield(fig, 'numeric', 'Value', tasa_mortandad, 'Limits', [0, 1],'Position', [230, 400, 260, 22]);
    tasa_mortandad_label = uilabel(fig, 'Text', 'Tasa mortandad:', 'Position', [50, 400, 180, 22]);

    infectados_label = uilabel(fig, 'Text', 'numero de infectados:', 'Position', [50, 370, 150, 22]);
    infectados_box = uieditfield(fig, 'numeric', 'Value', infectados_iniciales, 'Limits', [0, Inf], ...
        'Position', [200, 370, 100, 22], 'Enable', 'off');

    muertos_label = uilabel(fig, 'Text', 'Número de muertos:', 'Position', [50, 350, 150, 22]);
    muertos_box = uieditfield(fig, 'numeric', 'Value', 0, 'Limits', [0, Inf], ...
        'Position', [200, 350, 100, 22], 'Enable', 'off');
    
    
    infectados_porcentaje_label = uilabel(fig, 'Text', 'numero de infectados porcentaje (%) :', 'Position', [50, 330, 200, 22]);
    infectados_porcentaje_box = uieditfield(fig, 'numeric', 'Value', infectados_iniciales, 'Limits', [0, Inf], ...
        'Position', [250, 330, 100, 22], 'Enable', 'off');

    muertos_porcentaje_label = uilabel(fig, 'Text', 'Número de muertos porcentaje (%):', 'Position', [50, 310, 200, 22]);
    muertos_porcentaje_box = uieditfield(fig, 'numeric', 'Value', 0, 'Limits', [0, Inf], ...
        'Position', [250, 310, 100, 22], 'Enable', 'off');
    
    % Sliders
    tasa_transmision_slider = uislider(fig, 'Value', tasa_transmision, 'Limits', [0, 1], ...
        'Position', [50, 260, 260, 3], 'MajorTicks', [0:0.1:1], 'MajorTickLabels', {'0%', '10%', '20%', '30%', '40%', '50%', '60%', '70%', '80%', '90%', '100%'});
    tasa_transmision_label = uilabel(fig, 'Text', 'Tasa de transmisión:', 'Position', [50, 280, 150, 22]);
     
 
    
    efectividad_vacuna_slider = uislider(fig, 'Value', efectividad_vacuna, 'Limits', [0, 1], ...
        'Position', [50, 180, 250, 3], 'MajorTicks', [0:0.1:1], 'MajorTickLabels', {'0%', '10%', '20%', '30%', '40%', '50%', '60%', '70%', '80%', '90%', '100%'});
    efectividad_vacuna_label = uilabel(fig, 'Text', 'Efectividad de la vacuna:', 'Position', [50, 200, 150, 22]);
    
    tasa_vacunacion_slider = uislider(fig, 'Value', tasa_vacunacion, 'Limits', [0, 1], ...
        'Position', [50, 100, 250, 3], 'MajorTicks', [0:0.1:1], 'MajorTickLabels', {'0%', '10%', '20%', '30%', '40%', '50%', '60%', '70%', '80%', '90%', '100%'});
    tasa_vacunacion_label = uilabel(fig, 'Text', 'Tasa de vacunación:', 'Position', [50, 120, 150, 22]);
    
    tasa_distanciamiento_slider = uislider(fig, 'Value', tasa_distanciamiento, 'Limits', [0, 1], ...
        'Position', [50, 20, 250, 3], 'MajorTicks', [0:0.1:1], 'MajorTickLabels', {'0%', '10%', '20%', '30%', '40%', '50%', '60%', '70%', '80%', '90%', '100%'});
    tasa_distanciamiento_label = uilabel(fig, 'Text', 'Tasa de distanciamiento:', 'Position', [50, 40, 150, 22]);
          % Botón para actualizar
    

    % Función para actualizar resultados
   function actualizar_resultados()
    % Obtener valores de los sliders
    tasa_transmision = tasa_transmision_slider.Value;
    efectividad_vacuna = efectividad_vacuna_slider.Value;
    tasa_vacunacion = tasa_vacunacion_slider.Value;
    tasa_distanciamiento = tasa_distanciamiento_slider.Value;
    tasa_mortalidad = mortandad_box.Value;
    poblacion = poblacion_box.Value;
    infectados_iniciales = poblacion*0.1; % Número inicial de infectados
    recuperados_iniciales = 0; % Número inicial de recuperados
    
    susceptibles_iniciales = poblacion - infectados_iniciales - recuperados_iniciales; 
    % Calcular nuevos infectados y muertos usando el modelo SIR
    [nuevos_infectados, nuevos_muertos] = modelo_SIR(poblacion, susceptibles_iniciales, infectados_iniciales, recuperados_iniciales, tasa_transmision, ...
        efectividad_vacuna, tasa_vacunacion, tasa_distanciamiento,tasa_mortalidad);

    

    % Actualizar los campos de texto con porcentajes
    infectados_box.Value = nuevos_infectados;
    muertos_box.Value = nuevos_muertos;
     nuevos_infectados_porcentaje = (nuevos_infectados / poblacion) * 100;
    nuevos_muertos_porcentaje = (nuevos_muertos / poblacion) * 100;
       infectados_porcentaje_box.Value = nuevos_infectados_porcentaje;
    muertos_porcentaje_box.Value = nuevos_muertos_porcentaje;
end


end
function [nuevos_infectados, nuevos_muertos] = modelo_SIR(poblacion, susceptibles, infectados, recuperados, tasa_transmision, ...
    efectividad_vacuna, tasa_vacunacion, tasa_distanciamiento, tasa_mortalidad)


    % Ajustar la tasa de transmisión con la tasa de distanciamiento social
    beta_ajustada = tasa_transmision * (1 - tasa_distanciamiento)
    
    % Calcular el número de vacunados
    vacunados = tasa_vacunacion * poblacion * efectividad_vacuna
    
    % Ajustar el número de susceptibles considerando la vacunación
    S_ajustados = susceptibles - vacunados
    
    % Asegurar que el número de susceptibles no sea negativo
    if S_ajustados < 0
        S_ajustados = 0
    end
    
    % Calcular los nuevos infectados
    nuevos_infectados = beta_ajustada * (S_ajustados * infectados) / poblacion
    
    % Asegurar que el número de nuevos infectados no exceda el número de susceptibles
    if nuevos_infectados > S_ajustados
        nuevos_infectados = S_ajustados
    end
    
    % Calcular los nuevos muertos
    nuevos_muertos = tasa_mortalidad * nuevos_infectados


end