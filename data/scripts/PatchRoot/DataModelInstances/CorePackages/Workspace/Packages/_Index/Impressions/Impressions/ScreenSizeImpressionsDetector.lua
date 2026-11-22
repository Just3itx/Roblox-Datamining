-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ImpressionsParent = script:FindFirstAncestor("Impressions").Parent

local Roact = require(ImpressionsParent.Roact)
local RoactRodux = require(ImpressionsParent.RoactRodux)
local t = require(ImpressionsParent.t)
local memoize = require(ImpressionsParent.AppCommonLib).memoize
local Cryo = require(ImpressionsParent.Cryo)
local SignalsReact = require(ImpressionsParent.SignalsReact)
local GetShortcutBarStatusStore = require(ImpressionsParent.AppShortcutBarStore).GetShortcutBarStatusStore
local FFlagUnifyShortcutBarFixImpressions = require(ImpressionsParent.SharedFlags).FFlagUnifyShortcutBarFixImpressions

local ImpressionsDetector = require(script.Parent.ImpressionsDetector)

local var1 = Roact.PureComponent:extend("ScreenSizeImpressionsDetector")

var1.validateProps = t.strictInterface({
    impressionsTag = t.string,
    parentRef = t.optional(t.table),
    onRequestImpressionsSignal = t.table,
    filterImpressionFunc = t.optional(t.callback),
    onImpressionsDetected = t.callback,
    skipZeroSizes = t.optional(t.boolean),
    screenSize = t.Vector2,
    globalGuiInset = t.table,
    topBarHeight = t.number,
    shortcutBarHeight = if FFlagUnifyShortcutBarFixImpressions then t.optional(t.number) else nil
})

local var2 = memoize(function(y: number?, vector2: Vector2, arg1, num1: number?)
    return {
        min = Vector2.new(0, y),
        max = Vector2.new(vector2.X, vector2.Y - arg1.bottom - (FFlagUnifyShortcutBarFixImpressions and num1 or 0))
    }
end)

function var1.render(arg1)
    local screenSize = arg1.props.screenSize
    local topBarHeight = arg1.props.topBarHeight
    local globalGuiInset = arg1.props.globalGuiInset

    return Roact.createElement(ImpressionsDetector, {
        parentRef = arg1.props.parentRef,
        impressionsTag = arg1.props.impressionsTag,
        onRequestImpressionsSignal = arg1.props.onRequestImpressionsSignal,
        viewPortBounds = var2(
            topBarHeight,
            screenSize,
            globalGuiInset,
            if FFlagUnifyShortcutBarFixImpressions then arg1.props.shortcutBarHeight else nil
        ),
        filterImpressionFunc = arg1.props.filterImpressionFunc,
        onImpressionsDetected = arg1.props.onImpressionsDetected,
        skipZeroSizes = arg1.props.skipZeroSizes
    })
end

local var3 = RoactRodux.connect(function(arg1, _)
    return {
        topBarHeight = arg1.TopBar.topBarHeight,
        globalGuiInset = arg1.GlobalGuiInset,
        screenSize = arg1.ScreenSize
    }
end)(var1)

if not FFlagUnifyShortcutBarFixImpressions then
    return var3
end

return function(arg1)
    local shortcutBarHeight = SignalsReact.useSignalState(GetShortcutBarStatusStore(false).getShortcutBarReservedHeight)

    return Roact.createElement(var3, Cryo.Dictionary.join(arg1, { shortcutBarHeight = shortcutBarHeight }))
end
