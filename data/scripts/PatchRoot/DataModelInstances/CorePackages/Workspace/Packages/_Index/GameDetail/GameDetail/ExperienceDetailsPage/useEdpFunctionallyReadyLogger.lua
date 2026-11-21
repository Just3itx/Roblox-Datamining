-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local React = require(GameDetailParent.React)
local useSelector = require(GameDetailParent.RoactUtils).Hooks.RoactRodux.useSelector

local FetchGamePlayButtonData = require(GameDetailParent.GamePlayButton).FetchGamePlayButtonData

local _SduiSharedUtilities = require(GameDetailParent.SduiSharedUtilities)
local Milestone = require(GameDetailParent.TimeToInteractiveTracker).TimeToInteractiveTracker.Milestone

local PageGate = require(GameDetailParent.PageGate)

local FFlagEDPTTIParityDefinitions = require(GameDetailParent.SharedFlags).FFlagEDPTTIParityDefinitions

local function useEdpFunctionallyReadyLogger(str1: string?, str2: string?)
    local var1 = useSelector(function(arg1)
        if str2 then
            return FetchGamePlayButtonData.IsLoading(arg1, str2)
        end
        return true
    end)

    local var2 = if PageGate.FFlagEnablePLTPrefetchCallbacks then React.useRef(false) else nil

    React.useEffect(function()
        if var1 or not str2 or not str1.trackOnce then
            return
        end

        str1.trackOnce(Milestone.FunctionallyReady)
        if FFlagEDPTTIParityDefinitions then
            local markPlayButtonReady = str1.markPlayButtonReady
            if markPlayButtonReady then
                markPlayButtonReady()
            end
        end
        if PageGate.FFlagEnablePLTPrefetchCallbacks and var2 and not var2.current then
            var2.current = true
            PageGate.signal(PageGate.Page.ExperienceDetail, PageGate.Milestone.FunctionallyReady)
        end
    end, { var1, str2, str1 })
end

return useEdpFunctionallyReadyLogger
