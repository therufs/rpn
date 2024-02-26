# RPN Calculator

## Overview

The RPN calculator consumes arbitrary strings of user input. Calculation is performed on numbers and permitted operators (+ - * /). The user may also input `q` to quit or `c` to clear buffers. Other characters are ignored.

For further details on running the calculator, see [below](#how-to-run-your-code-if-applicable).

## Reasoning behind your technical choices, including architectural

- Ruby: This is the language and ecosystem in which I'm most comfortable, and I'm reasonably confident that the script will not need to handle performance demands such as high throughput or that might warrant considering a language with better performance for those concerns. This also allowed me to invite my old friends rspec, to provide a testing framework that I knew to be descriptive and easy to work with, and rubocop, to keep my code tidy (and proffer accepted opinions on what counts as "tidy"!)
- Separation of concerns: Beyond separating the `run` script from the RpnCalculator class, I haven't broken down the code further. As the codebase expands, it would be wortwhile to consider creating separate classes for concerns such as different IO streams.
- Implementing a stack for operators: Research has indicated that this is an unorthodox choice; it does complicate the implementation more than simply discarding superfluous operators would. I admit I'm not entirely clear on the real-world applications of RPN calculation, so this might be a good candidate for revision.
- `clear` -- Having to exit and restart the calculator whenever one messes up an input is pretty annoying.

## Trade-offs you might have made, anything you left out, or what you might do differently if you were to spend additional time on the project

There are a few obvious stubs; for instance, I decided not to write tests for IO since running the program trivially demonstrates their functionality. For similar reasons, there aren't any of what I'd consider "integration" tests. If/when the calculator was further developed to read from different input sources, it would be worthwhile to test all possible types of IO and to confirm equivalent outputs.

For similar reasons, the `run` command itself is not tested. If this project were going to become a proper command line tool, testing across multiple operating environments would be warranted.

As of writing, the `sort_input` method is comprised primarily of an unwieldy conditional. I don't much care for this, as they can become difficult to reason about, but defining classes to handle different input types (and to placate my internal [Sandi Metz](https://www.poodr.com/)) seems like overkill for a project of this size.

It seems like there ought to be a way to run the calculator in a Codespace hosted by my account; however, Codespaces seems more tailored to serverlike behavior than to letting folks mess around in a terminal, and setting the calculator up as a full remote service seemed beyond the scope of the project.

More features this calculator could include:
  - a verbose mode
  - a Help flag that would describe the operation of the calculator in further detail
  - confirmation before executing `clear` or `quit`

## How to run your code, if applicable

You may either [run in codespace](#codespace) or [install locally](#local-install).  
**Note**: These local instructions have not been tested for compatibility outside of my own development environment (MacOS Mojave, Ruby 3.3.0). If you encounter errors that you think may be related to the Ruby version, please [let me know](mailto:rcfreese@gmail.com)!

### Codespace

1. Fork the repository: <https://github.com/therufs/rpn/fork>
1. From the forked repository, open the Code menu (green button), then the Codespaces tab
1. Click the green button ("Create codespace on main")
1. From the terminal pane, run the calculator: `$ ./run.rb`

### Local install

1. [Install Ruby, if necessary](#install-ruby)
2. [Download the source files](#download-the-source-files)
3. [Run](#run)

#### Install Ruby

Check to see if your machine has Ruby installed. From a shell session:

`$ ruby -v`

If you see something like `command not found`, you will need to install Ruby. See the Ruby [installation reference](https://www.ruby-lang.org/en/documentation/installation/) for directions on how to do this for your operating system. This calculator was developed using Ruby 3.3.0.

#### Download the source files

Clone the code from Github: `$ git clone https://github.com/therufs/rpn.git`

#### Run

```
$ cd rpn
$ ./run.rb
```
