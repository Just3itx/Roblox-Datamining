-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local enumerate = require(scriptParentParentParentParentParent.enumerate)

return require(scriptParentParentParentParent.Utility.strict)({
    ItemIconType = enumerate("ItemIconType", { "AnimationBundle", "Bundle", "DynamicHead" }),
    Restriction = enumerate("Restriction", { "Limited", "LimitedUnique", "Collectible" }),
    StatusStyle = enumerate("StatusStyle", { "Alert", "Info", "PendingIcon", "AlertIcon" })
}, script.Name)
