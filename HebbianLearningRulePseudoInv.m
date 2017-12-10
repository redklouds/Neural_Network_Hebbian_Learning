%%%%%%%%%%%%%%%%%%%%% Hebbian learning rule %%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Danny Ly
% Program Description: This program was built to demonstrate the Hebbian
% Artificual Learning Rule, in this program we want to know given the
% Hebbian learning how many prototype images can the weight matrix really
% hold? and what are the performance matrix as we add more images to
% recognize in the Nueral network.
% Methodology for testing: in this program we test by simply present the
% trained network with noisey data, noisey such that for each digit we
% introduce, we will randomly populate a random permutated index to change
% in the original data vector, the pixels to change will be 2, 4, and 6
% respectivly, after changing these pixels we will present the noisey data
% to the network and see how many times out of 10 was it correctly
% reconstructed as the original prototype input vector.
% USING PSEUDOINVERSE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global weights_pseudoInv;
%problem EX7.11
main();



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -Function: trainNetwork
% -Description: Given P, a matrix with each row vector being a prototype
% vector, train the neural network, when we mean train we are setting the
% weights to remember images or input prototype vectors
% -Methdologies: This training involves using the Hebbian learning rule,
% which states that Weight = T * transpose(P), where T = P
% -Postcondition: None, the weight matrix will be updated.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function results = trainNetworkPesuInv(P)
    %where P is also a column vector matrix
    global weights_pseudoInv;
    %where the pseudo inverse says that, W = T * P(+)
    %where P(+) = inv(transpose(P) * P)
    T = P;
    P_plus = inv(transpose(P) * P) * transpose(P);
    weights_pseudoInv = T * P_plus;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -Function: runNetwork
% -Description: Given an input vector P, use the symetrical hardlims, since
% we are looking to output associative values -1 1, run the neural network
% with the trained weights and the input vector to produce a output vector
% -Postcondition: returns an output vector based on what the weights have
% learned from the training set.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result = runNetwork(P)
    %given the P, input row vector
    global weights_pseudoInv;
    a = hardlims(P * weights_pseudoInv);
    result = a;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -Function: change
% -Description: Given P, an row vector(original) and a number num_pixels,
% the number of pixels to change, we will create a random permutation of
% index's to switch the original image, producing a destructed image, with
% noise.
% -Precondition: returns a new row vector with number of respective pixels
% changed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result = change(P, num_pixels)
    %this function will generate a new vector with the number of pixels
    %changed
    %function expects a row vector
    [row col] = size(P);
    copy_P = P; %so we do not change the integrity of our original data;
    index_to_change = randperm(col,num_pixels);
    for i = index_to_change
       %for each index
       copy_P(i) = copy_P(i) * -1; %flipflop
       %-1 * -1 = 1| 1 * -1 = -1
    end
    result = copy_P;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -Function: test
% -Description: Given P, an input vector, number iterations, to test how
% many times each network should be tested, and number of pixels, this
% function will first initalize a number of correctness variable, and start
% a loop that goes from 1 to number of iterations, for each iteration we
% will make a copy of the orginal input vector which contains the pixel
% changes from num_pixels, and run that test vector against out trained
% network, lastly we compare the output of the network against the original
% vector set, upon correctly recognizing and reconstructing the data, we
% will increment the correctness counter by 1, upon all iterations return
% the number of correct/number of iterations to get a percentage of
% correctness
% -Postcondition: return the percent of correctness 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result = test(P, num_iterations, num_pixels)
    %for each value in here lets do this testing!
    correct = 0;
    for i = 1:num_iterations
        P_ = change(P,num_pixels);
        a = runNetwork(P_);
        if a == P
            %fprintf("Correctly Classified\n")
            correct = correct + 1;
        end
    end
    result = correct/num_iterations;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -Function: runMainTest
% -Description: This function featuers a dynamic testing and reporting
% mechanics, where as we are populateing all test for changing 2, 4, and
% 6px of each image, the first step is we introduce one prototyype vector
% at a time, train the network then test the performance of the network
% with the current trained vectors, as more vectors are used to train we
% take the average performance of all number of vectors used to train at
% that instance and record them into a row vector
function runMainTest(P_prototype)
    P_ = [];
    [r c] = size(P_prototype);
    results2px = [];
    results4px = [];
    results6px = [];
    
    for pp=1:c
       %for each column
       P_ = [P_ P_prototype(:,pp)]; %consider using this vector.
       %maybe reset the weight matrix?
       %trainNetwork_Hebb(P_);
       trainNetworkPesuInv(P_);
       %for each loop record the cumulative performances for each pixel
       %changes
       perf2 = 0;
       perf4 = 0;
       perf6 = 0;
       for j=1:pp
           %no for loop
           res2 = test(transpose(P_prototype(:,j)),10,2);
           res4 = test(transpose(P_prototype(:,j)),10,4);
           res6 = test(transpose(P_prototype(:,j)),10,6);
%            for pixRm=2:2:6
%                %each prototype is of a column vector our test function
%                %requires a row vector so we must transpose the data.
%                 res = test(transpose(p_prototypes(:,j)),10,pixRm);
%                 %yeild a result for respective 2,4,6px changed each
%                 %iteration
%            end
            %add the current results of the respective vector to our
            %cumulating performance counter
            perf2 = perf2 + res2;
            perf4 = perf4 + res4;
            perf6 = perf6 + res6;
       end
       %we need to divide the cumulative perforamnce by the number of
       %vectors used to get the average performance.
       %for each number of prototype vectors trained and used, record the
       %percentage of ERROR, the respective vectors are as follows:
       %[1vector 2vector 3vector 4vector 5vector 6vector 7vector]s used
       results2px = [results2px (1 - perf2/pp)];
       results4px = [results4px (1 - perf4/pp)];
       results6px = [results6px (1 - perf6/pp)];
    end
    %respective Y vectors for our plots of performance measures
%     results2px
%     results4px 
%     results6px 
    x = [1 2 3 4 5 6 7];
    figure;
    plot(x,results2px,'g',x,results4px,'r',x,results6px,'b');
    legend('2px','4px','6px');
    ylabel('Percentage of error (%)');
    xlabel('Number of digits Stored');
    title("Hebbian Learning Rule, using PseudoInverse Rule Performance Metrics");

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -Function: main
% -Description: This main method sets up the original testing prototype
% vectors, creates the P vector, and runes the test chaning 2 4 and 6
% pixels at a time and recording the performance metrics of each, at the
% end we plot the findings on a 2D cartiasian graph showing the percentage
% of error vs the number of digits stored in our weights
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function main()
    %global weights_pseudoInv;

    %Traning Prototype data for "0"
    p_0 = [-1 1 1 1 1 -1 1 -1 -1 -1 -1 1 1 -1 -1 -1 -1 1 1 -1 -1 -1 -1 1 -1 1 1 1 1 -1];
    %Traing Prototype data for "1"
    p_1 = [-1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 -1 1 1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1];
    %Traning Prototype data for "2"
    p_2 = [1 -1 -1 -1 -1 -1 1 -1 -1 1 1 1 1 -1 -1 1 -1 1 -1 1 1 -1 -1 1 -1 -1 -1 -1 -1 1];
    %Traning Prototype data for "3"
    p_3 = [1 -1 1 1 -1 1 1 -1 1 1 -1 1 1 -1 1 1 -1 1 -1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1];
    %Traning Prototype data for "4"
    p_4 = [-1 -1 -1 1 -1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1 -1 -1 1 1 1 1 1 1 -1 -1 -1 1 -1 -1];
    %Traning Prototype data for "5"
    p_5 = [-1 -1 -1 -1 -1 -1 -1 1 1 -1 -1 1 1 -1 -1 1 -1 1 1 -1 -1 1 1 1 -1 -1 -1 -1 -1 -1];
    %Traning Prototype data for "6"
    p_6 = [-1 -1 -1 -1 -1 -1 -1 1 1 1 1 1 1 -1 -1 1 -1 1 1 -1 -1 1 -1 1 1 -1 -1 1 1 1];

    
    % Creation of the prototype matrix used for training
    P_prototypes = [transpose(p_0) transpose(p_1) transpose(p_2) transpose(p_3) transpose(p_4) transpose(p_5) transpose(p_6)];
    %initalize variables for testing
    runMainTest(P_prototypes);

end


