-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagBuildAdUpsell = require(script.Parent.FFlagBuildAdUpsell)
local FFlagEnableBuildAdPromotion = require(script.Parent.FFlagEnableBuildAdPromotion)

return game:DefineFastFlag("EnablePaidAds4", false) and FFlagBuildAdUpsell and FFlagEnableBuildAdPromotion
