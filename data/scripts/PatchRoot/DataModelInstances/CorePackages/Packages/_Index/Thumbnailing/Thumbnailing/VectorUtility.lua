-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.Vector3FromXYRotPlusDistance(num1: number, num2: number, num3: number)
    return CFrame.fromEulerAnglesXYZ(math.rad(num1), math.rad(num2), 0).LookVector * num3
end

function module.Vector3FromJson(str1: string)
    local str2, str3, str4 = unpack(str1:split("/"))
    local var1 = tonumber(str2)
    local var2 = tonumber(str3)
    local var3 = tonumber(str4)
    if var1 and var2 and var3 then
        return module.Vector3FromXYRotPlusDistance(var1, var2, var3)
    end
    return Vector3.new(0, 0, 0)
end

return module
