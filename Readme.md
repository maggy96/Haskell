# ![haskell-logo](logo.png) Haskell learning logs
<img src="http://g.recordit.co/Lcmhs72JHk.gif" width="50%" align="right">

#### Description

This is a simple list I put together while learning Haskell. It contains the most common language features I use every day.
Also there are **some** Solutions to [CIS 194](http://www.seas.upenn.edu/~cis194/spring13/lectures.html), the [99 Problems](https://wiki.haskell.org/H-99:_Ninety-Nine_Haskell_Problems) and some other random little snippets.
This readme is kind of a cheat sheet.


---

## 1. Lists

> As the bread and butter of functional programming, lists deserve some serious attention. The standard prelude defines dozens of functions 
> for dealing with lists. - *[Real World Haskell](http://book.realworldhaskell.org/read)*

#### Basic List operations
- Concatenation: 
	- `++` | concatenates two lists of the same kind
	- `:` | adds a single `a` to the head of `[a]`
- `head` | first element of a list, also there is `tail`, `last`
- `<`, `<=`, `>`, `>=` compares heads of lists
- `length` | length of a list
- `take` | takes first n elements of a list, `drop` drops first n elements of a list
- `elem` | returns `True` if something is part of the list
- `cycle` | repeats the list endless times, use with take
- `repeat` | cycle for single elements. creates a list. Use `replicate` for limited numbers.
- `!! n` | nth element

#### Ranges
Ranges can be declared by typing `[a..b]`, where `a` is the start element, and `b` is the end of the range. `a` and `b` should be of the same type. Watch out for floating point numbers, it tends to be shitty with that.

#### Filters
`[x*2 | x <- [1..10], x*2 >= 12]`

its like rubys `(1..10).each do {|n| puts n*2 if n*2>12}`

---

## 2. Types
> In Haskell, types are how you describe the data your program will work with. - *[Haskell Wiki](https://wiki.haskell.org/)*

Common basic types are `Char`, `Bool`, `Integer`/`Int`, `Double`.
Writing type signatures for functions is considered a good practice.

`sample :: Int -> Int`

#### Type Classes
Common type classes are `Eq`, `Show`, `Read`, `Ord`, `Enum` and `Bounded`.

#### Pairs, Tuples
Pairs are constructed like this `(a, b)`. `a` and `b` can be of different types.

Pairs with more than two elements are called tuples e.g. `tritupel = (1, "test", 's')`

#### Type variables
`sample :: (a, a) -> a`

#### Defining new data types
You can either define a whole new data Type

```haskell
data BookInfo = Book Int String [String]
				deriving (Show)
```
... or define type synonyms: 
`type name = String`

#### Pattern matching
- `first (x, _, _) = x`
- `capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]`

#### Guards

```haskell
max1 a b
	| a > b = a
	| otherwise = b
```
#### Where and let
`where` and `let` can be used with guards, whereas `where`s are visible for all guards and `let`...`in` are local for one guard.

#### Case & Errors

```haskell
head1 xs = case xs of [] -> error "No head for empty lists!"
					 (x:_) -> x
-- in general:
case expression of pattern -> result
                   pattern -> result
```

#### Lambda Notation

You can define functions with a lambda notation:
`identity = (\x -> (x, x))`

This allows casual function cascading, when you pass functions to functions (to functions...).

---

## 3. Recursion

---

## 4. Higher Order functions
#### Curry

```haskell
multiply a b = a * b
threefold = multiply 3
```
#### Folds
#### Zips

---
## 5. Monads

Monads connect functions which types can't be connected through ordinary composition.

- `(>>=) :: m a -> (a -> m b) -> m b` | connects like described above.
- `(>>) :: m a -> m b -> m b` | connects, but ignores the result of the first function
- `return :: a -> m a` | is the neutral element respective to `>>=`

#### Do Notation

---

## 6. Testing


---

## 7. Modules

----

## 8. Useful stuff

#### Language features
- `read "String"` equals rubys `eval()`, `show` is the opposite
- Comments come as `-- comment` or `{- comments -}`
- TODO Random

#### Links
- [haskell style guide](https://wiki.haskell.org/Programming_guidelines)
- [haskell report](https://www.haskell.org/definition/haskell2010.pdf)
- [Hayoo](http://hayoo.fh-wedel.de/)

## 9. What to do after finishing this
- [Cloud Haskell](https://wiki.haskell.org/Cloud_Haskell)
- [Elastic Search](https://github.com/elastic/elasticsearch)
- [ZeroMQ](http://zeromq.org/)

## 10. Learning To Do
- Rewrite some popular Monads
- Serialization
- Concurrency
