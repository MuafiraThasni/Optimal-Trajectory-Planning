function x0 = ddmrcgltrial_initial(p)   
	

	    Xguess = [6]; % x initial guess
        Yguess = [4.7]; % y initial guess
	    thetaguess =[3.6]; % v initial guess
	    U1guess = [0]; % u initial guess
        U2guess = [0];
        Vguess = [3.69];
        Wguess = [3.62];
        

    % final time guess
    tguess = p.t{end}(end);
	% combine to column vector
	x0 = [6 4.7 3.6 0 0 3.69 3.62];
    
end