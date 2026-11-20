-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppPageShell = script:FindFirstAncestor("AppPageShell")
local AppPageShellParent = AppPageShell.Parent

local AppCommonLib = require(AppPageShellParent.AppCommonLib)
local Signals = require(AppPageShellParent.Signals)

local _createPageScrollStore = require(AppPageShell.createPageScrollStore)

local function createFeedContextAdapter(arg1, verticalScrollingFrameRef)
    local signal = AppCommonLib.Signal.new()

    local effect = Signals.createEffect(function(arg2)
        arg1.getCanvasPosition(arg2)
        arg1.getContentHeight(arg2)
        signal:fire()
    end)

    return {
        scrollViewPositionChangedSignal = signal,
        verticalScrollingFrameRef = verticalScrollingFrameRef,
        destroy = function()
            effect()
        end
    }
end

return createFeedContextAdapter
