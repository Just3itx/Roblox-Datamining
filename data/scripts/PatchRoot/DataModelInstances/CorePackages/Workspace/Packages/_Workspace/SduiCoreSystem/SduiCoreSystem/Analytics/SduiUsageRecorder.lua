-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local SduiUsageAnalytics = require(SduiCoreSystem.Analytics.SduiUsageAnalytics)

local num1 = game:DefineFastInt("DiscoverySduiTypeUsageHundredthsPercent", 0)
local num2 = game:DefineFastInt("DiscoverySduiParamUsageHundredthsPercent", 0)

local isTypeSamplingEnabled = math.random(10000) <= num1
local isParamSamplingEnabled = math.random(10000) <= num2

local tbl1 = ({})

local tbl2 = ({})

local function getOrCreateAccumulator(str1: string, str2: string)
    local tbl3 = tbl1[str1]
    if not tbl3 then
        tbl3 = {}
        tbl1[str1] = tbl3
    end
    local var1 = tbl3[str2]
    if var1 then
        return var1
    end
    local tbl4 = {
        types = {},
        props = {},
        actionTypes = {},
        actionParams = {},
        hasRecorded = false
    }

    tbl3[str2] = tbl4
    return tbl4
end

local function getOrCreateGlobalSeen(page: string, version: string)
    local tbl3 = tbl2[page]
    if not tbl3 then
        tbl3 = {}
        tbl2[page] = tbl3
    end
    local var1 = tbl3[version]
    if var1 then
        return var1
    end
    local tbl4 = {
        types = {},
        props = {},
        actionTypes = {},
        actionParams = {}
    }
    tbl3[version] = tbl4
    return tbl4
end

local function deltaAndCommit(tbl3, tbl4)
    local result = ({})
    for value, _ in tbl3 do
        if not tbl4[value] then
            result[value] = true
            tbl4[value] = true
        end
    end
    return result
end

local function recordComponentType(str1: string, str2: string, str3: string?)
    if not (isTypeSamplingEnabled and str3) then
        return
    end
    local orCreateAccumulator = getOrCreateAccumulator(str1, str2)
    if not orCreateAccumulator.types[str3] then
        orCreateAccumulator.types[str3] = true
        orCreateAccumulator.hasRecorded = true
    end
end

local function recordProp(str1: string, str2: string, str3: string?, str4: string?)
    if not (isParamSamplingEnabled and str3 and str4) then
        return
    end
    local orCreateAccumulator = getOrCreateAccumulator(str1, str2)
    local str5 = `{str3}.{str4}`
    if not orCreateAccumulator.props[str5] then
        orCreateAccumulator.props[str5] = true
        orCreateAccumulator.hasRecorded = true
    end
end

local function recordActionType(str1: string, str2: string, str3: string?)
    if not (isTypeSamplingEnabled and str3) then
        return
    end
    local orCreateAccumulator = getOrCreateAccumulator(str1, str2)
    if not orCreateAccumulator.actionTypes[str3] then
        orCreateAccumulator.actionTypes[str3] = true
        orCreateAccumulator.hasRecorded = true
    end
end

local function recordActionParam(str1: string, str2: string, str3: string?, str4: string?)
    if not (isParamSamplingEnabled and str3 and str4) then
        return
    end
    local orCreateAccumulator = getOrCreateAccumulator(str1, str2)
    local str5 = `{str3}.{str4}`
    if not orCreateAccumulator.actionParams[str5] then
        orCreateAccumulator.actionParams[str5] = true
        orCreateAccumulator.hasRecorded = true
    end
end

local function flushPageVersion(page: string, version: string)
    local var1 = tbl1[page]
    local var2 = var1 and var1[version]
    if not (var2 and var2.hasRecorded) then
        return
    end

    local orCreateGlobalSeen = getOrCreateGlobalSeen(page, version)
    local componentTypes = deltaAndCommit(var2.types, orCreateGlobalSeen.types)
    local props = deltaAndCommit(var2.props, orCreateGlobalSeen.props)
    local actionTypes = deltaAndCommit(var2.actionTypes, orCreateGlobalSeen.actionTypes)
    local actionParams = deltaAndCommit(var2.actionParams, orCreateGlobalSeen.actionParams)

    var1[version] = nil
    if next(var1) == nil then
        tbl1[page] = nil
    end

    if next(componentTypes) ~= nil or next(actionTypes) ~= nil then
        SduiUsageAnalytics.sendTypeUsageEvent(
            {
                page = page,
                version = version,
                componentTypes = componentTypes,
                actionTypes = actionTypes
            }
        )
    end
    if next(props) == nil and next(actionParams) == nil then
        return
    end

    SduiUsageAnalytics.sendParamUsageEvent({ page = page, version = version, props = props, actionParams = actionParams })
end

local function flushAll()
    local tbl3 = {}
    for page, value2 in tbl1 do
        for version, _ in value2 do
            table.insert(tbl3, { page = page, version = version })
        end
    end
    for _, value in tbl3 do
        flushPageVersion(value.page, value.version)
    end
end

local num3 = 1
local bool3 = false

return {
    recordComponentType = recordComponentType,
    recordProp = recordProp,
    recordActionType = recordActionType,
    recordActionParam = recordActionParam,
    scheduleFlush = function()
        if bool3 then
            return
        end
        bool3 = true
        task.delay(num3, function()
            bool3 = false
            flushAll()
        end)
    end,
    isTypeSamplingEnabled = function()
        return isTypeSamplingEnabled
    end,
    isParamSamplingEnabled = function()
        return isParamSamplingEnabled
    end,
    _flushAllForTesting = flushAll,
    _resetAllForTesting = function()
        tbl1 = {}
        tbl2 = {}
        bool3 = false
    end,
    _setSamplingForTesting = function(bool4: boolean, bool5: boolean)
        isTypeSamplingEnabled = bool4
        isParamSamplingEnabled = bool5
    end,
    _setFlushDelayForTesting = function(num4: number)
        num3 = num4
    end
}
