-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local CurveAnimationFrameCalculator = require(scriptParentParentParent.util.CurveAnimationFrameCalculator)

local getFFlagUGCValidateRunValidationsOnSecondaryCurveAnimations = require(scriptParentParentParent.flags.getFFlagUGCValidateRunValidationsOnSecondaryCurveAnimations)

local module = {}

function module.getData(arg1, tbl1)
    if #arg1 == 0 then
        return nil
    end

    local data = {}
    local fFlagUgcValidateRunValidationsOnSecondaryCurveAnimations = getFFlagUGCValidateRunValidationsOnSecondaryCurveAnimations()
    for i = 1, fFlagUgcValidateRunValidationsOnSecondaryCurveAnimations and #arg1 or 1 do
        local var1 = arg1[i]
        local success, result, result2, result3, result4 = pcall(function()
            return CurveAnimationFrameCalculator.calculateAnimFramesAtOrigin(var1)
        end)

        if not success then
            return nil
        end

        table.insert(data, {
            animation = if fFlagUgcValidateRunValidationsOnSecondaryCurveAnimations and tbl1 then tbl1[i] else nil,
            animFrames = result,
            animLength = result2,
            positionMagnitudeFrames = result3,
            tracks = result4
        })
    end

    return data
end

return module
