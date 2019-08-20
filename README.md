
OCaml Starter Kit
===

Starter kit for OCaml projects and instructions for development environment.

## Usage

1. [Install opam](https://opam.ocaml.org/doc/Install.html), usually with the package manager of your OS.  Check if it works with `echo $OCAML_TOPLEVEL_PATH`.
2. Install a compiler, say with `opam switch create 4.08.0`.
3. You will definitely use `utop`.  Add a global `~/.ocamlinit` file with the following contents so that utop finds your packages:

   ```ocaml
   #use "topfind";;
   #thread;;
   ```

4. Create a local *switch*, which is opam's concept for an isolated environment, for you project, which will reside at `_opam` under project root.  This takes some time:

   ```shell
   $ opam switch create . 4.08.0 --deps-only
   # or if you already have a local switch in _opam
   $ opam install . --deps-only
   $ eval $(opam env)
   ```

5. Run the following commands:

   ```shell
   $ make all
   $ make test
   $ make utop
   utop # open Lib.Minty;;
   utop # message;;
   - : string = "hello, world!"
   utop # ^D
   ```

## Setup for development

1. Write an `app.opam` for your project.  Specify dependencies under `depends`.  You can start from the `app.opam` of this starter kit.
2. If you are building an application, put your code in `src/main.ml`, and add a `src/dune` file for it.  Note that it could also be `executables` and `names` to build multiple executables with the same configuration:

   ```
   (executables
    (names main)
    (libraries core))
   ```

3. If you are building a library, say your code is in `lib/minty.ml`, then add a `lib/dune` file for the whole `Lib` module:

   ```
   (library
    (name lib))
   ```

4. You can open your module `Lib.Minty` in `main.ml` by specifying `(libraries lib core)` in its `src/dune` file.  Dune builds recursively.
5. Run your executable with `dune exec ./main.exe`.  Test your library code with `dune utop lib`.
6. To update dependencies, edit `app.opam` and then do `opam install . —deps-only`.  To lock dependencies do `opam lock`, which will create a `app.opam.lock`.  To deploy program, install dependencies with `opam install . —deps-only —lock`.

## Setup for deployment

Use the following commands when creating a local switch for deployment, so that dependencies are pinned/locked:

```shell
$ opam switch create . 4.08.0 --deps-only --lock
# or if you already have a local switch in _opam
$ opam install . --deps-only --lock
$ eval $(opam env)
```

## Suggestions to developer tools

The `app.opam` in project setup provides a decent set of basic tools:

* [dune](https://dune.build/): OCaml building tool
* [opam-lock](https://opam.ocaml.org/doc/man/opam-lock.html): lock dependencies for opam
* [utop](https://github.com/ocaml-community/utop): universal toplevel for OCaml
* [ocp-indent](https://www.typerex.org/ocp-indent.html): indentation tool for OCaml
* [merlin](https://github.com/ocaml/merlin): context sensitive completion for OCaml

We have covered the first 3 tools above.  You can run ocp-indent from command-line:

```shell
$ ocp-indent <src-file> > <dst-file>
```

The followings will be how to setup your editor.

### VIM

To setup ocp-indent, install [ocp-indent-vim](https://github.com/def-lkb/ocp-indent-vim) and [syntastic](https://github.com/vim-syntastic/syntastic).

To setup merlin, consult [documentation](https://github.com/ocaml/merlin/wiki).
