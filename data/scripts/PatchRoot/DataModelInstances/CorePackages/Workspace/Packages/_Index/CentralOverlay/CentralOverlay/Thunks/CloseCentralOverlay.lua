-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CentralOverlay = script:FindFirstAncestor("CentralOverlay")
local SetCentralOverlay = require(CentralOverlay.Actions.SetCentralOverlay)

return function()
    return function(arg1)
        if arg1:getState().CentralOverlay.Configs.DisableBackButtonClose then
            return
        end
        arg1:dispatch(SetCentralOverlay())
    end
end
