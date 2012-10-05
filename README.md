This project will contain the topics of algorithms and data structures found in the book:
             Algorithms 4th Ed by Robert Sedgewick and Kevin Wayne

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

How to setup the project to contribute on Linux:

````bash
cd $HOME
mkdir algorithms_data_structures
cd algorithms_data_structures
git init .
git remote add origin git://github.com/marcel-valdez/algorithms-data-structures.git
git pull origin master
````

You can run continuous testing using Guard, by running:
```` bash
bundle exec guard
````