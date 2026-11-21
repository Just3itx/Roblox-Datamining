-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local Promise = require(AvatarExperienceProfilePictureEditorParent.Promise)

local parseUserAvatarConfigurationsV4 = require(AvatarExperienceProfilePictureEditor.Shared.parseUserAvatarConfigurationsV4).parseUserAvatarConfigurationsV4
local _parseCloseupCameraConfig = require(AvatarExperienceProfilePictureEditor.Shared.parseCloseupCameraConfig)
local userAvatarConfigurationsApi = require(script.Parent.userAvatarConfigurationsApi)

local tbl1 = ({})
local tbl2 = ({})

local function normalizeSelectionTypes(arg1): {string} -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) == "string" then
        return { arg1 }
    end

    local var1 = table.clone(arg1)
    table.sort(var1)
    return var1
end

local function buildCacheKey(str1: string, arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    local concat = table.concat
    local var1 = normalizeSelectionTypes(arg1)
    return `{str1}:{concat(var1, ",")}`
end

local function clearCacheEntry(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    tbl1[str1] = nil
    tbl2[str1] = nil
end

return {
    buildCacheKey = buildCacheKey,
    fetchCached = function(arg1, str1: string, arg2)
        local var1 = arg2 or userAvatarConfigurationsApi.DEFAULT_SELECTION_TYPES
        local cacheKey = buildCacheKey(str1, var1)
        local var2 = tbl1[cacheKey]
        if var2 then
            return Promise.resolve(var2)
        end

        local var3 = tbl2[cacheKey]
        if var3 then
            return var3
        end

        local var4 = userAvatarConfigurationsApi.fetchUserAvatarConfigurations(arg1, str1, var1):andThen(function(response)
            local tbl3 = {
                response = response,
                parsed = parseUserAvatarConfigurationsV4(response.responseBody)
            }
            tbl1[cacheKey] = tbl3
            tbl2[cacheKey] = nil
            return tbl3
        end):catch(function(arg3)
            tbl2[cacheKey] = nil
            return Promise.reject(arg3)
        end)

        tbl2[cacheKey] = var4
        return var4
    end,
    invalidate = function(str1: string)
        local str2 = `{str1}:`
        for value in tbl1 do
            local num1 = #str2

            if string.sub(value, 1, num1) == str2 then
                clearCacheEntry(value)
            end
        end
    end,
    clearCacheForTests = function()
        table.clear(tbl1)
        table.clear(tbl2)
    end
}
