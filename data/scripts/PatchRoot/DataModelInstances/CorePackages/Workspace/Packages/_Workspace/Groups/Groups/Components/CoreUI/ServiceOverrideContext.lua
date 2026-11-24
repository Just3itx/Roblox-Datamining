-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local GroupService = game:GetService("GroupService")
local GuiService = game:GetService("GuiService")

return require(scriptParentParentParentParent.React).createContext({ groupService = GroupService, guiService = GuiService })
