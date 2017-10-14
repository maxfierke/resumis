## How to contribute to Resumis

#### **Did you find a bug?**

* **Do not open up a GitHub issue if the bug is a security vulnerability
  in Resumis**, and instead please send me an email ([max+github@maxfierke.com](mailto:max+github@maxfierke.com?subject=RESUMISSEC:+Suspected+vulnerability))

* **Ensure the bug was not already reported** by searching on GitHub under [Issues](https://github.com/maxfierke/resumis/issues).

* If you're unable to find an open issue addressing the problem, [open a new one](https://github.com/maxfierke/resumis/issues/new). Be sure to include a **title and clear description**, as much relevant information as possible, and (if possible) a **code sample** or an **executable test case**, such as a `cURL` command, demonstrating the expected behavior that is not occurring.

#### **Did you write a patch that fixes a bug?**

* Open a new GitHub pull request with the patch.

* Ensure the PR description clearly describes the problem and solution. Include the relevant issue number if applicable.

#### **Do you intend to add a new feature or change an existing one?**

* [Open a discussion issue](https://github.com/maxfierke/resumis/issues/new?labels=discussion) and let's talk about it!

#### **Do you have questions about the source code?**

* [Open a question issue](https://github.com/maxfierke/resumis/issues/new?labels=question) or reach out to me [on Twitter](https://twitter.com/m4xm4n)

## Git Etiquitte

* Always write a clear log message for your commits. One-line messages are fine for small changes, but bigger changes should look like this:

    $ git commit -m "A brief summary of the commit
    > 
    > A paragraph describing what changed and its impact.
    > Any technical details describing any debugging or
    > research you needed to do are also welcome info."

* Squash any "WIP" or "fixup" commits before opening a PR / requesting a review
* Avoid combining unrelated changes in one commit

## Coding conventions

Most of the conventions used in Resumis are fairly idiomatic Ruby & Rails conventions.
Following [The Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide) is a good way to align.

Some specifics to highlight:

  * Indent using two (2) spaces (soft tabs)
  * Avoid putting non-trivial logic in controllers
    * Service objects are your friend!!!
  * If there's branching, there's probably an opportunity for method extraction.
  * Put anything long-running in a Sidekiq job
  * ALWAYS put spaces after list items and method parameters (`[1, 2, 3]`, not `[1,2,3]`), around operators (`x += 1`, not `x+=1`), and around hash arrows.
  * Symbols for Hash keys unless unavoidable
  * If an error class is surfaceable to the user, it should have an error object with user-friendly details. See [app/models/errors](app/models/errors) for examples.

Happy hacking!

&mdash; ❤️ Max