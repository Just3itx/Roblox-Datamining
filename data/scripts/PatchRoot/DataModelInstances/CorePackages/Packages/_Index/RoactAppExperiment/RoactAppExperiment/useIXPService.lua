-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactAppExperiment = script:FindFirstAncestor("RoactAppExperiment")

local IXPService = game:GetService("IXPService")

local React = require(RoactAppExperiment.Parent.React)
local ExperimentContext = require(script.Parent.ExperimentContext)

local function useIXPService()
    return React.useContext(ExperimentContext) or IXPService
end

return useIXPService
