-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local Loading = Foundation.Loading
local View = Foundation.View

local function LibraryLeavingOverlay(tbl1)
    local var1 = Foundation.Hooks.useTokens()
    return React.createElement(View, {
        ZIndex = tbl1.ZIndex,
        backgroundStyle = var1.Color.Common.Backdrop,
        onActivated = function() end,
        selection = { Selectable = false },
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = "size-full row align-x-center align-y-center",
        testId = "Library.Leaving"
    }, {
        Spinner = React.createElement(Loading, {})
    })
end

return LibraryLeavingOverlay
