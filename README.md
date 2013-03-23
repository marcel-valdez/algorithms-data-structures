<h2>Reports</h2>
**Build Status:**
[![Build Status](https://secure.travis-ci.org/marcel-valdez/algorithms-data-structures.png?branch=master)](https://travis-ci.org/marcel-valdez/algorithms-data-structures)  
  
**Code Metrics Results:** 
[![Code Climate](https://codeclimate.com/github/marcel-valdez/algorithms-data-structures.png)](https://codeclimate.com/github/marcel-valdez/algorithms-data-structures)
  
**Ohloh Statistics:**
<a href="https://www.ohloh.net/p/algorithms-data-structures?ref=sample" target="_top">
<img alt="Ohloh project report for algorithms-data-structures" border="0" src="https://www.ohloh.net/p/algorithms-data-structures/widgets/project_thin_badge.gif">
</a>
<h2>Description</h2>
  
This project is inspired by RubyKoans (http://rubykoans.com), in the sense of using TDD for learning.
This project will help the user learn algorithms and data structures by asking of him to code methods that
must pass tests that specify the behavior of many fundamental algorithms and data structures of Computer Science.

This project will contain the topics of algorithms and data structures found in the book:
Algorithms 4th Ed by Robert Sedgewick and Kevin Wayne, focusing on the book and the exercises at http://algs4.cs.princeton.edu/home/

You can get a quick introduction to the project's details with this [Google Doc presentation](http://bit.ly/UbsG8O).
  
<h2>Code Structure</h2>
  
The folders src and test have a simmetric structure:
* src/ contains the Ruby code for the algorithm
* src/utils/ contains utilities for implementing the algorithms
* test/ contains tests for the algorithm, note that if you plan to contribute to this project, you should use TDD for the development of these algorithms.

Folder organization:
* test/
    * chapter_x/
      * section_y/
          * zzz_exercises_test.rb
    * utils/
      * xxx_test.rb
  
* src/
    * chapter_x/
        * section_y/
          * zzz_exercises.rb
    * utils/
      * xxx.rb

<h2>Usage</h2>
  
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
<h2>Contributing</h2>
**All exercises inside a chapter/section must be either in the 'Algorithms' webpage, or the book.**  
Book: Algorithms 4th Ed by Robert Sedgewick  
Webpage: http://algs4.cs.princeton.edu/home/

In order to add exercises for a section you have to add a new test/chapter_x/section_y/zzz_exercises_test.rb file and a new src/chapter_x/section_y/zzz_exercises.rb implementation.
  
<h3>Rules for contributing to the project</h3>
* Add the exercise name and section of the exercise you programmed/tested to the dev_plan.md file, appending
  your github username (and be known for you mad algorithmic skillz).
* All exercises must have a test and solution
* All pull requests are reviewed by the reviewing team
* If the pull request does not pass the CI process, it is rejected.
* It is not allowed to increment the minimum Flay score nor the number of style violations.
* Please use good coding style (https://github.com/styleguide/ruby)
* Your answers to any exercise must be in optimal big-O time complexity, unless the exercise requires a specific structure or
algorithm.
