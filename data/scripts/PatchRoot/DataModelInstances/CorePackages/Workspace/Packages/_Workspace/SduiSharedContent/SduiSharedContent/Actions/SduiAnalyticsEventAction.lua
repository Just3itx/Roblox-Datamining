-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local _SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)

local function isScalar(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    local str1 = typeof(arg1)
    return str1 == "string" or str1 == "number" or str1 == "boolean"
end

local function mergeScalars(tbl1, tbl2, tbl3)
    if tbl2 == nil then
        return
    end
    for value, value2 in tbl2 do
        if not (tbl3 and tbl3[value]) and isScalar(value2) then
            tbl1[value] = value2
        end
    end
end

local tbl1 = { eventName = true, eventFields = true }

local function SduiAnalyticsEventAction(arg1, arg2, arg3)
    local actionParams = if arg1 then arg1.actionParams or nil else nil

    if actionParams == nil then
        return
    end

    local eventName = actionParams.eventName
    if typeof(eventName) ~= "string" or eventName == "" then
        return
    end

    local tbl2 = ({})

    local ancestorAnalyticsData = arg2.ancestorAnalyticsData

    if ancestorAnalyticsData ~= nil then
        for value, value2 in ancestorAnalyticsData do
            if isScalar(value2) then
                tbl2[value] = value2
            end
        end
    end

    local analyticsData = arg2.analyticsData

    if analyticsData ~= nil then
        for value, value2 in analyticsData do
            if isScalar(value2) then
                tbl2[value] = value2
            end
        end
    end

    mergeScalars(tbl2, actionParams, tbl1)

    local eventFields = actionParams.eventFields

    if typeof(eventFields) == "table" and eventFields ~= nil then
        for k, eventField in eventFields do
            if isScalar(eventField) then
                tbl2[k] = eventField
            end
        end
    end
    arg3.dependencies.eventIngest:sendEventDeferred(arg3.appPage, eventName, tbl2)
end

return SduiAnalyticsEventAction
