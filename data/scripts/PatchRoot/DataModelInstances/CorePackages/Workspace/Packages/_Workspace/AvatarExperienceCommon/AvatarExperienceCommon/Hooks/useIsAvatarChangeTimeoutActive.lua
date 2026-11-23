-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local React = require(AvatarExperienceCommonParent.React)
local useSignalState = require(AvatarExperienceCommonParent.SignalsReact).useSignalState

local getTimeoutStatusStore = require(AvatarExperienceCommon.Stores.TimeoutStatusStore.getTimeoutStatusStore)
local getTimeoutEndTime = require(AvatarExperienceCommon.Utils.getTimeoutEndTime)

local function getEndTimestampMillis(isoDate: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if not isoDate then
        return nil
    end

    local success, result = pcall(function(): DateTime
        return DateTime.fromIsoDate(isoDate)
    end)

    return if success and result then result.UnixTimestampMillis else nil
end

local function useIsAvatarChangeTimeoutActive(): boolean
    local timeoutStatusStore = getTimeoutStatusStore()
    local var1 = useSignalState(timeoutStatusStore.getStatus)

    local var2 = getTimeoutEndTime
    local endDate = if var1.details then var1.details.endDate else nil
    local endTime = if var1.timeoutAction then var1.timeoutAction.endTime else nil
    local endTimestampMillis = getEndTimestampMillis((var2(endDate, endTime)))

    local bool1 = endTimestampMillis == nil or DateTime.now().UnixTimestampMillis < endTimestampMillis
    local var3, var4 = React.useState(0)

    React.useEffect(function()
        if not bool1 or endTimestampMillis == nil then
            return nil
        end

        local var5 = task.delay((endTimestampMillis - DateTime.now().UnixTimestampMillis) / 1000, function()
            var4(function(arg1): number
                return arg1 + 1
            end)
        end)

        return function()
            task.cancel(var5)
        end
    end, { endTimestampMillis, bool1, var3 })

    return bool1
end

return useIsAvatarChangeTimeoutActive
