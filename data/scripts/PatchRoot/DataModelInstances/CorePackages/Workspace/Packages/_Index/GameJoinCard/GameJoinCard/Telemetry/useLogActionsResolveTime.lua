-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:00:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local React = require(GameJoinCardParent.React)
local DataHydration = require(GameJoinCardParent.DataHydration)
local FFlagJoinabilityCTARefactor = require(GameJoinCardParent.SharedFlags).FFlagJoinabilityCTARefactor

local DataStatus = DataHydration.DataStatus
local GameJoinCardTelemetry = require(script.Parent.GameJoinCardTelemetry)

local function useLogActionsResolveTime(str1: string?, bool1: boolean, str2: string)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(false)

    React.useEffect(function()
        if not (FFlagJoinabilityCTARefactor and bool1) then
            var1.current = nil
            var2.current = false
            return
        end

        if str1 == DataStatus.NotReady then
            if var1.current == nil or var2.current then
                var1.current = tick()
                var2.current = false
            end
        elseif not var2.current and var1.current ~= nil and (str1 == DataStatus.Ready or str1 == DataStatus.Failed) then
            var2.current = true
            GameJoinCardTelemetry.logActionsResolved((tick() - var1.current) * 1000, str1, str2)
        end
    end, { str1, bool1, str2 })
end

return useLogActionsResolveTime
