-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local React = require(EditProfileParent.React)
local EditProfileToast = require(script.Parent.EditProfileToast)

local function EditProfileToastScreen(tbl1)
    local text = tbl1.navigation.getParam("text", "")

    return React.createElement(EditProfileToast, { text = text })
end

return EditProfileToastScreen
