-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperiencePlaytestLaunchParent = script:FindFirstAncestor("BuildExperiencePlaytestLaunch").Parent

local Signals = require(BuildExperiencePlaytestLaunchParent.Signals)

local function createPlaytestLoadingStore()
    local tbl1 = ({})

    local function getLoadingSignal(num1: number)
        local tbl2 = tbl1[num1]
        if tbl2 == nil then
            local getAgentStatus, setAgentStatus = Signals.createSignal("Idle")
            local getPlaytestStatus, setPlaytestStatus = Signals.createSignal("Idle")

            tbl2 = {
                getAgentStatus = getAgentStatus,
                setAgentStatus = setAgentStatus,
                getPlaytestStatus = getPlaytestStatus,
                setPlaytestStatus = setPlaytestStatus,
                getStatus = Signals.createComputed(function(arg1): string
                    if getAgentStatus(arg1) == "Loading" or getPlaytestStatus(arg1) == "Loading" then
                        return "Loading"
                    end

                    if getAgentStatus(arg1) == "Completed" or getPlaytestStatus(arg1) == "Completed" then
                        return "Completed"
                    end

                    return "Idle"
                end),
                getIsPlaytestLoading = Signals.createComputed(function(arg1): boolean
                    return getPlaytestStatus(arg1) == "Loading"
                end)
            }

            tbl1[num1] = tbl2
        end
        return tbl2
    end

    return {
        getAgentStatusForPlaceId = function(num1: number)
            return getLoadingSignal(num1).getAgentStatus
        end,
        getPlaytestStatusForPlaceId = function(num1: number)
            return getLoadingSignal(num1).getPlaytestStatus
        end,
        getStatusForPlaceId = function(num1: number)
            return getLoadingSignal(num1).getStatus
        end,
        getIsPlaytestLoadingForPlaceId = function(num1: number)
            return getLoadingSignal(num1).getIsPlaytestLoading
        end,
        setAgentStatusForPlaceId = function(num1: number, str1: string)
            getLoadingSignal(num1).setAgentStatus(str1)
        end,
        setPlaytestStatusForPlaceId = function(num1: number, str1: string)
            getLoadingSignal(num1).setPlaytestStatus(str1)
        end,
        clearCompletedStatusForPlaceId = function(num1: number)
            local loadingSignal = getLoadingSignal(num1)
            if loadingSignal.getStatus() ~= "Completed" then
                return
            end

            loadingSignal.setAgentStatus("Idle")
            loadingSignal.setPlaytestStatus("Idle")
        end
    }
end
return createPlaytestLoadingStore
