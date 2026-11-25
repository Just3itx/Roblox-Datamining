-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Cryo = require(ProfilePlatformParent.Cryo)
local Localization = require(ProfilePlatformParent.Localization)

local Enums = require(ProfilePlatform.Common.Enums)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileJson = require(ProfilePlatform.Hooks.useProfileJson)
local useLocalization = Localization.Hooks.useLocalization
local abbreviateCount = Localization.abbreviateCount

local SocialCountsConfig = require(script.Parent.Parent.config.SocialCountsConfig)
local FFlagProfilePlatformGracefulVisibility = require(ProfilePlatform.Flags.FFlagProfilePlatformGracefulVisibility)

local function useSocialCountsData(_: string, bool1: boolean, bool2: boolean, mutualFriendIds)
    local counts = useProfileJsonComponent(Enums.Components.UserProfileHeader).counts
    local bool3 = true
    if FFlagProfilePlatformGracefulVisibility then
        local var1 = useProfileJson()
        bool3 = not (var1.components == nil) and var1.components[Enums.Components.Friends] ~= nil
    end

    local var1 = React.useMemo(function()
        return Cryo.Dictionary.map(SocialCountsConfig.RowConfig, function(arg1)
            return arg1.textKey
        end)
    end, {})

    local var2 = useLocalization(var1)

    local var3 = React.useMemo(function()
        return Cryo.Dictionary.map(SocialCountsConfig.RowConfig, function(arg1)
            return arg1.singleTextKey
        end)
    end, {})

    local var4 = useLocalization(var3)

    return React.useMemo(function()
        local result = {}

        for fieldName, count in counts do
            local var5 = SocialCountsConfig.RowConfig[fieldName]
            if not var5 then
                continue
            end

            local count2 = counts[var5.enabledKey]
            if count2 == nil then
                count2 = true
            end

            if FFlagProfilePlatformGracefulVisibility and fieldName == "friendsCount" then
                count2 = count2 and bool3
            end

            local var6 = var2[fieldName]
            if count == 1 and var4[fieldName] then
                var6 = var4[fieldName]
            end

            local leading = if var5.getLeading and mutualFriendIds then var5.getLeading({ mutualFriendIds = mutualFriendIds }) else nil
            table.insert(result, {
                fieldName = fieldName,
                count = abbreviateCount(count),
                text = var6,
                layoutOrder = var5.layoutOrder,
                leading = leading,
                isDisabled = var5.getIsDisabled(bool2, bool1, count2)
            })
        end

        table.sort(result, function(arg1, arg2): boolean
            return arg1.layoutOrder < arg2.layoutOrder
        end)

        return result
    end, {
        counts,
        var2,
        var4,
        bool2,
        bool1,
        mutualFriendIds,
        bool3
    })
end

return useSocialCountsData
