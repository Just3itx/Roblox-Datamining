-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileBackgroundParent = script:FindFirstAncestor("EditProfileBackground").Parent
local EditProfileBackgroundAnalyticsContext = require(script.Parent.EditProfileBackgroundAnalyticsContext)
local React = require(EditProfileBackgroundParent.React)

return function()
    return React.useContext(EditProfileBackgroundAnalyticsContext)
end
