+++
title = "Testing with Boost.Test"
description = "A short and simple post about creating C++ unit tests using the Boost Test Framework"
date = "2020-05-04"
tags = [
    "boost",
    "testing",
    "c++",
    "unit tests"
]
+++
-------------------------

# What Is It?

Boost.Test is a C++ header-only library for easily creating unit tests and
providing developers with some of the common testing components. It's part of 
the [Boost](https://www.boost.org/doc/libs) collection of libraries that are
free and open source.

# How Do I Set It Up?

In the simple case, it's as easy as installing the Boost development headers
from your package manages (e.g. `yum install boost-devel`) and then the headers
should be accessible in the default system paths. If you don't have admin
privileges, then you might have to do some more work including installng
to your home directory.

# Execution Paradigms

There are two sets of execution paradigms for creating the test runner. 

1. Each test or test-suite can be separated into it's own executable test 
runner. This fits in nicely with CMake's CTest framework.
2. All tests can be dynamically linked and a test runner can be created that
will find all the tests and run them.

The type of setup is defined at the top of the file by macros. A stand-alone test
is defined by:

```
#define BOOST_TEST_MODULE Thing I Want To Test
#include <boost/test/included/unit_test.hpp>
```

While a dynamically linked is defined as:

```
#define BOOST_TEST_DYN_LINK
#define BOOST_TEST_MODULE Thing I Want To Test
#include <boost/test/included/unit_test.hpp>
```

NOTE: The order of the defines don't matter, but they should be before you
include `boost/test/included/unit_test.hpp`.

# Writing Basic Tests

Following the boost headers and any headers you need for your tests, you will 
define all your tests in the form:

```
BOOST_AUTO_TEST_CASE(test_thing_one)
{
  ... < test code >
}

BOOST_AUTO_TEST_CASE(test_thing_two)
{
  ... < test code >
}
```

Inside each test case, you can use `BOOST_TEST` for boolean checks or any
number of [provided macros](https://www.boost.org/doc/libs/1_73_0/libs/test/doc/html/boost_test/utf_reference/testing_tool_ref.html). 
You can even provide levels such as `BOOST_WARN` (warn about a problem but
don't fail), `BOOST CHECK` (fail but continue the test), and `BOOST_REQUIRE`
(fail and stop the test).

A simple example would be:
``` 
BOOST_AUTO_TEST_CASE(test_thing_one)
{
  int x = 1;
  int y = 1;
  int z = x + y;
  BOOST_TEST(2)
}
```

# Adding Fixtures

Sometimes when writing unit tests, it's necessary to run similar routines
to prepare or teardown states in multiple tests. This is where fixtures can
be useful.

The following is a simple example of a fixture although, admittedly, not the 
best use case for one:
```
struct myfixture {
  myfixture() {
    // setup code
    myfixturevar = 1;
  }

  ~myfixture() {
    // teardown code
  }

  int myfixturevar;
}

BOOST_FIXTURE_TEST_CASE(my_fixture_test, myfixture) {
  int mytestvar = 1;
  BOOST_TEST(mytestvar == myfixturevar)
}
```

# Conclusion

I hope this small tutorial helps you with your unit testing endeavors.  
