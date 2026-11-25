-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local AppComposition = require(ShareSheetParent.AppComposition)
local Display = require(ShareSheetParent.Display)
local Foundation = require(ShareSheetParent.Foundation)
local React = require(ShareSheetParent.React)
local Signals = require(ShareSheetParent.Signals)
local SignalsReact = require(ShareSheetParent.SignalsReact)

local getShareSheetRowLayout = require(script.Parent.getShareSheetRowLayout)

local useTokens = Foundation.Hooks.useTokens

local function useMeasuredRows()
    local var1 = useTokens()
    local var2 = SignalsReact.useSignalState(Display.GetDisplayStore().getDisplaySize)
    local var3 = React.useMemo(function()
        local get, set = Signals.createSignal(0)
        return { get = get, set = set }
    end, {})
    local var4 = SignalsReact.useSignalState(var3.get)
    local var5 = AppComposition.useCompositionLayout(var3.get)
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var3.set(arg1.AbsoluteSize.X)
    end, { var3 })

    return React.useMemo(function()
        return {
            isLayoutReady = var4 > 0,
            layout = getShareSheetRowLayout(var4, var5, var2, var1.Size.Size_1700),
            onAbsoluteSizeChanged = onAbsoluteSizeChanged
        }
    end, {
        var5,
        var2,
        var4,
        onAbsoluteSizeChanged,
        var1
    })
end
return useMeasuredRows
