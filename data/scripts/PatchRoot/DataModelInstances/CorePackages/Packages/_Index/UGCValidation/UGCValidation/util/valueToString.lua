-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Cryo = require(scriptParentParent.Parent.Cryo)

local getFFlagUGCValidationEyebrowEyelashSupport = require(scriptParentParent.flags.getFFlagUGCValidationEyebrowEyelashSupport)

local bool1 = game:DefineFastFlag("UGCValidationValueToStringVector3Precision", false)

local function round(arg1, arg2) -- Luacid: unused: defined but never referenced
    local var1 = 10 ^ (arg2 or 0)
    return math.floor(arg1 * var1 + 0.5) / var1
end

local function valueToString(none)
    local str1 = typeof(none)
    if none == Cryo.None then
        return "not defined"
    elseif str1 == "Vector3" then
        local str2 = if bool1 then "%g, %g, %g" else "%d, %d, %d"
        return string.format(
            str2,
            math.floor(none.X * 100 + 0.5) / 100,
            math.floor(none.Y * 100 + 0.5) / 100,
            math.floor(none.Z * 100 + 0.5) / 100
        )
    else
        if str1 ~= "Color3" then
            if not getFFlagUGCValidationEyebrowEyelashSupport() or str1 ~= "table" or none[1] == nil then
                return tostring(none)
            end

            local str2 = tostring(none[1])
            for i = 2, #none do
                str2 ..= ", " .. valueToString(none[i])
            end
            return str2
        end

        return string.format("%d, %d, %d", math.floor(none.r * 255), math.floor(none.g * 255), math.floor(none.b * 255))
    end
end

return valueToString
