-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SceneUnderstanding = script:FindFirstAncestor("SceneUnderstanding")

local _types = require(SceneUnderstanding.wiring.types)

local function getOutputWires(arg1)
    local outputWires = {}
    for _, outputPin in (arg1:GetOutputPins()) do
        for _, value in arg1:GetConnectedWires(outputPin) do
            table.insert(outputWires, value)
        end
    end

    return outputWires
end

return getOutputWires
