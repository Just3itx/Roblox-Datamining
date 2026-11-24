-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperimentLayersParent = script:FindFirstAncestor("ExperimentLayers").Parent
local Dash = require(ExperimentLayersParent.Dash)
local AppUserLayers = require(script.Parent.AppUserLayers)

local str1 = game:DefineFastString("IxpNewLayersForRegistration", "")

local function findNextKey(tbl1, str2: string)
    if not tbl1[str2] then
        tbl1[str2] = true
        return str2
    end

    for i = 2, 100 do
        local str3 = str2 .. "_" .. i
        if not tbl1[str3] then
            tbl1[str3] = true
            return str3
        end
    end
    error("Exceeded max index for next key search: " .. str2)
end

local function getAllAppUserLayers(str2: string?)
    local str3 = str2 or str1
    if #str3 == 0 then
        return AppUserLayers
    end

    local var1 = Dash.copy(AppUserLayers)

    local tbl1 = ({})
    local tbl2 = ({})
    for value, value2 in var1 do
        tbl1[value] = true
        tbl2[value2] = true
    end

    local tbl3 = string.split(str3, ",")
    for _, value in (Dash.map(tbl3, Dash.trim)) do
        if not tbl2[value] then
            tbl2[value] = true
            var1[findNextKey(tbl1, value)] = value
        end
    end

    return var1
end

return getAllAppUserLayers
