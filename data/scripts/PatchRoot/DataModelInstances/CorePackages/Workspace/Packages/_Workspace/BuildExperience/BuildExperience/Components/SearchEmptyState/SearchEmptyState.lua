-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local FoundationCloudAssets = require(BuildExperienceParent.FoundationCloudAssets)
local React = require(BuildExperienceParent.React)

local Image = Foundation.Image
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

local Assets = FoundationCloudAssets.Assets
FoundationCloudAssets.preloadAsset("pictograms/find_people")
local var1 = Assets["pictograms/find_people"] or {}

local function SearchEmptyState(tbl1)
    local var2 = useTokens()
    local testId = tbl1.testId or "SearchEmptyState"

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "col align-x-center align-y-center size-full",
            testId = testId
        },
        {
            Image = React.createElement(Image, {
                Image = var1.assetId,
                imageStyle = var2.Color.Content.Emphasis,
                ScaleType = Enum.ScaleType.Fit,
                Size = UDim2.fromOffset(320 * var2.Config.UI.Scale, 180 * var2.Config.UI.Scale),
                testId = `{testId}.Image`
            })
        }
    )
end
return SearchEmptyState
