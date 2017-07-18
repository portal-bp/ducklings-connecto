-- Copyright (c) 2016-present, Facebook, Inc.
-- All rights reserved.
--
-- This source code is licensed under the BSD-style license found in the
-- LICENSE file in the root directory of this source tree. An additional grant
-- of patent rights can be found in the PATENTS file in the same directory.


{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}

module Duckling.Temperature.Rules
  ( rules
  ) where

import Data.String
import Prelude

import Duckling.Dimensions.Types
import qualified Duckling.Numeral.Types as TNumeral
import Duckling.Temperature.Types (TemperatureData (..))
import qualified Duckling.Temperature.Types as TTemperature
import Duckling.Types

ruleNumeralAsTemp :: Rule
ruleNumeralAsTemp = Rule
  { name = "number as temp"
  , pattern =
    [ dimension Numeral
    ]
  , prod = \tokens -> case tokens of
      (Token Numeral nd:_) ->
        Just . Token Temperature $ TemperatureData
          { TTemperature.unit = Nothing
          , TTemperature.value = floor $ TNumeral.value nd
          }
      _ -> Nothing
  }

rules :: [Rule]
rules =
  [ ruleNumeralAsTemp
  ]
