-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local t = require(ChatUIPrimitivesParent.t)

local EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint = require(ChatUIPrimitivesParent.SharedFlags).EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint
local _Types = require(script.Parent.Types)

local var1 = t.union(t.literal("Enabled"), t.literal("ReadOnly"), t.literal("Disabled"))

local interface = t.interface
local tbl1 = { categories = 0 }
local array = t.array
local interface2 = t.interface
local tbl2 = {}
local array2 = t.array
local interface3 = t.interface
local tbl3 = {
    [if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then "text" else "value"] = t.string,
    presetId = t.string
}
tbl2[if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then "contents" else "messages"] = array2(interface3(tbl3))
tbl1.categories = array(interface2(tbl2))
local var2 = interface(tbl1)

local function normalizePresetCatalog(arg1)
    if type(arg1) ~= "table" then
        return nil
    end

    local accessLevel = if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then arg1.status else arg1.accessLevel

    if not var1(accessLevel) then
        return nil
    end

    local version = arg1.version

    if not EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint
        and accessLevel ~= "Disabled"
        and (type(version) ~= "string" or version == "")
    then
        return nil
    end

    local categoryGroups = {}
    if type(arg1.categoryGroups) == "table" then
        for _, categoryGroup in arg1.categoryGroups do
            if var2(categoryGroup) then
                table.insert(categoryGroups, categoryGroup)
            end
        end
    end

    return {
        accessLevel = accessLevel,
        categoryGroups = categoryGroups,
        version = if type(version) ~= "string" then "" else version
    }
end

return normalizePresetCatalog
