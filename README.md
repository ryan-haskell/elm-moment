# elm-moment
> A reliable way to format dates with elm.


### Description

If you're coming from Javascript, you might have heard of [MomentJS](https://momentjs.com).

MomentJS is a great library for formatting dates!

`elm-moment` has the same [formatting options](https://momentjs.com/docs/#/displaying/format/) as Moment, but uses Elm's awesome type system to provide human-readable names, and catch typos for you at compile time!


### Example

```elm
import Date
import Moment

exampleFormatter : Date -> String
exampleFormatter =
    Moment.format
        [ Moment.MonthNameFull
        , Moment.PlainText " "
        , Moment.DayOfMonthSuffix
        , Moment.PlainText ", "
        , Moment.YearNumber
        ]

example : String
example =
    case Date.fromString "2018-02-05T00:00:00.000Z" of
        Ok date ->
            exampleFormatter date
        Err reason ->
            "Something went wrong: " ++ reason

```

Would make `example` return:

```
"February 5th, 2018" : String
```

### A work-in-progress!

__More documentation (and tests) coming soon!__