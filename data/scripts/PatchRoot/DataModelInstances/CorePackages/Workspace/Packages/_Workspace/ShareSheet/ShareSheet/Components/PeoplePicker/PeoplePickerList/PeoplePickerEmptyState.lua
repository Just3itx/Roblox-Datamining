-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local Foundation = require(ShareSheetParent.Foundation)
local FoundationCloudAssets = require(ShareSheetParent.FoundationCloudAssets)
local React = require(ShareSheetParent.React)

local Image = Foundation.Image
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local Assets = FoundationCloudAssets.Assets
FoundationCloudAssets.preloadAsset("pictograms/find_people")
local var1 = Assets["pictograms/find_people"] or {}

local function PeoplePickerEmptyState(tbl1)
    local var2 = useTokens()
    local testId = tbl1.testId or "people-picker-empty-state"

    return React.createElement(View, {
        tag = "col align-x-center size-full-0 auto-y padding-y-large",
        testId = testId
    }, {
        Image = React.createElement(Image, {
            Image = var1.assetId,
            imageStyle = var2.Color.Content.Emphasis,
            ScaleType = Enum.ScaleType.Fit,
            Size = UDim2.fromOffset(320 * var2.Config.UI.Scale, 180 * var2.Config.UI.Scale),
            testId = `{testId}--image`
        })
    })
end

return PeoplePickerEmptyState
