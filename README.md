This project was motivated by RubyKoans (http://rubykoans.com), in the sense of using TDD for learning.
This project will help the user to learn algorithms and data structures by asking of him to code methods that
must pass tests that specify the behavior of many fundamental algorithms and data structures of Computer Science.  
  
This project will contain the topics of algorithms and data structures found in the book:  
Algorithms 4th Ed by Robert Sedgewick and Kevin Wayne, focusing on the book and the exercises at http://algs4.cs.princeton.edu/home/

The folders doc, src and test will have the same structure:
* src/ contains the Ruby code for the algorithm
* src/utils/ contains utilities for implementing the algorithms
* test/ contains tests for the algorithm, note that I will (for the most part) use TDD for the development of these algorithms.

Folder organization:
* src/  
    * chapterX/  
        * SectionYExercises.rb  
    * utils/  
  
* test/ 
    * chapterX/  
        * SectionYExercises_test.rb  

In order to add exercises for a section you have to add a new SectionYExercises_test.rb file and a new SectionYExercises.rb implementation.  

How to setup the project on Linux:

````bash
cd $HOME
mkdir algorithms_data_structures
cd algorithms_data_structures
git init .
# Or you can fork the repository and send a pull request through github to contribute.
git remote add origin git://github.com/marcel-valdez/algorithms-data-structures.git
git pull origin master
bundle install
````

You can run continuous testing using Guard, by running:
```` bash
bundle exec guard
````
