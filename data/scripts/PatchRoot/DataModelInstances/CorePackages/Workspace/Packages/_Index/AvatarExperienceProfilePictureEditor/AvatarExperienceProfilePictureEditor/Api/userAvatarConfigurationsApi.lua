-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local Http = require(AvatarExperienceProfilePictureEditorParent.Http)
local Enums = require(AvatarExperienceProfilePictureEditor.Common.Enums)

local DEFAULT_SELECTION_TYPES = { "ProfileFrame", "ThumbnailCustomizations" }

local function appendSelectionTypeQueryParams(tbl2, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) == "string" then
        table.insert(tbl2, `selectionTypes={arg1}`)
        return
    end

    for _, value in arg1 do
        table.insert(tbl2, `selectionTypes={value}`)
    end
end

local function buildUserAvatarConfigurationsUrl(str1: string, arg1): string
    local tbl2 = {}
    appendSelectionTypeQueryParams(tbl2, arg1 or DEFAULT_SELECTION_TYPES)

    return `{Http.Url.AVATAR_URL}v4/avatar/users/{str1}?{table.concat(tbl2, "&")}`
end

return {
    DEFAULT_SELECTION_TYPES = DEFAULT_SELECTION_TYPES,
    buildUserAvatarConfigurationsUrl = buildUserAvatarConfigurationsUrl,
    fetchUserAvatarConfigurations = function(func1: (...any) -> (...any), str1: string, arg1)
        return func1(buildUserAvatarConfigurationsUrl(str1, arg1), Enums.RequestMethods.GET)
    end
}
