-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:31:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceCloudPlayParent = script:FindFirstAncestor("InExperienceCloudPlay").Parent

local React = require(InExperienceCloudPlayParent.React)
local RestyleTimerView = require(script.Parent.RestyleTimerView)
local useRestyleTimerViewModel = require(script.Parent.useRestyleTimerViewModel)

local function RestyleTimerContainer(arg1)
    local var1 = useRestyleTimerViewModel(arg1)
    if var1 then
        return (React.createElement(RestyleTimerView, var1))
    end

    return nil
end

return RestyleTimerContainer
