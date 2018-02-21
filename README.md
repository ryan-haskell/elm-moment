# elm-moment
> A reliable way to format dates with elm.

### Using the [elm package](http://package.elm-lang.org/packages/ryannhg/elm-moment/latest)

```
elm package install ryannhg/elm-moment
```


### What is `elm-moment`?

If you're coming from Javascript, you might have heard of [MomentJS](https://momentjs.com).

MomentJS is a great library for formatting dates!

`elm-moment` has the same [formatting options](https://momentjs.com/docs/#/displaying/format/) as Moment, but uses Elm's awesome type system to provide human readable names, and catch typos for you at compile time!

No need to remember the difference between `mm` and `MM` and `M`!


### A quick example

```elm
import Date
import Moment


-- Create a custom formatter

yourFormatter : Date -> String
yourFormatter =
    Moment.format
        [ Moment.MonthNameFull
        , Moment.Text " "
        , Moment.DayOfMonthSuffix
        , Moment.Text ", "
        , Moment.YearNumber
        ]


-- Using your formatter, format your date as a string!

yourPrettyDate : String
yourPrettyDate =
    case Date.fromString "2018-02-05T00:00:00.000Z" of
        Ok date ->
            yourFormatter date

        Err ->
            "This shouldn't happen..."

```

Would make `yourPrettyDate` return:

```
"February 5th, 2018" : String
```
