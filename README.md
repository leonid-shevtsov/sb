# sb - a command-line project helper for Sublime Text

## Installation

The script has no dependencies and should work with the system Ruby on Linux and Mac, so just clone and link:

``` bash
git clone https://github.com/leonid-shevtsov/sb.git
ln -fs $(pwd)/sb.rb /usr/bin/sb
```

Also, make sure that `subl` - the built-in Sublime Text command line helper - is in your `$PATH`.

## Usage

* Navigate to project
* Run `sb`
* If there is no project configuration in the folder, one will be created.

You can run `sb` from nested folders, too - it finds parent projects similarly to `git`.

* * *

Made by [Leonid Shevtsov](https://leonid.shevtsov.me)
