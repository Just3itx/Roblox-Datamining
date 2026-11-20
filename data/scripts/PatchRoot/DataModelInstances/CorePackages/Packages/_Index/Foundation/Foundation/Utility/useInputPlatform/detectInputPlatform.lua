-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local UserInputService = require(Foundation.Utility.Wrappers.Services).UserInputService

local InputPlatform = require(Foundation.Enums.InputPlatform)

local function hasConnectedGamepad(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        return UserInputService:GetConnectedGamepads()
    end)

    return success and typeof(result) == "table" and #result > 0
end

local tbl1 = {
    Enum.KeyCode.ButtonStart,
    Enum.KeyCode.ButtonSelect,
    Enum.KeyCode.ButtonA,
    Enum.KeyCode.ButtonL1,
    Enum.KeyCode.DPadUp
}

local function getPlatformFromImage(keyCode: Enum.KeyCode)
    local success, result = pcall(function()
        return UserInputService:GetImageForKeyCode(keyCode)
    end)

    if not success or typeof(result) ~= "string" or result == "" then
        return nil
    end

    local str1 = result:lower()

    if str1:find("ps5") then
        return InputPlatform.PS5
    end

    if str1:find("ps4") then
        return InputPlatform.PS4
    end

    if str1:find("xbox") then
        return InputPlatform.Xbox
    end

    return nil
end

local function getPlatformFromGamepadAssets() -- Luacid: Inlined by compiler; 1 call site recovered
    for _, keyCode in tbl1 do
        local platformFromImage = getPlatformFromImage(keyCode)
        if platformFromImage ~= nil then
            return platformFromImage
        end
    end

    return nil
end

local function isPlaystation(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        return UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA)
    end)
    return success and result == "ButtonCross"
end

local function detectInputPlatform()
    if not hasConnectedGamepad() then
        return InputPlatform.Default
    end

    local platformFromGamepadAssets = getPlatformFromGamepadAssets()

    if platformFromGamepadAssets == nil then
        if isPlaystation() then
            return InputPlatform.PS5
        end

        return InputPlatform.Xbox
    end

    return platformFromGamepadAssets
end

return detectInputPlatform
