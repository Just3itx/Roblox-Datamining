-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local React = require(GroupsParent.React)
local useLocalization = require(GroupsParent.Localization).Hooks.useLocalization

local TextKeys = require(Groups.Common.TextKeys)

local function useMembersFollowersLabel(tbl1)
    local hasSocialModules = tbl1.hasSocialModules
    local count = tbl1.count
    local truncatedCount = tbl1.truncatedCount
    local capitalize = tbl1.capitalize or false

    local noun = React.useMemo(function()
        local bool1 = count == 1

        if hasSocialModules then
            if bool1 then
                if capitalize then
                    return TextKeys.LabelMember
                end

                return TextKeys.LabelMemberLowerCase
            end

            if capitalize then
                return TextKeys.LabelMemberCapitalPlural
            end

            return TextKeys.LabelMemberLowerCasePlural
        end

        if bool1 then
            if capitalize then
                return TextKeys.LabelFollowerCapital
            end

            return TextKeys.LabelFollower
        end

        if capitalize then
            return TextKeys.LabelFollowerCapitalPlural
        end

        return TextKeys.LabelFollowerPlural
    end, { count, capitalize, hasSocialModules })

    local var2 = useLocalization({ noun = noun })

    return (React.useMemo(function(): string
        local var3 = if truncatedCount and truncatedCount ~= "" then truncatedCount else tostring(count)
        return `{var3} {var2.noun}`
    end, { truncatedCount, count, var2.noun }))
end

return useMembersFollowersLabel
