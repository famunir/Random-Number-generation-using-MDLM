%%%% The following MATLAB code generates five Chaotic Maps and each one of
%%%% them is dependent on the other i.e. the previous state of one map
%%%% helps in the generation of net state of the other map and vice versa.
%%%% The calculations are being performed in fixed-point format Q m.n
%%%% where, m = number of bits reserved to represent integer value and
%%%% n = number of bits reserved to represent fractional value.

% Based on publication: Designing multi-dimensional logistic map with 
% fixed-point finite precision. Nonlinear Dynamics, Springer.

clear all
close all
clc

% Total number of samples in chaotic map
N = 1000000;

% Defining word length and fraction length
% word length (w) = intger bits (m) + fraction bits (n)
w = 16
n = 8

% Initialization of control parameters in Q w-n.n format.
r_one = ufi(4,w,n);
% r_bin = bin(r_one);

r_two = ufi(4,w,n);

r_three = ufi(4,w,n);

r_four = ufi(4,w,n);

r_five = ufi(4,w,n);

% Initialization of '1' in Q w-n.n format.
constant = ufi(1,w,n);

% Intialization of Logistic map variables using Q w-w.w format.
logistic_map_one = ufi(zeros(1,N),w,w);
logistic_map_two = ufi(zeros(1,N),w,w);
logistic_map_three = ufi(zeros(1,N),w,w);
logistic_map_four = ufi(zeros(1,N),w,w);
logistic_map_five = ufi(zeros(1,N),w,w);

% For these values the word length and fractional length is doubled for experimental
% puposes. You can revert these values back to 'w' and 'n', if required.
temp_map_value = ufi(0,2 * w,2 * n);
temp_map_value1 = ufi(0,2 * w,2 * n);
temp_map_value2 = ufi(0,2 * w,2 * n);
temp_map_value3 = ufi(0,2 * w,2 * n);
temp_map_value4 = ufi(0,2 * w,2 * n);

% Initializing the seeds
logistic_map_one(1) = 0.3245;
logistic_map_two(1) = 0.1298;
logistic_map_three(1) = 0.3289;
logistic_map_four(1) = 0.4231;
logistic_map_five(1) = 0.1188;

tic;

% Generation of 5 Logistic maps which are dependent upon each other.
for i = 2 : N
    
    temp_map_value = r_one * logistic_map_one(i - 1) * (constant - ...
        logistic_map_one(i - 1)) + (logistic_map_five(i - 1) *...
        logistic_map_five(i - 1));
    temp = double(temp_map_value);
    temp_map = mod(temp,1);
    logistic_map_one(i) = temp_map;
    
    temp_map_value1 = r_two * logistic_map_two(i - 1) * (constant - ...
        logistic_map_two(i - 1)) + (logistic_map_one(i - 1) *...
        logistic_map_one(i - 1));
    tempp = double(temp_map_value1);
    temp_map1 = mod(tempp,1);
    logistic_map_two(i) = temp_map1;
    
    temp_map_value2 = r_three * logistic_map_three(i - 1) * (constant - ...
        logistic_map_three(i - 1)) + (logistic_map_two(i - 1) *...
        logistic_map_two(i - 1));
    temppp = double(temp_map_value2);
    temp_map2 = mod(temppp,1);
    logistic_map_three(i) = temp_map2;
    
    temp_map_value3 = r_four * logistic_map_four(i - 1) * (constant - ...
        logistic_map_four(i - 1)) + (logistic_map_three(i - 1) *...
        logistic_map_three(i - 1));
    tempppp = double(temp_map_value3);
    temp_map3 = mod(tempppp,1);
    logistic_map_four(i) = temp_map3;
    
    temp_map_value4 = r_five * logistic_map_five(i - 1) * (constant - ...
        logistic_map_five(i - 1)) + (logistic_map_four(i - 1) *...
        logistic_map_four(i - 1));
    temppppp = double(temp_map_value4);
    temp_map4 = mod(temppppp,1);
    logistic_map_five(i) = temp_map4;
    
end

toc;

% changing the data type of generated map for further analysis.
% Many other MATLAB methods cannot be applied to 'ufi' data type.
% Change type of other vectors as per requirement.
temp1 = double(logistic_map_one);

%=================================================================%
% Periodicity calculation for the generated map

%check = 0;
%for jj = N : -1 : 7
%    jj
%    for kk= jj - 1: -1 :7
%        
%        Mat = temp1(jj) - temp1(kk);
%        mat1 = temp1(jj - 1) - temp1(kk - 1);
%        mat2 = temp1(jj - 2) - temp1(kk - 2);
%        mat3 = temp1(jj - 3) - temp1(kk - 3);
%        mat4 = temp1(jj - 4) - temp1(kk - 4);
%        mat5 = temp1(jj - 5) - temp1(kk - 5);
%        mat6 = temp1(jj - 6) - temp1(kk - 6);
%        if norm(Mat) == 0
%            if norm (mat1) == 0
%                if norm (mat2) == 0
%                    if norm (mat3) == 0
%                        if norm (mat4) == 0
%                            if norm (mat5) == 0
%                                if norm(mat6) == 0
%                                    Mat
%                                    mat1
%                                    mat2
%                                    mat3
%                                    mat4
%                                    mat5
%                                    mat6
%                                    check = 1;
%                                    break;
%                                end
%                            end
%                        end
%                    end
%                end
%            end
%        end
%    end
%    if(check == 1)
%        break;
%    end
%end

%=====================================================================%

