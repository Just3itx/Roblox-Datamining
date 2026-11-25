-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")

local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local FFlagLuaAppEnableSduiHomePage = require(SduiSharedUtilitiesParent.SharedFlags).FFlagLuaAppEnableSduiHomePage

local _SduiIntegrationTypes = require(SduiSharedUtilities.SduiIntegrationTypes)

local module = {}

local function isArrayLike(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return typeof(arg1) == "table" and #arg1 > 0
end

local function shallowAssignFromNew(tbl1, tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
    for value, value2 in tbl2 do
        tbl1[value] = value2
    end
end

local function appendArray(tbl1, tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, value in tbl2 do
        table.insert(tbl1, value)
    end
end

local function mergeInto(tbl1, tbl2, arg1, tbl3)
    for value, value2 in tbl2 do
        if typeof(value2) == "table" then
            table.insert(tbl3, tostring(value))
            local var1 = if arg1 then arg1(tbl3, value2, tbl1[value]) else nil

            if FFlagLuaAppEnableSduiHomePage and var1 == "preserve" then
                table.remove(tbl3)
            else
                if var1 == "replace" then
                    tbl1[value] = value2
                elseif var1 == "merge" then
                    if tbl1[value] == nil then
                        tbl1[value] = value2
                    else
                        shallowAssignFromNew(tbl1[value], value2)
                    end
                elseif var1 ~= "append" then
                    if tbl1[value] == nil then
                        tbl1[value] = {}
                    end

                    if isArrayLike(value2) then
                        appendArray(tbl1[value], value2)
                    else
                        mergeInto(tbl1[value], value2, arg1, tbl3)
                    end
                elseif tbl1[value] == nil then
                    tbl1[value] = value2
                elseif isArrayLike(value2) then
                    appendArray(tbl1[value], value2)
                else
                    shallowAssignFromNew(tbl1[value], value2)
                end

                table.remove(tbl3)
            end
        else
            tbl1[value] = value2
        end
    end
end

function module.merge(tbl1, tbl2, arg1)
    local var1 = table.clone(tbl1)
    mergeInto(var1, tbl2, arg1, {})
    return var1
end

return module
