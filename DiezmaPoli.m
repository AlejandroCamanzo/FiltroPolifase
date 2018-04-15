function [y] = DiezmaPoli(h,M, x)
%DiezmaPoli Un diezmador de estructura polifase
%   h: coeficientes del filtro antialiasing
%   M: factor de diezmado
%   x: señal a ser diezmada

y = zeros (length(x),1);
H = zeros(M,length(h)/M);
retX = x;

for i = 1:M   
    H(i,:) = h(i:M:end);                    % escogemos los coeffs del filtro
    xaux = x(1:M:end);                      % Diezmamos la señal 
    yaux = filter(H(i,:),1,xaux);           % filtramos
    
    % acumulamos el resultado final
    y = y + yaux;
    
    % retardamos la señal de entrada 1 muestra
    retX(2:end) = retX(1:(end-1));
    retX(1) = x(i);
end

