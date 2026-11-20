-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagSettingsSelectorStepOnPressOnly = require(script.Parent.Flags.FFlagSettingsSelectorStepOnPressOnly)

local function shouldSelectorArrowStep(userInputType, bool1: boolean, bool2: boolean): boolean
    if FFlagSettingsSelectorStepOnPressOnly then
        return userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch
    end

    return bool1 or bool2 and userInputType == Enum.UserInputType.MouseButton1
end

return shouldSelectorArrowStep
