-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:05:48Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local IsVRAppBuild = require(script.Parent.IsVRAppBuild)

return function(): Enum.QualityLevel
    return if IsVRAppBuild() then Enum.QualityLevel.Level07 else Enum.QualityLevel.Automatic
end
