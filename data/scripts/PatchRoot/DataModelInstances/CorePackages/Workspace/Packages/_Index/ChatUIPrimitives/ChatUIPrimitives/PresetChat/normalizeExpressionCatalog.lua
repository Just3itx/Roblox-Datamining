-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent

local EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint = require(ChatUIPrimitivesParent.SharedFlags).EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint
local _Types = require(ChatUIPrimitives.UniversalMessage.Types)

local function mapPreset(presetId, text, presetVersion)
    if type(presetId) ~= "string" or presetId == "" or type(text) ~= "string" then
        return nil
    end

    local content = { kind = "preset", presetId = presetId, text = text }

    if type(presetVersion) == "string" then
        content.presetVersion = presetVersion
    end
    return { content = content }
end

local function mapEmoji(tbl1)
    local emoteId = tbl1.emoteId
    if type(emoteId) ~= "string" or emoteId == "" then
        return nil
    end

    local content = { kind = "emoji", emojiId = emoteId }

    if type(tbl1.unicode) == "string" then
        content.unicode = tbl1.unicode
    end
    if type(tbl1.name) == "string" then
        content.name = tbl1.name
    end
    return { content = content }
end

local function mapContentsItem(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(arg1) ~= "table" then
        return nil
    elseif arg1.kind == "Preset" then
        return (mapPreset(arg1.presetId, arg1.text, arg1.presetVersion))
    elseif arg1.kind == "Emoji" then
        return (mapEmoji(arg1))
    end
    return nil
end

local function mapMessageItem(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(arg1) ~= "table" then
        return nil
    end
    return (mapPreset(arg1.presetId, arg1.value, nil))
end

local function mapCategory(arg1): {categoryId: string, items: {[any]: any}}?
    if type(arg1) ~= "table" then
        return nil
    end
    local categoryId = arg1.categoryId
    if type(categoryId) ~= "string" or categoryId == "" then
        return nil
    end

    local var1 = if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then arg1.contents else arg1.messages

    if type(var1) ~= "table" then
        return nil
    end

    local items = {}
    for _, value in var1 do
        local var2 = if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then mapContentsItem(value) else mapMessageItem(value)

        if var2 ~= nil then
            table.insert(items, var2)
        end
    end
    if #items == 0 then
        return nil
    end

    local tbl2 = { categoryId = categoryId, items = items }

    local name = arg1.name
    if type(name) == "string" then
        tbl2.name = name
    end
    return tbl2
end

local function mapGroup(arg1): {categories: {[any]: any}, categoryGroupId: string}?
    if type(arg1) ~= "table" then
        return nil
    end
    local categoryGroupId = arg1.categoryGroupId
    if type(categoryGroupId) ~= "string" or categoryGroupId == "" then
        return nil
    end
    if type(arg1.categories) ~= "table" then
        return nil
    end

    local categories = {}
    for _, value in arg1.categories do
        local var1 = mapCategory(value)
        if var1 ~= nil then
            table.insert(categories, var1)
        end
    end
    if #categories == 0 then
        return nil
    end

    local tbl2 = { categoryGroupId = categoryGroupId, categories = categories }

    local name = arg1.name
    if type(name) == "string" then
        tbl2.name = name
    end
    local footerText = arg1.footerText
    if type(footerText) == "string" and footerText ~= "" then
        tbl2.footerText = footerText
    end
    return tbl2
end

local function statusFromAccessLevel(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 == "Enabled" then
        return "enabled"
    end

    if str1 == "ReadOnly" or str1 == "Disabled" then
        return "disabled"
    end

    return nil
end

local function normalizeExpressionCatalog(arg1)
    if type(arg1) ~= "table" then
        return nil
    end

    local var1 = if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then arg1.status else arg1.accessLevel

    if type(var1) ~= "string" then
        return nil
    end

    local status = statusFromAccessLevel(var1)

    if status == nil then
        return nil
    end

    local version = arg1.version

    if not EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint
        and var1 ~= "Disabled"
        and (type(version) ~= "string" or version == "")
    then
        return nil
    end

    local categoryGroups = {}
    if type(arg1.categoryGroups) == "table" then
        for _, categoryGroup in arg1.categoryGroups do
            local var3 = mapGroup(categoryGroup)
            if var3 ~= nil then
                table.insert(categoryGroups, var3)
            end
        end
    end

    return {
        status = status,
        categoryGroups = categoryGroups,
        version = if type(version) ~= "string" then "" else version
    }
end
return normalizeExpressionCatalog
