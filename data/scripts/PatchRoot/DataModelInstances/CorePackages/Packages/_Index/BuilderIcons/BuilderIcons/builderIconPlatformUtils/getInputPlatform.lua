-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = require(script.Parent.Parent.Services).UserInputService
local Platform = require(script.Parent.Platform)

local tbl1 = {
    ps4 = Platform.PS4,
    ps5 = Platform.PS5,
    xbox = Platform.Xbox
}

local function getInputPlatform()
    local imageForKeyCode = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonStart)
    for value, value2 in tbl1 do
        if imageForKeyCode:find(value) then
            return value2
        end
    end

    return if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonCross" then Platform.PS5 else Platform.Xbox
end

return getInputPlatform
