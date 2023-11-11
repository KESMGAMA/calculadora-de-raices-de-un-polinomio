%-------1. INDICAR EL GRADO DE LA ECUACIÓN-------%
%================================================%



grado = input('Ingrese el grado de su ecuación: ');
grado_nuevo = grado;

a = zeros(1,grado + 1); %espacio donde se guarda los valores de los coeficientes y el término independiente
raices = []; %espacio donde se almacenan las raíces
raices_imaginarias = [];
raices_encontradas = 0; %se define un conteo de raices encontradas
raices_imaginarias_encontradas = 0;
exacto = false;



%-------2. DEFINIR LOS VALORES DE LOS COEFICIENTES Y DEL TÉRMINO INDEPENDIENTE-------%
%====================================================================================%



for i = 1:grado
    grado_de_x = num2str(grado +1 - i);
    nuevo_valor = input(['Ingrese el valor del coeficiente de x^' grado_de_x ': ']);
    a(i) = nuevo_valor;
end

termino_independiente = input('Ingrese el valor del término independiente: ');
a(grado+1) = termino_independiente;

ecuacion_original = a;

a = a / a(1); %simplifica la ecuación para que el coeficiente de x ^ n sea 1

a_permanente = a;



%--------3. DEFINIR VALORES NECESARIOS PARA EL MÉTODO DE BAIRSTOW (si es que es una ecuación de grado 3 o mayor)--------%
%=======================================================================================================================%



if(grado >= 3)
    r = input('Defina un valor inicial para r: ');
    s = input('Defina un valor inicial para s: ');
    iteraciones = input('Indique el número de iteraciones que desea: ');

    sin_dos(grado,raices,raices_encontradas,raices_imaginarias,raices_imaginarias_encontradas,grado_nuevo,a,r,s,iteraciones,exacto,termino_independiente,ecuacion_original); %parte del código que utiliza el método de Bairstow
else
    if(grado == 2)
        discriminante = sqrt((a(2) ^ 2) - (4 * a(3)));

        %forma x1 = (-b + discriminante) / 2a
        raiz_obtenida = (- a(2) + discriminante) / 2; 
        if(isreal(raiz_obtenida))
            raices(raices_encontradas + 1) = raiz_obtenida;
            raices_encontradas = raices_encontradas + 1; %se marca una raíz encontrada
        else
            raices_imaginarias(raices_imaginarias_encontradas + 1) = raiz_obtenida;
            raices_imaginarias_encontradas = raices_imaginarias_encontradas + 1; %se marca una raíz encontrada
        end
        
        %forma x1 = (-b - discriminante) / 2a
        raiz_obtenida = (- a(2) - discriminante) / 2; 
        if(isreal(raiz_obtenida))
            raices(raices_encontradas + 1) = raiz_obtenida;
            raices_encontradas = raices_encontradas + 1; %se marca una raíz encontrada
        else
            raices_imaginarias(raices_imaginarias_encontradas + 1) = raiz_obtenida;
            raices_imaginarias_encontradas = raices_imaginarias_encontradas + 1; %se marca una raíz encontrada
        end

        disp('//////////////////////////////');
        if(raices_encontradas ~= 0)
            disp('Las raíces reales de su ecuación son: ');
            disp(raices);
        end
        if(raices_imaginarias_encontradas ~= 0)
            disp('Las raíces imaginarias de su ecuación son: ');
            disp(raices_imaginarias);
        end

        %para marcarlo en una gráfica:
        if(raices_encontradas ~= 0)
            for iguales = 1:length(raices) - 1
                if(raices(iguales) == raices(iguales + 1))
                    exacto = true;
                end
            end
            if(exacto && raices(1) ~= 0)
                x = linspace(raices(1) - abs(raices(1)),raices(1) + abs(raices(1)));
            else
                x = linspace(min(raices) - 0.01,max(raices) + 0.01);
            end
        else
            x = linspace((- ecuacion_original(2) / (2 * ecuacion_original(1))) - 0.25,(- ecuacion_original(2) / (2 * ecuacion_original(1))) + 0.25);
        end
        y = (ecuacion_original(1) .* (x .^ 2)) + (ecuacion_original(2) .* x) + ecuacion_original(3);
        plot(x,y,'b')
        hold on
        y2 = 0 .* x;
        ln = plot(x,y2);
        ln.Color = [0,0,0]; 
        x2 = raices;
        y3 = zeros(length(x2));
        legend("ecuación");
        plot(x2,y3,'go','MarkerSize',10)
        hold off
    else
        sin_dos(grado,raices,raices_encontradas,raices_imaginarias,raices_imaginarias_encontradas,grado_nuevo,a,r,s,iteraciones,exacto,termino_independiente,ecuacion_original); %parte del código que utiliza el método de Bairstow
    end
end



%--------SIN_DOS()--------%
%=========================%



function sin_dos(grado,raices,raices_encontradas,raices_imaginarias,raices_imaginarias_encontradas,grado_nuevo,a,r,s,iteraciones,exacto,termino_independiente,ecuacion_original)
    b = [];
    c = [];
    if(grado == 0)
        disp('////////////////////////////');
        disp('Su ecuación no tiene raíces.'); %indica la ausencia de raíces desde un inicio si es de grado 0

        %para marcarlo en una gráfica:
        x = linspace(-10,10);
        disp(termino_independiente);
        y = termino_independiente + (0 .* x);
        plot(x,y,'b')
    else
        while(raices_encontradas + raices_imaginarias_encontradas ~= grado) %método de Bairstow
            if(grado_nuevo <= 2)
                if(grado_nuevo == 2) %en caso de que sea una ecuación de grado par
                    discriminante = sqrt((a(2) ^ 2) - (4 * a(3)));

                    %forma x1 = (-b + discriminante) / 2a
                    raiz_obtenida = (- a(2) + discriminante) / 2; 
                    if(isreal(raiz_obtenida))
                        raices(raices_encontradas + 1) = raiz_obtenida;
                        raices_encontradas = raices_encontradas + 1; %se marca una raíz encontrada
                    else
                        raices_imaginarias(raices_imaginarias_encontradas + 1) = raiz_obtenida;
                        raices_imaginarias_encontradas = raices_imaginarias_encontradas + 1; %se marca una raíz encontrada
                    end
        
                    %forma x1 = (-b - discriminante) / 2a
                    raiz_obtenida = (- a(2) - discriminante) / 2; 
                    if(isreal(raiz_obtenida))
                        raices(raices_encontradas + 1) = raiz_obtenida;
                        raices_encontradas = raices_encontradas + 1; %se marca una raíz encontrada
                    else
                        raices_imaginarias(raices_imaginarias_encontradas + 1) = raiz_obtenida;
                        raices_imaginarias_encontradas = raices_imaginarias_encontradas + 1; %se marca una raíz encontrada
                    end

                    disp('//////////////////////////////');
                    if(raices_encontradas ~= 0)
                        disp('Las raíces reales de su ecuación son: ');
                        disp(raices);
                    end
                    if(raices_imaginarias_encontradas ~= 0)
                        disp('Las raíces imaginarias de su ecuación son: ');
                        disp(raices_imaginarias);
                    end
        
                    %para marcarlo en una gráfica:
                    if(raices_encontradas ~= 0)
                        for iguales = 1:length(raices) - 1
                            if(raices(iguales) == raices(iguales + 1))
                                exacto = true;
                            end
                        end
                        if(exacto && raices(1) ~= 0)
                            x = linspace(raices(1) - abs(raices(1)),raices(1) + abs(raices(1)));
                        else
                            x = linspace(min(raices) - 0.01,max(raices) + 0.01);
                        end
                    else
                        x = linspace(-100,100);
                    end
                    y = 0;
                    for graf = 1:length(ecuacion_original)
                        y = y + (ecuacion_original(graf) .* (x .^ (length(ecuacion_original)-graf)));
                    end
                    plot(x,y,'b')
                    hold on
                    y2 = 0 .* x;
                    ln = plot(x,y2);
                    ln.Color = [0,0,0];
                    x2 = raices;
                    y3 = zeros(length(x2));
                    legend("ecuación");
                    plot(x2,y3,'go','MarkerSize',10)
                    hold off

                else %en caso de que sea una ecuación de grado impar, o de grado 1 desde el comienzo
                    raices(raices_encontradas + 1) = - a(2); %como el coeficiente de x es 1; solo se necesita retirar el término independiente
                    raices_encontradas = raices_encontradas + 1;

                    disp('//////////////////////////////');
                    if(raices_encontradas ~= 0)
                        disp('Las raíces reales de su ecuación son: ');
                        disp(raices);
                    end
                    if(raices_imaginarias_encontradas ~= 0)
                        disp('Las raíces imaginarias de su ecuación son: ');
                        disp(raices_imaginarias);
                    end

                    %para marcarlo en una gráfica:
                    if(grado == 1)
                        x = linspace(raices - abs(raices),raices + abs(raices));
                        y = (ecuacion_original(1) .* x) + termino_independiente;
                        plot(x,y,'b')
                        hold on
                        y2 = 0 .* x;
                        ln = plot(x,y2);
                        ln.Color = [0,0,0];
                        x2 = raices;
                        y3 = 0;
                        legend("ecuación");
                        plot(x2,y3,'go','MarkerSize',10)
                        hold off
                    else
                        if(raices_encontradas ~= 0)
                            for iguales = 1:length(raices) - 1
                                if(raices(iguales) == raices(iguales + 1))
                                    exacto = true;
                                end
                            end
                            if(exacto && raices(1) ~= 0)
                                x = linspace(raices(1) - abs(raices(1)),raices(1) + abs(raices(1)));
                            else
                                x = linspace(min(raices) - 0.01,max(raices) + 0.01);
                            end
                        else
                            x = linspace(-100,100);
                        end
                        y = 0;
                        for graf = 1:length(ecuacion_original)
                            y = y + (ecuacion_original(graf) .* (x .^ (length(ecuacion_original)-graf)));
                        end
                        plot(x,y,'b')
                        hold on
                        y2 = 0 .* x;
                        ln = plot(x,y2);
                        ln.Color = [0,0,0];
                        reales = find(imag(raices) == 0);
                        raices_reales = raices(reales);
                        x2 = raices_reales;
                        y3 = zeros(length(x2));
                        legend("ecuación");
                        plot(x2,y3,'go','MarkerSize',10)
                        hold off
                    end
                end
            else
                for iter = 1:iteraciones
                    b = zeros(1,grado_nuevo + 1);
                    b(1) = a(1);
                    b(2) = (r * b(1)) + a(2);
                    for i = 3:(grado_nuevo + 1)
                        b(i) = (r * b(i - 1)) + (s * b(i - 2)) + a(i);
                    end

                    c = zeros(1,grado_nuevo);
                    c(1) = a(1);
                    c(2) = (r * c(1)) + b(2);
                    for i = 3:grado_nuevo
                        c(i) = (r * c(i - 1)) + (s * c(i - 2)) + b(i);
                    end

                    b_cero = b(length(b));
                    b_uno = b(length(b) - 1);
                    c_uno = c(length(c));
                    c_dos = c(length(c) - 1);
                    c_tres = c(length(c) - 2);

                    determinante_sistema = (c_dos ^ 2) - (c_uno * c_tres);
                    determinante_delta_r = (b_cero * c_tres) - (b_uno * c_dos);
                    determinante_delta_s = (b_uno * c_uno) - (c_dos * b_cero);

                    delta_r = determinante_delta_r / determinante_sistema;
                    delta_s = determinante_delta_s / determinante_sistema;

                    r = delta_r + r;
                    s = delta_s + s;
                end

                division_sintetica = a; %se utiliza para poder realizar la división de polinomios
                cociente = []; %el polinomio formado después de dividir el polinomio original entre el factor cuadrático
                cociente(1) = 1;
                for m = 1:(length(a) - 3)
                    division_sintetica(m + 1) = division_sintetica(m + 1) - (division_sintetica(m) * (- r));
                    division_sintetica(m + 2) = a(m + 2) - (division_sintetica(m) * (- s));
                    division_sintetica(m) = 0;
                    cociente(m + 1) = division_sintetica(m + 1);
                end

                a = [];
                a = cociente; %se borran los antiguos coeficientes y se marcan los obtenidos después de la división
                grado_nuevo = grado_nuevo - 2; %establece el grado de la nueva ecuación

                discriminante = sqrt((r ^ 2) + (4 * s));

                %forma x1 = (r + discriminante) / 2
                raiz_obtenida = (r + discriminante) / 2; %forma x1 = (-b + discriminante) / 2a
                if(isreal(raiz_obtenida))
                    raices(raices_encontradas + 1) = raiz_obtenida;
                    raices_encontradas = raices_encontradas + 1; %se marca una raíz encontrada
                else
                    raices_imaginarias(raices_imaginarias_encontradas + 1) = raiz_obtenida;
                    raices_imaginarias_encontradas = raices_imaginarias_encontradas + 1; %se marca una raíz encontrada
                end

                %forma x1 = (r - discriminante) / 2
                raiz_obtenida = (r - discriminante) / 2; %forma x1 = (-b + discriminante) / 2a
                if(isreal(raiz_obtenida))
                    raices(raices_encontradas + 1) = raiz_obtenida;
                    raices_encontradas = raices_encontradas + 1; %se marca una raíz encontrada
                else
                    raices_imaginarias(raices_imaginarias_encontradas + 1) = raiz_obtenida;
                    raices_imaginarias_encontradas = raices_imaginarias_encontradas + 1; %se marca una raíz encontrada
                end
            end
        end
    end
end