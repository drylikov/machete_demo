defmodule MacheteDemoTest do
  #
  # ABOUT MACHETE
  # 
  # Machete is a tool to help you write more literate and expressive test assertions.
  #
  # The foundation of Machete is the ~> ('squiggle arrow') operator. This operator takes the
  # value on its left hand side and 'matches' it against the value on its right. The operator then
  # returns a boolean value indicating whether this match succeeded or failed. 
  #
  # The exercises in this file are a gradual introduction to how matchers work in Machete. We'll
  # begin with some basic building blocks such as literals, variables, and parametric matchers. In
  # the final exercise of this file we'll combine all of these pieces into a coherent whole; this
  # is where Machete really starts to shine. Hopefully you will leave this demo with an
  # understanding of how your own tests can be simplified & improved using Machete.
  # 
  # RUNNING THIS DEMO
  #
  # The Machete demo is structured as a series of failing tests. You are expected to make each of
  # them pass one by one by following the hints given for each. 
  #
  # All of the tests except the first are skipped by default; as you work through the tests and
  # make them pass, remove the `@tag: :skip` line the following test to keep making progress!
  #
  # Each test has an overview and some hints to help you on your way. Consult the [Machete
  # docs](https://hexdocs.pm/machete/Machete.html) for details about how to use Machete.
  #
  # THERE ARE NO WRONG ANSWERS! The whole point of this exercise is to get you familiar
  # with the Machete library, so whatever path you choose to take on that journey is fine! Good 
  # luck!
  # 
  # If you get stuck, or want to jump right to the end, the `shortcuts` branch of this repo
  # contains passing versions of these tests.
  #

  use ExUnit.Case
  use Machete

  #
  # TEST 1: Literal matching
  #
  # This test demonstrates Machete's ability to match literal values, including strings, integers,
  # atoms, and others
  #
  # This test is currently failing because some of our literal comparisons don't quite align.
  # Literal comparison is done using triple-equal semantics, which require exact type equivalence
  # in addition to value equivalence.
  #
  # HINTS: 
  #
  # 1. Consult Elixir's documentation on the
  #    [===/2](https://hexdocs.pm/elixir/1.15.4/Kernel.html#===/2) operator for details on strict
  #    equivalency.
  # 2. You can also experiment with equivalency in an `iex` session if you prefer to work
  #    interactively.
  #

  test "TEST 1: literals" do
    # Your job is to make each of these assertions pass
    assert (2 + 2) ~> 5
    assert 5 ~> (2 + 2)
    assert (2 + 2) ~> 4.0
    assert 123 ~> "123"
    assert :abc ~> "abc"
    assert nil ~> false
  end

  #
  # TEST 2: Matching variables
  #
  # This test demonstrates Machete's ability to match assertions with variables in them. Variables
  # can be present on either the left or the right side of an assertion, and will work in a manner
  # similar to how variables work in languages which do not support pinning (ie: as you likely
  # expect them to).
  # 
  # This test is currently failing because our variable values and literal values do not quite
  # align.
  #

  # IMPORTANT! Remove / comment out the following `@tag :skip` line to start running this test
  @tag :skip
  test "TEST 2: variables" do
    abc_str = "abc"
    abc_atom = :abc

    # Your job is to make each of these assertions pass
    assert abc_str ~> "ABC"
    assert abc_atom ~> "abc"
    assert "abc" ~> abc_atom
    assert (abc_str <> abc_str) ~> "abc abc"
  end

  #
  # TEST 3: Parametric matchers
  #
  # This test demonstrates the usage of some of Machete's parametric matchers. Parametric matchers
  # allow you to make assertions about a value based on general attributes of the value, such as
  # its type. 
  # 
  # This test is currently failing because our matchers do not quite align with the values we are
  # asserting against
  #
  # In addition to the simple type-based parametric matchers we'll seen here, Machete also
  # includes a rich set of algebraic and collection-based matchers, some of which we'll see later.
  # A complete list is available in the 'Matchers' section of the [Machete
  # docs](https://hexdocs.pm/machete/Machete.html).
  #

  # IMPORTANT! Remove / comment out the following `@tag :skip` line to start running this test
  @tag :skip
  test "TEST 3: parametric matchers" do
    assert 1.0 ~> integer()
    assert "abc" ~> atom()

    # Matchers can also take arguments, which can further refine the values that will match
    assert "abc" ~> string(length: 4)
    assert -1 ~> integer(positive: true)

    # Matchers are defined for a number of built-in types as well
    # HINT: ISO8601 uses dashes ("-") to separate date components, not slashes
    assert "2023/07/15T00:00:00.000000Z" ~> iso8601_datetime()
    assert DateTime.utc_now() ~> datetime(before: ~U[2020-01-01 00:00:00.000000Z])

    # Matching on structs can be a bit tricky since they can have default values. The
    # `struct_like` matcher helps with this; only fields listed in the second argument are checked
    assert URI.parse("http://example.com/abc")
           ~> struct_like(URI, %{scheme: "http", host: "example.com", path: "/def"})

    # You can also match against regexes
    assert "abc" ~> ~r/def/

    # More matchers (these already pass! They're just here for demonstration)
    assert DateTime.utc_now() ~> datetime(roughly: :now)
    assert Date.utc_today() ~> date(after: ~D[2023-07-15])
    assert self() ~> pid()
    assert make_ref() ~> reference()
    assert nil ~> falsy()
  end

  # 
  # TEST 4: Matching collections
  #
  # This test demonstrates Machete's ability to match against collections.
  #
  # HINTS:
  #
  # 1. Machete requires collections to have the same shape; maps must have the same set of keys,
  #    lists and tuples must be of the same length / size.
  #
  # 2. Anything that is matchable can appear inside a collection. This includes everything we've
  #    seen so far; literals, variables, matchers, even other collections!
  # 
  # 3. When an assertion fails, Machete will provide the path to the failing assertion(s) using
  #    a syntax nearly identical to that used by [jq](https://jqlang.github.io/jq/).
  #

  # IMPORTANT! Remove / comment out the following `@tag :skip` line to start running this test
  @tag :skip
  test "TEST 4: collections" do
    assert %{a: 123} ~> %{b: 123}
    assert %{a: -123} ~> %{a: integer(positive: true)}
    assert [1, 2, 3] ~> [1, 2]
    assert {1, 2, 3} ~> {integer(), integer(), float()}
    assert {:ok, [1, 2]} ~> {:ok, {1, 2}}

    # There are a number of matchers defined for collections as well
    # (these already pass! They're just here for demonstration)
    #
    # Assert that the left hand side is a map from atoms to integers
    assert %{a: 123, b: 234} ~> map(keys: atom(), values: integer())
    # Assert that the left hand side contains at least the specified map
    assert %{a: 123, b: 234} ~> superset(%{a: integer()})
    # Assert taht the left hand side is a list of integers of length 3
    assert [1, 2, 3] ~> list(length: 3, elements: integer())
    # Assert that the left hand side contains the values 1, 2, 3 in any possible order
    assert [3, 2, 1] ~> in_any_order([1, 2, 3])
  end

  # 
  # TEST 5: DIY Matchers
  #
  # This test demonstrates the idea of extending Machete to make your own matchers. This lets you
  # build a suite of matchers that are specific to your application's domain, making your tests
  # read even more literately.
  #
  # HINTS:
  #
  # 1. Matchers are just functions; there is no macro magic or anything subtle
  # 2. We're not covering it here, but you can implement custom matchers for any of your own
  #    struct types; see the Matchable protocol for details. This same protocol is actually what
  #    powers all of Machete's matchers, and it's free for you to use on your own types as well.
  #

  # IMPORTANT! Remove / comment out the following `@tag :skip` line to start running this test
  @tag :skip
  test "TEST 5: DIY Matchers" do
    # These two tests are equivalent (both of them also pass and are here just for illustration)
    assert 123 ~> integer(positive: true)
    assert 123 ~> identifier()

    # Now make a matcher function to match against a Canadian province prefix, based on the
    # following example
    assert "ON" ~> any(~w[BC AB SK MB ON QC NB NS PE NL YT NT NU])

    assert "ON" ~> province()
  end

  def identifier() do
    integer(positive: true)
  end

  # You'll need to implement this function
  def province() do
    raise "Implement me!"
  end

  #
  # TEST 6: Putting it all together
  #
  # In this test we'll be combining all of the things we've learned so far into one super test.
  # This is where the power and expressiveness of Machete really starts to become clear; if you
  # compare this test to how you would have written a similar test in vanilla ExUnit, I hope
  # you'll find the Machete approach to be much cleaner and easier to understand.
  #
  # There is nothing new in this test that we haven't already seen in this demo; it's just
  # a matter of combining the various pieces into a cohesive whole
  #
  # This test attempts to test the `MacheteDemo.get_user/0` function. This function returns
  # a randomly generated user which has a structure like the following:
  #
  # %{
  #   id: <a positive integer>,
  #   name: <a random full name>,
  #   age: <random int from 20 to 80>,
  #   created_at: <the time this random user was generated, as a DateTime>
  #   is_admin: false,
  #   tags: <A list of three randomly generated tags>
  # }
  #
  # HINTS:
  # 
  # 1. Add an `IO.inspect(MacheteDemo.get_user())` at the beginning of the test to see the actual
  #    returned structure
  # 2. The `term()` matcher will match any value. You can use it as a quick way to fill in
  #    assertions on fields if you want to quickly get to a passing test as soon as possible in
  #    order to iterate on making individual fields' assertions more focused later on
  # 3. There is no right answer on how focused to make your assertions. Sometimes you may want to
  #    be super precise with your matchers & their parameters, and sometimes a simple `term()` is
  #    fine. It's all up to you and how much detail you think that a specific test needs.
  #

  # IMPORTANT! Remove / comment out the following `@tag :skip` line to start running this test
  @tag :skip
  test "TEST 5: Putting it all together" do
    assert MacheteDemo.get_user() ~> :todo
  end
end