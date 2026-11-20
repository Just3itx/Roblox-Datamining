-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)

local FreeTrialChipHostView = require(script.Parent.FreeTrialChipHostView)
local useFreeTrialChipHostViewModel = require(script.Parent.useFreeTrialChipHostViewModel)

local function FreeTrialChipHost(arg1)
    local var1 = useFreeTrialChipHostViewModel(arg1)
    if var1 == nil then
        return nil
    end

    return (React.createElement(FreeTrialChipHostView, var1))
end

return FreeTrialChipHost
