-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local Actions = script:FindFirstAncestor("ExpChat").Actions
local ClientSettingsLoaded = require(Actions.ClientSettingsLoaded)
local ClientSettingsChanged = require(Actions.ClientSettingsChanged)

return function(arg1)
    arg1:dispatch(ClientSettingsLoaded({ preferredTransparency = UserGameSettings.PreferredTransparency }))

    UserGameSettings:GetPropertyChangedSignal("PreferredTransparency"):Connect(function()
        arg1:dispatch(ClientSettingsChanged("preferredTransparency", UserGameSettings.PreferredTransparency))
    end)
end
