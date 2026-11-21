-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local EditProfileAnalyticsContext = require(script.Parent.EditProfileAnalyticsContext)
local React = require(EditProfileParent.React)

return function()
    return React.useContext(EditProfileAnalyticsContext)
end
