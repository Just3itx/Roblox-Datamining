-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local Roact = require(AvatarExperienceAnalyticsParent.Roact)
local RoactRodux = require(AvatarExperienceAnalyticsParent.RoactRodux)
local t = require(AvatarExperienceAnalyticsParent.t)
local Cryo = require(AvatarExperienceAnalyticsParent.Cryo)
local SignalsReact = require(AvatarExperienceAnalyticsParent.SignalsReact)
local GetShortcutBarStatusStore = require(AvatarExperienceAnalyticsParent.AppShortcutBarStore).GetShortcutBarStatusStore
local FFlagUnifyShortcutBarFixImpressions = require(AvatarExperienceAnalyticsParent.SharedFlags).FFlagUnifyShortcutBarFixImpressions

local AvatarExperienceImpressionsDetector = require(script.Parent.AvatarExperienceImpressionsDetector)

local var1 = Roact.PureComponent:extend("AvatarExperienceScreenSizeImpressionsDetector")

var1.validateProps = t.strictInterface({
    parentRef = t.table,
    onRequestImpressionsSignal = t.table,
    appPage = t.optional(t.string),
    pageFilter = t.optional(t.callback),
    collectObjectsFunc = t.optional(t.callback),
    filterImpressionFunc = t.optional(t.callback),
    onImpressionsDetected = t.callback,
    screenSize = t.Vector2,
    globalGuiInset = t.table,
    topBarHeight = t.number,
    shortcutBarHeight = if FFlagUnifyShortcutBarFixImpressions then t.optional(t.number) else nil
})

function var1.render(arg1)
    local screenSize = arg1.props.screenSize
    local topBarHeight = arg1.props.topBarHeight
    local globalGuiInset = arg1.props.globalGuiInset
    local shortcutBarHeight = FFlagUnifyShortcutBarFixImpressions and arg1.props.shortcutBarHeight or 0

    return Roact.createElement(AvatarExperienceImpressionsDetector, {
        parentRef = arg1.props.parentRef,
        onRequestImpressionsSignal = arg1.props.onRequestImpressionsSignal,
        viewPortBounds = {
            min = Vector2.new(0, topBarHeight),
            max = Vector2.new(screenSize.X, screenSize.Y - globalGuiInset.bottom - shortcutBarHeight)
        },
        appPage = arg1.props.appPage,
        pageFilter = arg1.props.pageFilter,
        collectObjectsFunc = arg1.props.collectObjectsFunc,
        filterImpressionFunc = arg1.props.filterImpressionFunc,
        onImpressionsDetected = arg1.props.onImpressionsDetected
    })
end

local var2 = RoactRodux.connect(function(arg1, _)
    return {
        topBarHeight = arg1.TopBar.topBarHeight,
        globalGuiInset = arg1.GlobalGuiInset,
        screenSize = arg1.ScreenSize
    }
end)(var1)

if not FFlagUnifyShortcutBarFixImpressions then
    return var2
end

return function(arg1)
    local shortcutBarHeight = SignalsReact.useSignalState(GetShortcutBarStatusStore(false).getShortcutBarReservedHeight)

    return Roact.createElement(var2, Cryo.Dictionary.join(arg1, { shortcutBarHeight = shortcutBarHeight }))
end
