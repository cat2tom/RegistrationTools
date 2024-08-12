function numstring = numbername(number,digits)

if number == 0 
    numdigits = 1;
else
numdigits = ceil(log10(number+1));
end

numzeros = digits - numdigits;

numstring = '';
for n = 1:numzeros
    numstring = [numstring '0'];
end

numstring  = [numstring num2str(number)];
