-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Roact)

local AdsEuDsaPromptHandler = require(script.Parent.AdsEuDsaPromptHandler)

local function starterScript()
    Roact.mount(Roact.createElement(AdsEuDsaPromptHandler), CoreGui, "AdsEuDsaPromptHandler")
end

return starterScript
