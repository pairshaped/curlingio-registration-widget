module Helpers exposing (..)

import Types exposing (..)


showFilter : List Product -> Filter -> Bool
showFilter products filter =
    (List.isEmpty (filterProducts products filter)) /= True


filterProducts : List Product -> Filter -> List Product
filterProducts products filter =
    case filter of
        All ->
            products

        Bundles ->
            List.filter (\product -> product.registrationType == "league_bundle") products

        Leagues ->
            List.filter (\product -> product.registrationType == "direct_league") products

        Competitions ->
            List.filter (\product -> product.registrationType == "direct_competition") products

        Other ->
            List.filter (\product -> product.registrationType == "general") products
