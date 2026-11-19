-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.Expt(_, arg1, arg2, arg3, arg4)
    if math.abs(arg2 - arg1) < 0.01 then
        return arg2
    end

    local var1 = module:Expty(arg1, arg2, arg3, arg4)

    return arg1 + (arg2 - arg1) * var1
end

function module.Expty(_, _, _, arg1, arg2): number
    return 1 - math.exp(-(-math.log(1 - arg1)) * arg2)
end

function module.Sign(_, arg1): number
    return if arg1 > 0 then 1 elseif arg1 < 0 then -1 else 0
end

function module.BezierValForT(_, arg1, arg2, arg3, arg4, arg5)
    local var1 = (1 - arg5) * (1 - arg5) * (1 - arg5)
    local var2 = 3 * arg5 * (1 - arg5) * (1 - arg5)
    local var3 = 3 * arg5 * arg5 * (1 - arg5)
    local var4 = arg5 * arg5 * arg5
    return var1 * arg1 + var2 * arg2 + var3 * arg3 + var4 * arg4
end

module._BezierPt2ForT = { x = 0, y = 0 }
function module.BezierPt2ForT(_, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    module._BezierPt2ForT.x = module:BezierValForT(arg1, arg3, arg5, arg7, arg9)
    module._BezierPt2ForT.y = module:BezierValForT(arg2, arg4, arg6, arg8, arg9)
    return module._BezierPt2ForT
end

function module.YForPointOf2PtLine(_, arg1, arg2, arg3)
    local var1 = (arg1.y - arg2.y) / (arg1.x - arg2.x)

    local var2 = arg1.y - var1 * arg1.x
    return var1 * arg3 + var2
end

function module.DeltaTimeToTimescale(_, arg1)
    return arg1 / (1 / 60)
end

function module.SecondsToTick(_, arg1)
    return 1 / 60 / arg1
end

function module.ExptValueInSeconds(_, arg1, arg2, arg3): number
    return 1 - math.pow(arg1 / arg2, 1 / (60 * arg3))
end

function module.NormalizedDefaultExptValueInSeconds(arg1, arg2)
    return arg1:ExptValueInSeconds(0.01, 1, arg2)
end

return module
