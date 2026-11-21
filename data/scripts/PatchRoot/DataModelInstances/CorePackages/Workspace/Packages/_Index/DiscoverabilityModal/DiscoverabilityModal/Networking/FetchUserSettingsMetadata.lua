-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local NetworkingUserSettings = require(scriptParentParent.dependencies).NetworkingUserSettings

return function()
    return function(arg1)
        arg1:dispatch(NetworkingUserSettings.GetUserSettingsMetadata.API())
    end
end
