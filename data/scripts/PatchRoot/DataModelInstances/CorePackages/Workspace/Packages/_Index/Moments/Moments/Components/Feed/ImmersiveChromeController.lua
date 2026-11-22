-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local _Signals = require(MomentsParent.Signals)
local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)

local _FeedTypes = require(script.Parent.FeedTypes)
local useImmersiveChrome = require(script.Parent.useImmersiveChrome)
local usePreferredInput = require(Moments.Hooks.usePreferredInput)
local _VerticalPager = require(Moments.Components.VerticalPager)

local MediaPreloadProvider = MomentsCommon.Media.MediaPreloadProvider
local useFormFactor = MomentsCommon.Hooks.useFormFactor
local FormFactor = MomentsCommon.Enums.FormFactor
local usePreferences = Foundation.Hooks.usePreferences

local function ImmersiveChromeController(tbl1)
    local pager = tbl1.pager
    local var1 = MediaPreloadProvider.useMediaControllerProvider()
    local var2 = usePreferredInput()
    local var3 = useFormFactor()
    local reducedMotion = usePreferences().reducedMotion
    local inputAllowed = var2 == Enum.PreferredInput.Touch and var3 == FormFactor.MobilePortrait

    local getActiveIsPlaying = React.useMemo(function()
        return function(arg1)
            if var1 == nil then
                return true
            end
            local currentItem = pager.getCurrentItem(arg1)
            if currentItem == nil or currentItem.kind ~= "moment" then
                return true
            end
            local momentId = currentItem.moment.momentId
            local var4 = var1.getControllerMap(arg1)[momentId]
            return var4 == nil or var4.getState(arg1).isPlaying
        end
    end, { pager, var1 })

    local getIsScrolling = React.useMemo(function()
        return function(arg1): boolean
            local current = tbl1.controllerRef.current
            return not (current == nil) and current.getScrollState(arg1) ~= "Idle"
        end
    end, { tbl1.controllerRef })

    useImmersiveChrome({
        pager = pager,
        active = tbl1.active,
        getActiveIsPlaying = getActiveIsPlaying,
        getIsScrolling = getIsScrolling,
        inputAllowed = inputAllowed,
        reducedMotion = reducedMotion,
        coveringOverlay = tbl1.coveringOverlay
    })

    return nil
end

return ImmersiveChromeController
