-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ScriptProfilerService = game:GetService("ScriptProfilerService")

local module = {}
module.__index = module

function module.new(jsonString: string)
    local self = setmetatable({ _data = nil }, module)

    local success, result = pcall(function()
        return ScriptProfilerService:DeserializeJSON(jsonString)
    end)

    if success then
        self._data = result
    else
        warn("[ProfilerDataParser] Failed to deserialize JSON:", result)
    end

    return self
end

function module:getFunctionById(num1: number)
    if self._data then
        return self._data.Functions[num1]
    end

    return nil
end

function module:getNodeById(num1: number)
    local _data = self._data
    return if _data then _data.Nodes[num1] else nil
end

function module:getSessionDuration()
    local _data = self._data
    if not _data then
        return nil
    end
    local sessionStartTime = _data.SessionStartTime
    local sessionEndTime = _data.SessionEndTime
    return if sessionStartTime and sessionEndTime then sessionEndTime - sessionStartTime else nil
end

function module:getTotalFunctions(): number
    if self._data then
        return #self._data.Functions
    end

    return 0
end

function module:getTotalNodes(): number
    local _data = self._data
    return if _data then #_data.Nodes else 0
end

function module.parsePackageName(str1: string?)
    if not str1 or str1 == "" then
        return "Unknown"
    end

    local var1 = string.match(str1, "^CorePackages%.Packages%._Index%.([^%.%-]+)")
    if var1 then
        return var1
    end

    local var2 = string.match(str1, "^CorePackages%.Workspace%.Packages%._Workspace%.([^%.]+)")
    if var2 then
        return var2
    elseif string.match(str1, "^CoreGui%.RobloxGui") then
        return str1:match("^CoreGui%.RobloxGui%.(.*)")
    else
        if string.match(str1, "^Players%.") then
            if string.match(str1, "CameraModule") then
                return "CameraModule"
            end

            if string.match(str1, "ControlModule") then
                return "ControlModule"
            end

            return "Players"
        end

        return "Unknown"
    end
end

function module:getPackageStatistics()
    if not self._data then
        return {}
    end

    local packageStatistics = ({})
    for _, value in self._data.Categories do
        for _, child in self._data.Nodes[value.NodeId].Children do
            local var1 = self._data.Nodes[child]
            for k, _ in var1.Children do
                local var2 = tonumber(k)
                if var2 then
                    local _function = self._data.Functions[var2]
                    if _function then
                        local var3 = module.parsePackageName(_function.Source)
                        if var3 then
                            if not packageStatistics[var3] then
                                packageStatistics[var3] = { count = 0, totalDuration = 0 }
                            end
                            local packageStatistic = packageStatistics[var3]
                            packageStatistic.count += 1
                            local packageStatistic2 = packageStatistics[var3]
                            packageStatistic2.totalDuration += var1.TotalDuration
                        end
                    end
                end

                break
            end
        end
    end

    return packageStatistics
end

return module
