-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Colors = require(ExpChatParent.UIBlox).App.Style.Colors

local ChatWindowBackgroundColor3 = require(ExpChat.Config).ChatWindowBackgroundColor3

local module = {}

function module.getBackgroundColor(tbl1, arg1)
    if tbl1.BackgroundColor3 == ChatWindowBackgroundColor3 then
        return Colors.Flint:Lerp(tbl1.BackgroundColor3, arg1.preferredTransparency)
    end
    return tbl1.BackgroundColor3
end

function module.getBackgroundTransparency(tbl1, arg1)
    return tbl1.BackgroundTransparency * arg1.preferredTransparency
end

return module
