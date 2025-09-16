# Lookup book details on [isbnsearch.org](https://isbnsearch.org/isbn/)
```shell
$ isbn.search -h
NAME:
  isbn.search - Search for an ISBN on 'isbnsearch.org'.

USAGE:
  isbn.search [-b <DATA|FILENAME>] <ISBN>

OPTIONS:
      --version         display version and exit
  -b, --cookie <VALUE>  Data to pass in the Cookie header. Data should be in the
                            format 'NAME1=VALUE1; NAME2=VALUE2' or a single filename.
  -h, --help            Display usage and exit

$ isbn.search 0133708756

+-----------+------------------+
| ATTRIBUTE | VALUE            |
+-----------+------------------+
| Title     | ANSI Common LISP |
| ISBN-13   | 9780133708752    |
| ISBN-10   | 0133708756       |
| Author    | Paul Graham      |
| Edition   | 1                |
| Binding   | Paperback        |
| Publisher | Pearson          |
| Published | 1995-11-02       |
+-----------+------------------+

```
