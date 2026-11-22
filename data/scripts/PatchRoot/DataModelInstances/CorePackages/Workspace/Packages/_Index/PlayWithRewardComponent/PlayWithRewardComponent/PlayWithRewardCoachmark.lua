-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayWithRewardComponent = script:FindFirstAncestor("PlayWithRewardComponent")
local PlayWithRewardComponentParent = PlayWithRewardComponent.Parent

local Foundation = require(PlayWithRewardComponentParent.Foundation)
local Navigation = require(PlayWithRewardComponentParent.Navigation)
local React = require(PlayWithRewardComponentParent.React)
local RoactUtils = require(PlayWithRewardComponentParent.RoactUtils)
local SharedFlags = require(PlayWithRewardComponentParent.SharedFlags)

local PlayWithRewardCoachmarkStorage = require(PlayWithRewardComponent.PlayWithRewardCoachmarkStorage)
local PlayWithRewardTelemetry = require(PlayWithRewardComponent.PlayWithRewardTelemetry)

local useEarlyIsFocused = Navigation.useEarlyIsFocused
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local Coachmark = Foundation.Coachmark
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide

local FFlagPlayWithRewardCoachmarkOverlayFix = SharedFlags.FFlagPlayWithRewardCoachmarkOverlayFix

return React.memo(function(tbl1) -- name: PlayWithRewardCoachmark
    local isOpen, var2 = React.useState(false)
    local var3 = nil
    local var4 = nil
    if FFlagPlayWithRewardCoachmarkOverlayFix then
        var3 = useEarlyIsFocused()
        var4 = useSelector(function(arg1): boolean
            return arg1.CentralOverlay.OverlayType ~= nil
        end)
    end

    React.useEffect(function()
        var2(false)

        if tbl1.localUserId <= 0 then
            return
        end

        if PlayWithRewardCoachmarkStorage.consumeImpressionIfEligible(tbl1.localUserId) then
            var2(true)
            PlayWithRewardTelemetry.logPlayWithRewardCoachmark("shown", tbl1.flowId, tbl1.universeId, tbl1.productId)
        end
    end, {
        tbl1.flowId,
        tbl1.localUserId,
        tbl1.productId,
        tbl1.universeId
    })
    if FFlagPlayWithRewardCoachmarkOverlayFix then
        React.useEffect(function()
            if not var3 or var4 then
                var2(false)
            end
        end, { var3, var4 })
    end

    local onClose = React.useCallback(function()
        PlayWithRewardCoachmarkStorage.dismissCurrentWindow(tbl1.localUserId)
        PlayWithRewardTelemetry.logPlayWithRewardCoachmark("dismissed", tbl1.flowId, tbl1.universeId, tbl1.productId)
        var2(false)
    end, {
        tbl1.flowId,
        tbl1.universeId,
        tbl1.productId,
        tbl1.localUserId
    })
    return React.createElement(Coachmark, {
        title = tbl1.title,
        text = tbl1.text,
        isOpen = isOpen,
        side = PopoverSide.Bottom,
        align = PopoverAlign.Center,
        anchorRef = tbl1.anchorRef,
        onClose = onClose
    })
end)
