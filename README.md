# Jedi Factory

## Reports
**Build Status:**
[![Build Status](https://secure.travis-ci.org/marcel-valdez/algorithms-data-structures.png?branch=master)](https://travis-ci.org/marcel-valdez/algorithms-data-structures)  
  
**Code Metrics Results:** 
[![Code Climate](https://codeclimate.com/github/marcel-valdez/algorithms-data-structures.png)](https://codeclimate.com/github/marcel-valdez/algorithms-data-structures)
  
**Ohloh Statistics:**
<a href="https://www.ohloh.net/p/algorithms-data-structures?ref=sample" target="_top">
<img alt="Ohloh project report for algorithms-data-structures" border="0" src="https://www.ohloh.net/p/algorithms-data-structures/widgets/project_thin_badge.gif">
</a>

## Description
  
This project is inspired by RubyKoans (http://rubykoans.com), in the sense of using TDD for learning.
This project will help the user learn algorithms and data structures by asking of him to code methods that
must pass tests that specify the behavior of many fundamental algorithms and data structures of Computer Science.

This project will contain the topics of algorithms and data structures found in the book:
Algorithms 4th Ed by Robert Sedgewick and Kevin Wayne, focusing on the book and the exercises at http://algs4.cs.princeton.edu/home/

You can get a quick introduction to the project's details with this [Google Doc presentation](http://bit.ly/UbsG8O).
  
## Code Structure
  
The folders src and test have a simmetric structure:
* src/ contains the Ruby code for the algorithm
* src/utils/ contains utilities for implementing the algorithms
* test/ contains tests for the algorithm, note that if you plan to contribute to this project, you should use TDD for the development of these algorithms.

Folder organization:

````
test/
|-- chapter_x/
    |-- section_y/
        |-- zzz_exercises_test.rb
    |-- utils/
        |-- xxx_test.rb

src/
|-- chapter_x/
    |-- section_y/
        |-- zzz_exercises.rb
    |-- utils/
        |-- xxx.rb
````


## Usage

How to start using the project on the Jedi Box:

### Easy Way

1. Go into our Cloud9 IDE Workspace: https://c9.io/marcel_valdez/algorithms-user-project
2. Clone the workspace into your Cloud9 IDE account (create an acccount if you don't have one)
3. Start coding right away!
4. In the terminal type: `bundle exec guard`
5. Go into one of the tests and comment one of the `omit(Yet to see the light)` methods to work on that test.
6. Implement the method corresponding to that test.

For more details on implementing tests read the [Google Doc presentation](http://bit.ly/UbsG8O).

### Using the Jedi Box

Jedi Box a Virtualbox machine with minimal Ubuntu 12.04 installed and the Jedi Factory project setup in it.

You can find a self-extracting zip archive that contains a VirtualBox machine that has this project
setup along with an editor here:
[Download the Jedi Box SFX Archive](http://bit.ly/11bDCb5) (574 mb)
[Download the Jedi Box ZIP Archive](http://bit.ly/115RR11) (813 mb)

The credentials to login into the Ubuntu Linux OS inside the VirtualBox machine are:

username: padawan
password: matr1234

Boot up your virtual machine and do the following.

````bash
ubuntuminial login: padawan
Password: matr1234

padawan@ubuntuminimal:~$ startx
# In the LXDE Window Environment: Start -> Accessories -> LXTerminal
# Inside the LXTerminal
padawan@ubuntuminimal:~$ enlightment.sh
# This will open Sublime Text 2 and run Guard the continous test runner
````

### Old-School Way

How to setup the project on your own Linux Box:

````bash
cd $HOME
# initialize the git repository
mkdir jedi_factory
cd jedi_factory
git init .
git remote add origin git://github.com/marcel-valdez/algorithms-user-project.git
git pull origin master
# initialize dependencies
bundle install
# run Guard the automatic test runner.
bundle exec guard
# Go and shed the light! (Solve exercises)
````

### Updating your Jedi Box with the most recent changes

Small Note: This works in your own box, the virtual machine or your Cloud9 IDE workspace.

````bash
# Inside a terminal
padawan@ubuntuminimal:~$ cd $HOME/learn
padawan@ubuntuminimal:~$ git pull origin master
# Easy as that!
````


## Contributing
  
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

**All exercises inside a chapter/section must be either in the 'Algorithms' webpage, or the book.**  
Book: Algorithms 4th Ed by Robert Sedgewick  
Webpage: http://algs4.cs.princeton.edu/home/

In order to add exercises for a section you have to add a new test/chapter_x/section_y/zzz_exercises_test.rb file and a new src/chapter_x/section_y/zzz_exercises.rb implementation.
  
### Rules for contributing to the project

* Add the exercise name and section of the exercise you programmed/tested to the dev_plan.md file, appending
  your github username (and be known for you mad algorithmic skillz).
* All exercises must have a test and solution
* All pull requests are reviewed by the reviewing team
* If the pull request does not pass the CI process, it is rejected.
* It is not allowed to increment the minimum Flay score nor the number of style violations.
* Please use good coding style (https://github.com/styleguide/ruby)
* Your answers to any exercise must be in optimal big-O time complexity, unless the exercise requires a specific structure or
algorithm.
