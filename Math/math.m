classdef math
    % A function library providing the most used fitting functions.
    % List of functions:
    % math.gaussian
    % math.lorentz
    % math.psvoigt
    % math.multigaussian
    % math.constant
    % math.linear
    % math.quadratic
    % math.polynomial

    methods(Static)

        function y = gaussian(p, x)
            % Gaussian function: Y = math.gaussian(parameters, X)
            %
            % parameters = [ Amplitude
            %                Center
            %                FWHM
            %                Background
            %                Linear Slope *
            %                Amp/Area * ]
            %
            % Parameters with * are optional, which can be left blank.
            %
            % If Area/Amp = 0 or left blank, the 1st parameter gives the amplitude;
            % If Area/Amp = 1, the amplitude is converted to the integrated area.
            %
            % To convert from FWHM to gaussian width sigma, exp(-x^2/s^2)
            % divide FWHM/sqrt(log(256)) = 0.42466

            if (length(p) < 5)
                p(5)=0; % set default value of slope to zero
                p(6)=0; % default fit amplitude
            elseif(length(p) < 6)
                p(6)=0;
            end

            if p(6)==1
                fact=2/p(3)*sqrt(log(2)/pi);
            else
                fact=1;
            end

            y=p(1)*fact*exp(-4*log(2)*(x-p(2)).^2/p(3)^2)+p(4)+p(5)*(x-p(2));
        end


        function y = lorentz(p, x)
            % Lorentzian function: Y = math.lorentz(parameters, X)
            %
            % parameters = [ Amplitude
            %                Center
            %                FWHM
            %                Background
            %                Linear Slope *
            %                Area/Amp * ]
            %
            % Parameters with * are optional, which can be left blank.
            %
            % If Area/Amp = 0 or left blank, the 1st parameter gives the amplitude;
            % If Area/Amp = 1, the amplitude is converted to the integrated area.

            if (length(p) < 5)
                p(5)=0; % set default value of slope to zero
                p(6)=0; % default fit amplitude
            elseif(length(p) < 6)
                p(6)=0;
            end

            if p(6)==0
                fact=1;
            else
                fact=2/pi/p(3);
            end

            y=p(1)*fact*(p(3)/2)^2./((x-p(2)).^2+(p(3)/2)^2)+p(4)+p(5)*(x-p(2));
        end


        function y = psvoigt(p, x)
            % Pseudo-Voigt function: Y = math.psvoigt(parameters, X)
            %
            % parameters = [ Amplitude
            %                Center
            %                FWHM
            %                Lorentzian Fraction
            %                Background
            %                Linear Slope * ]
            %
            % Parameters with * are optional, which can be left blank.

            pgaussian=[p(1) p(2) p(3) 0 0 0];
            plorentz=[p(1) p(2) p(3) 0 0 0];

            if (length(p) < 6)
                p(6)=0; % set default value of slope to zero
            end
            
            y=abs(1-p(4))*math.gaussian(pgaussian, x) + abs(p(4))*math.lorentz(plorentz, x)+p(5)+p(6)*(x-p(2));
        end

        
        function y = multigaussian(p, x)
            % Multiple Gaussians: Y = math.multigaussian(parameters, X)
            %
            % parameters = [ Amplitude (peak 1)
            %                Center (peak 1)
            %                FWHM (peak 1)
            %                Amplitude (peak 2)
            %                Center (peak 2)
            %                FWHM (peak 2)
            %                ...
            %                Background
            %                Linear Slope *
            %                Amp/Area * ]
            %
            % The number of gaussian peaks is determined by the length of
            % the parameters.
            %
            % The 3*N-2, 3*N-1, 3*N parameters are the Amplitude, Center
            % and FWHM of the N-th gaussian.
            %
            % The last 3 parameters are the overall background, linear
            % slope, and the control whether the amplitude parameters are
            % converted to the integrated area.
            %
            % Parameters with * are optional, which can be left blank.
            %
            % If Area/Amp = 0 or left blank, the 1st parameter gives the amplitude;
            % If Area/Amp = 1, the amplitude is converted to the integrated area.

            m=length(p);
            n=ceil(m/3)-1; % number of peaks
            if m<3*n+2
                p(3*n+2)=0; % set default value of slope to zero
                p(3*n+3)=0; % default fit to amplitude
            elseif m<3*n+3
                p(3*n+3)=0;
            end
            
            m=length(p);
            y=0;
            for ii=1:n
                b=[p(3*ii-2) p(3*ii-1) p(3*ii) 0 0 p(m)];
                y=y+math.gaussian(b, x);
            end
            y=y+p(m-2)+p(m-1)*x;
        end


        function y = multilorentz(p, x)
            % Multiple Lorentzs: Y = math.multilorentz(parameters, X)
            %
            % parameters = [ Amplitude (peak 1)
            %                Center (peak 1)
            %                FWHM (peak 1)
            %                Amplitude (peak 2)
            %                Center (peak 2)
            %                FWHM (peak 2)
            %                ...
            %                Background
            %                Linear Slope *
            %                Amp/Area * ]
            %
            % The number of lorentz peaks is determined by the length of
            % the parameters.
            %
            % The 3*N-2, 3*N-1, 3*N parameters are the Amplitude, Center
            % and FWHM of the N-th lorentz.
            %
            % The last 3 parameters are the overall background, linear
            % slope, and the control whether the amplitude parameters are
            % converted to the integrated area.
            %
            % Parameters with * are optional, which can be left blank.
            %
            % If Area/Amp = 0 or left blank, the 1st parameter gives the amplitude;
            % If Area/Amp = 1, the amplitude is converted to the integrated area.

            m=length(p);
            n=ceil(m/3)-1; % number of peaks
            if m<3*n+2
                p(3*n+2)=0; % set default value of slope to zero
                p(3*n+3)=0; % default fit to amplitude
            elseif m<3*n+3
                p(3*n+3)=0;
            end
            
            m=length(p);
            y=0;
            for ii=1:n
                b=[p(3*ii-2) p(3*ii-1) p(3*ii) 0 0 p(m)];
                y=y+math.lorentz(b, x);
            end
            y=y+p(m-2)+p(m-1)*x;
        end


        function y = constant(p, x)
            % Constant function: Y = math.constant(parameter, X)
            %
            % parameter = Constant

            y=ones(size(x))*p;
        end


        function y = linear(p, x)
            % Linear function:  y = math.linear(parameters, x)
            %
            % parameters = [ Slope
            %                Intercept ]

            y=p(1)*x+p(2);
        end


        function y = quadratic(p, x)
            % Quadratic function:  Y = math.quadratic(parameters, X)
            %
            % Y = P(1)*X^2 + P(2)*X + P(3)
            %
            % parameters = [ P(1)
            %                P(2)
            %                P(3) ]

            y=p(1)*x.^2+p(2)*x+p(3);
        end


        function y = polynomial(p, x)
            % Polynomial function: Y = math.polynomial(parameters, X)
            %
            % Y = P(1)*X^(n-1) + P(2)*X^(n-2) + ... + P(n-1)*X + P(n)
            %
            % The order of the polynomial is determined by the length of
            % the parameters.
            %
            % parameters = [ P(1)
            %                P(2)
            %                ...
            %                P(n) ]

            n=length(p);
            y=p(n)*ones(size(x));
            yn=1;
            for ii=n-1:-1:1
                yn=yn.*x;
                y=y+p(ii)*yn;
            end
        end

    end % end methods
    
end