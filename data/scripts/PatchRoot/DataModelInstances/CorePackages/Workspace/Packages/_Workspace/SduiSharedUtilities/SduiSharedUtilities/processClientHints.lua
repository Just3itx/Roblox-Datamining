-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")

local SduiGameIconPrewarm = require(SduiSharedUtilities.SduiGameIconPrewarm)
local _SduiIntegrationTypes = require(SduiSharedUtilities.SduiIntegrationTypes)

local tbl1 = {
    prewarm_icon = SduiGameIconPrewarm.prewarmSmallIcons,
    prewarm_large_icon = SduiGameIconPrewarm.prewarmLargeIcons
}

local function collectHintsInTemplateTree(arg1, func1: (...any) -> (...any), tbl2, tbl3)
    if type(arg1) ~= "table" then
        return
    end
    for value, value2 in arg1 do
        if value == "client_hints" and type(value2) == "table" then
            for _, value3 in value2 do
                if type(value3) == "string" then
                    tbl2[value3] = true
                end
            end
        elseif value == "roblox_component" and type(value2) == "string" and value2 ~= "" then
            if not tbl3[value2] then
                tbl3[value2] = true
                local var1 = func1(value2)
                if var1 ~= nil then
                    collectHintsInTemplateTree(var1, func1, tbl2, tbl3)
                end
            end
        elseif type(value2) == "table" then
            collectHintsInTemplateTree(value2, func1, tbl2, tbl3)
        end
    end
end

local var1 = (setmetatable({}, { __mode = "k" }))

local function getHintsDeclaredBy(arg1, func1: (...any) -> (...any))
    if arg1 == nil then
        return {}
    end
    local var2 = var1[arg1]
    if var2 ~= nil then
        return var2
    end
    local hintsDeclaredBy = {}
    collectHintsInTemplateTree(arg1, func1, hintsDeclaredBy, {})
    var1[arg1] = hintsDeclaredBy
    return hintsDeclaredBy
end

local function declaresHintWithHandler(arg1, getTemplateForRobloxComponent: (...any) -> (...any)) -- Luacid: Inlined by compiler; 2 call sites recovered
    for value in getHintsDeclaredBy(arg1, getTemplateForRobloxComponent) do
        if tbl1[value] then
            return true
        end
    end
    return false
end

local function anyTemplateDeclaresHintWithHandler(arg1, getTemplateForRobloxComponent: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in arg1.getKnownTemplates() do
        if declaresHintWithHandler(value, getTemplateForRobloxComponent) then
            return true
        end
    end
    return false
end

local function attributeHintTo(tbl2, str1: string, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl3 = tbl2[str1]
    if tbl3 == nil then
        tbl3 = {}
        tbl2[str1] = tbl3
    end
    table.insert(tbl3, arg1)
end

local function attributeHintsInInputData(arg1, func1: (...any) -> (...any), tbl2, tbl3)
    if type(arg1) ~= "table" then
        return
    end

    local robloxComponent = arg1.roblox_component
    local var2 = if type(robloxComponent) == "string" and robloxComponent ~= "" then func1(robloxComponent) else nil

    if var2 ~= nil then
        local tbl4 = tbl2

        for value in getHintsDeclaredBy(var2, func1) do
            if not tbl1[value] or tbl2[value] then
                continue
            end

            if tbl2 == tbl4 then
                tbl2 = table.clone(tbl4)
            end
            tbl2[value] = true
            attributeHintTo(tbl3, value, arg1)
        end
    end

    for _, value in arg1 do
        if type(value) == "table" then
            attributeHintsInInputData(value, func1, tbl2, tbl3)
        end
    end
end

local function processClientHints(arg1)
    local getTemplateForRobloxComponent = arg1.getTemplateForRobloxComponent
    if getTemplateForRobloxComponent == nil or not anyTemplateDeclaresHintWithHandler(arg1, getTemplateForRobloxComponent) then
        return
    end

    local tbl2 = {}
    for _, value in arg1.pageEntries do
        local robloxComponentType = value.robloxComponentType
        local componentInputData = value.componentInputData
        if not (robloxComponentType and componentInputData) then
            continue
        end

        local tbl3 = ({})
        local templateForRobloxComponent = getTemplateForRobloxComponent(robloxComponentType)
        if templateForRobloxComponent ~= nil then
            for value2 in getHintsDeclaredBy(templateForRobloxComponent, getTemplateForRobloxComponent) do
                if tbl1[value2] then
                    tbl3[value2] = true
                    attributeHintTo(tbl2, value2, componentInputData)
                end
            end
        end

        attributeHintsInInputData(componentInputData, getTemplateForRobloxComponent, tbl3, tbl2)
    end

    for value, value2 in tbl2 do
        tbl1[value](value2)
    end
end

return processClientHints
