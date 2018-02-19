module Moment exposing (Token(..), format)

import Date exposing (Date, Month(..), Day(..))


type Token
    = MonthNumber
    | MonthSuffix
    | MonthFixed
    | MonthNameShort
    | MonthNameFull
    | QuarterNumber
    | QuarterSuffix
    | DayOfMonthNumber
    | DayOfMonthSuffix
    | DayOfMonthFixed
    | DayOfYearNumber
    | DayOfYearSuffix
    | DayOfYearFixed
    | DayOfWeekNumber
    | DayOfWeekSuffix
    | DayOfWeekNameFirstTwo
    | DayOfWeekNameFirstThree
    | DayOfWeekNameFull
    | DayOfWeekLocale
    | DayOfWeekIso
    | WeekOfYearNumber
    | WeekOfYearSuffix
    | WeekOfYearFixed
    | WeekOfYearIsoNumber
    | WeekOfYearIsoSuffix
    | WeekOfYearIsoFixed
    | YearNumberLastTwo
    | YearNumberCapped
    | YearNumber
    | WeekYearNumberLastTwo
    | WeekYearNumberCapped
    | WeekYearIsoNumberLastTwo
    | WeekYearIsoNumberCapped
    | AmPmUppercase
    | AmPmLowercase
    | HourMilitaryNumber
    | HourMilitaryFixed
    | HourNumber
    | HourFixed
    | HourMilitaryFromOneNumber
    | HourMilitaryFromOneFixed
    | MinuteNumber
    | MinuteFixed
    | SecondNumber
    | SecondFixed
    | PlainText String



-- | FractionalSecond Int
-- | UnixTimestamp
-- | UnixMillisecondTimestamp
-- | PlainText String


months : List Month
months =
    [ Jan
    , Feb
    , Mar
    , Apr
    , May
    , Jun
    , Jul
    , Aug
    , Sep
    , Nov
    , Dec
    ]


days : List Day
days =
    [ Sun
    , Mon
    , Tue
    , Wed
    , Thu
    , Fri
    , Sat
    ]


type alias TokenPair =
    ( Token, String )


tokenPairs : List TokenPair
tokenPairs =
    [ ( MonthNumber, "M" )
    , ( MonthSuffix, "Mo" )
    , ( MonthFixed, "MM" )
    , ( MonthNameShort, "MMM" )
    , ( MonthNameFull, "MMMM" )
    ]


getToken : String -> Maybe Token
getToken str =
    tokenPairs
        |> List.filter (\( _, s ) -> s == str)
        |> List.map (\( t, _ ) -> t)
        |> List.head


format : List Token -> Date -> String
format tokens date =
    tokens
        |> List.map (piece date)
        |> String.join ""


piece : Date -> Token -> String
piece date token =
    case token of
        MonthNumber ->
            monthNumber date
                |> toString

        MonthSuffix ->
            monthNumber date
                |> toSuffix

        MonthFixed ->
            monthNumber date
                |> toFixedLength

        MonthNameShort ->
            Date.month date
                |> toString

        MonthNameFull ->
            fullMonthName date

        QuarterNumber ->
            quarter date
                |> toString

        QuarterSuffix ->
            quarter date
                |> toSuffix

        DayOfMonthNumber ->
            dayOfMonth date
                |> toString

        DayOfMonthSuffix ->
            dayOfMonth date
                |> toSuffix

        DayOfMonthFixed ->
            dayOfMonth date
                |> toFixedLength

        DayOfYearNumber ->
            dayOfYear date
                |> toString

        DayOfYearSuffix ->
            dayOfYear date
                |> toSuffix

        DayOfYearFixed ->
            dayOfYear date
                |> toFixedLength

        DayOfWeekNumber ->
            dayOfWeek date
                |> toString

        DayOfWeekSuffix ->
            dayOfWeek date
                |> toSuffix

        DayOfWeekNameFirstTwo ->
            dayOfWeekName date
                |> String.left 2

        DayOfWeekNameFirstThree ->
            dayOfWeekName date
                |> String.left 3

        DayOfWeekNameFull ->
            dayOfWeekName date

        DayOfWeekLocale ->
            dayOfWeek date
                |> toString

        DayOfWeekIso ->
            dayOfWeek date
                |> (+) 1
                |> toString

        WeekOfYearNumber ->
            weekOfYear date
                |> toString

        WeekOfYearSuffix ->
            weekOfYear date
                |> toSuffix

        WeekOfYearFixed ->
            weekOfYear date
                |> toFixedLength

        WeekOfYearIsoNumber ->
            weekOfYear date
                |> toString

        WeekOfYearIsoSuffix ->
            weekOfYear date
                |> toSuffix

        WeekOfYearIsoFixed ->
            weekOfYear date
                |> toFixedLength

        YearNumberLastTwo ->
            year date
                |> String.right 2

        YearNumberCapped ->
            year date

        YearNumber ->
            year date

        WeekYearNumberLastTwo ->
            year date
                |> String.right 2

        WeekYearNumberCapped ->
            year date

        WeekYearIsoNumberLastTwo ->
            year date
                |> String.right 2

        WeekYearIsoNumberCapped ->
            year date

        AmPmUppercase ->
            amPm date
                |> String.toUpper

        AmPmLowercase ->
            amPm date
                |> String.toLower

        HourMilitaryNumber ->
            Date.hour date
                |> toString

        HourMilitaryFixed ->
            Date.hour date
                |> toFixedLength

        HourNumber ->
            Date.hour date
                |> toNonMilitary
                |> toString

        HourFixed ->
            Date.hour date
                |> toNonMilitary
                |> toFixedLength

        HourMilitaryFromOneNumber ->
            Date.hour date
                |> (+) 1
                |> toString

        HourMilitaryFromOneFixed ->
            Date.hour date
                |> (+) 1
                |> toFixedLength

        MinuteNumber ->
            Date.minute date
                |> toString

        MinuteFixed ->
            Date.minute date
                |> toFixedLength

        SecondNumber ->
            Date.second date
                |> toString

        SecondFixed ->
            Date.second date
                |> toFixedLength

        PlainText string ->
            string



-- | FractionalSecond Int
-- | UnixTimestamp
-- | UnixMillisecondTimestamp
-- | PlainText String
-- MONTHS


monthPair : Date -> ( Int, Month )
monthPair date =
    months
        |> List.indexedMap (,)
        |> List.filter (\( i, m ) -> m == Date.month date)
        |> List.head
        |> Maybe.withDefault ( 0, Jan )


monthNumber : Date -> Int
monthNumber date =
    monthPair date
        |> (\( i, m ) -> i)


fullMonthName : Date -> String
fullMonthName date =
    case Date.month date of
        Jan ->
            "January"

        Feb ->
            "February"

        Mar ->
            "March"

        Apr ->
            "April"

        May ->
            "May"

        Jun ->
            "June"

        Jul ->
            "July"

        Aug ->
            "August"

        Sep ->
            "September"

        Oct ->
            "October"

        Nov ->
            "November"

        Dec ->
            "December"


daysInMonth : Int -> Month -> Int
daysInMonth year month =
    case month of
        Jan ->
            31

        Feb ->
            if year % 4 == 0 then
                29
            else
                28

        Mar ->
            31

        Apr ->
            30

        May ->
            31

        Jun ->
            30

        Jul ->
            31

        Aug ->
            31

        Sep ->
            30

        Oct ->
            31

        Nov ->
            30

        Dec ->
            31



-- QUARTERS


quarter : Date -> Int
quarter date =
    (monthNumber date) // 4



-- DAY OF MONTH


dayOfMonth : Date -> Int
dayOfMonth =
    Date.day



-- DAY OF YEAR


dayOfYear : Date -> Int
dayOfYear date =
    let
        monthsBeforeThisOne : List Month
        monthsBeforeThisOne =
            List.take (monthNumber date) months

        daysBeforeThisMonth : Int
        daysBeforeThisMonth =
            monthsBeforeThisOne
                |> List.map (daysInMonth (Date.year date))
                |> List.sum
    in
        daysBeforeThisMonth + (dayOfMonth date)



-- DAY OF WEEK


dayOfWeek : Date -> Int
dayOfWeek date =
    days
        |> List.indexedMap (,)
        |> List.filter (\( _, d ) -> d == Date.dayOfWeek date)
        |> List.head
        |> Maybe.withDefault ( 0, Sun )
        |> (\( i, d ) -> i)


dayOfWeekName : Date -> String
dayOfWeekName date =
    case Date.dayOfWeek date of
        Mon ->
            "Monday"

        Tue ->
            "Tuesday"

        Wed ->
            "Wednesday"

        Thu ->
            "Thursday"

        Fri ->
            "Friday"

        Sat ->
            "Saturday"

        Sun ->
            "Sunday"



-- WEEK OF YEAR


type alias SimpleDate =
    { month : Month
    , day : Int
    , year : Int
    }


weekOfYear : Date -> Int
weekOfYear date =
    let
        daysSoFar : Int
        daysSoFar =
            dayOfYear date

        firstDay : Date
        firstDay =
            firstDayOfYear date

        firstDayOffset : Int
        firstDayOffset =
            dayOfWeek firstDay
    in
        (daysSoFar + firstDayOffset) // 7 + 1


firstDayOfYear : Date -> Date
firstDayOfYear date =
    case Date.fromString <| (toString (Date.year date)) ++ "-01-01T00:00:00.000Z" of
        Ok date ->
            date

        Err _ ->
            date



-- YEAR


year : Date -> String
year date =
    date
        |> Date.year
        |> toString



-- AM / PM


amPm : Date -> String
amPm date =
    if Date.hour date > 11 then
        "pm"
    else
        "am"



-- HOUR


toNonMilitary : Int -> Int
toNonMilitary num =
    if num == 0 then
        12
    else if num < 12 then
        num
    else
        num - 12



-- GENERIC


toFixedLength : Int -> String
toFixedLength num =
    if num < 10 then
        "0" ++ (toString num)
    else
        toString num


toSuffix : Int -> String
toSuffix num =
    let
        suffix =
            case num % 10 of
                1 ->
                    "st"

                2 ->
                    "nd"

                3 ->
                    "rd"

                _ ->
                    "th"
    in
        (toString num) ++ suffix
