-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local usePostInsightsCoachmarkViewModel = require(script.Parent.usePostInsightsCoachmarkViewModel)

local function PostInsightsCoachmark(arg1)
    local var1 = usePostInsightsCoachmarkViewModel(arg1)

    if not var1.shouldMount then
        return arg1.children
    end

    local persistentCoachmark = require(MomentsParent.MomentsCommon.PersistentCoachmark)

    return React.createElement(persistentCoachmark, {
        title = var1.title,
        text = var1.text,
        impressionCache = var1.impressionCache,
        maxImpressions = var1.maxImpressions,
        autoDismissSeconds = var1.autoDismissSeconds,
        isSessionHandled = var1.isSessionHandled,
        onSessionHandled = var1.onSessionHandled,
        onImpression = var1.onImpression,
        onDismissed = var1.onDismissed,
        hidden = var1.hidden,
        side = Foundation.Enums.PopoverSide.Left,
        align = Foundation.Enums.PopoverAlign.Center
    }, arg1.children)
end

return PostInsightsCoachmark
