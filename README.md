# Neural_Network_Hebbian_Learning
This Program was built to demonstrate one of the oldest learning algorithms introduced by Donald Hebb in 1949 book Organization of Behavior, this learning rule largly reflected the dynamics of a biological system. The understanding of Doctor Hebb's research was that a Synapse between two neurons is strengthended when the eurons on either side of the synapse (input and output) have highly correlated outputs. Esstentially when an input neuron fires, the output neuron, the synapse(connection between the two/ WEIGHTS) strengthen ( the weights grow in a postive manner). Following this analogy to an artifical system, the weight is increased with high correlation between two sequential neurons.

## Getting Started

This program features two learning rules, a Hebbiean Learning rule original and a pseudoInverse learning rule, which we will try to answer given 6 prototype vectors, how many images can this network really learn and store in its weight matrix until the performance are effected, and of the two sub classes of hebbian learning which performancs better. Both files are in matlab, and are ready to be simply run, they both generate performance metrics as you will see later.
# what we are trying to accomplish
![reconstruct original images given noise](https://image.ibb.co/gNGUGR/what_we_are_trying_to_do.png)
 This network is built to reconstruct the original images given noisey data images, for the test we train the nueral network with correct prototype vectors of the digits resembling "0", "1", "2","3","4","5", and "6" respectively, then present the network with 2pixels, 4 pixels, and 6 pixels, changed from each digit and record the number of times the network correctly recognizes these destructive images.
### Design
  For this Hebbiean learning we use a symetrical hard limit transfer function since out outputs for this network are bi-polar ( -1 1)
  
  ![atl](https://image.ibb.co/kUxx36/hardlims_Diagram.jpg) 
  the first P(prototype vectors for training are used are of a row vectors


### performance metrics
These images below, show the performance of the trained perceptron network, when given input vectors that have been altered by 2, 4, and 6pixels respectivly, the methodology for testing this was, to randomly generate a array of  the number of pixels to change holding permutated index's in which we flipped their original input, this produced noise into the network, and we recorded the performance  of the network given these noisey vectors, as expected, the more pixels we changed the lower the performance metric would be. 
![This is the Hebiean Learning](https://image.ibb.co/d8NmwR/Hebb.png) 

![This is pseudo Inverse Learning](https://image.ibb.co/i37x36/Pseudo_Inv.png)
 ### Summary 
 as we can see the performance metric for the Hebb Rule is slightly more error prone than using the pseudoinverse rule, however the differences are small, the pseudo inverse comes at a price for this better accuracy which is time, to compute the pseudoinverse of a prototype matrix it will take more computational time than a original hebb rule will. However noice that when there are 


### Prerequisites

What things you need to install the software and how to install them
Matlab2017a

## Running the tests
Simply run the matlab file, test are already preconfigured 

## Authors
Danny Ly

## References
[Comparison of Different Learning](https://ac.els-cdn.com/S1877050915036662/1-s2.0-S1877050915036662-main.pdf?_tid=6dfadc9e-bcf3-11e7-b1d6-00000aacb35f&acdnat=1509314116_36fc24552c9b123c4682b1fcd83ce068) 
