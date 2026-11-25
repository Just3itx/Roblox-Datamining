-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local Enums = require(ProfilePlatform.Common.Enums)

local Sections = require(script.Parent.Sections)
local tbl1 = {
    description = Sections.AboutDescription,
    socialLinks = Sections.SocialLinks,
    nameHistory = Sections.NameHistory,
    joinDateTime = Sections.JoinYear
}

local tbl2 = {
    "description",
    "socialLinks",
    "nameHistory",
    "joinDateTime"
}

local tbl3 = { "description" }

return function(arg1, contact, name: string?)
    local tbl4 = if contact == Enums.ProfileTypes.Contact then tbl3 else tbl2
    local result = {}

    for layoutOrder, value in ipairs(tbl4) do
        local var1 = tbl1[value]
        local var2 = arg1[value]
        if not var1 then
            continue
        end

        table.insert(result, React.createElement(var1, { layoutOrder = layoutOrder, [value] = var2, name = name }))
    end

    return result
end
