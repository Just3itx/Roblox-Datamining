-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local React = require(GroupsParent.React)
local Foundation = require(GroupsParent.Foundation)

local function escapeRichText(description: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return (description:gsub("[&<>]", { ["&"] = "&amp;", ["<"] = "&lt;", [">"] = "&gt;" }))
end

local function SettingsFieldBase(tbl1)
    return React.createElement(Foundation.List.Item, {
        title = tbl1.title,
        description = if tbl1.description then escapeRichText(tbl1.description) else nil,
        trailing = tbl1.trailing,
        onActivated = tbl1.onClick,
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId
    })
end

return SettingsFieldBase
