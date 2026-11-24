-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local React = require(scriptParentParentParent.React)

return function()
    local var1 = React.useRef(nil)

    React.useEffect(function()
        local shutterSound = Instance.new("Sound")
        shutterSound.Name = "ShutterSound"
        shutterSound.Parent = RobloxGui
        shutterSound.Volume = 1
        if not (_G.__TEST_SUITE_PACKAGE__ or _G.__TESTEZ_RUNNING_TEST__) then
            shutterSound.SoundId = "rbxassetid://10066921516"
        end
        var1.current = shutterSound

        return function()
            var1.current = nil
            shutterSound:Destroy()
        end
    end, {})

    return (React.useCallback(function()
        if var1.current then
            var1.current:Play()
        end
    end, {}))
end
