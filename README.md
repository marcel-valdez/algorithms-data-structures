<script src="http://www.ohloh.net/p/605940/widgets/project_basic_stats.js" type="text/javascript">
</script>
This project is inspired by RubyKoans (http://rubykoans.com), in the sense of using TDD for learning.
This project will help the user learn algorithms and data structures by asking of him to code methods that
must pass tests that specify the behavior of many fundamental algorithms and data structures of Computer Science.  
  
This project will contain the topics of algorithms and data structures found in the book:  
Algorithms 4th Ed by Robert Sedgewick and Kevin Wayne, focusing on the book and the exercises at http://algs4.cs.princeton.edu/home/

The folders src and test have a simmetric structure:
* src/ contains the Ruby code for the algorithm
* src/utils/ contains utilities for implementing the algorithms
* test/ contains tests for the algorithm, note that if you plan to contribute to this project, you should use TDD for the development of these algorithms.

Folder organization:
* src/  
    * chapterX/  
        * sectionY/
          * ZzzExercises.rb  
    * utils/
  
* test/ 
    * chapterX/  
      * sectionY/
          * ZzzExercises_test.rb  

**All exercises inside a chapter/section must be either in the 'Algorithms' webpage, or the book.**  
book: Algorithms 4th Ed by Robert Sedgewick  
webpage: http://algs4.cs.princeton.edu/home/  

In order to add exercises for a section you have to add a new test/chapterX/sectionY/ZzzExercises_test.rb file and a new src/chapterX/sectionY/Exercises.rb implementation.  

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

Rules for contributing to the project:
* Add the exercise name and section of the exercise you programmed/tested to the dev_plan.txt file, appending 
  your github username (and be known for you mad algorithmic skillz).
* All exercises must have a test and solution
* All pull requests are reviewed by the reviewing team
* Please use good coding style (https://github.com/styleguide/ruby)
* Your answers to any exercise must be in optimal big-O time complexity, unless the exercise requires a specific structure or
algorithm.