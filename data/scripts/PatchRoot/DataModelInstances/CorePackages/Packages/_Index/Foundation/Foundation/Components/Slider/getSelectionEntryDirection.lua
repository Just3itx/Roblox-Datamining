-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:51:13Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local UserInputService = require(Foundation.Utility.Wrappers.Services).UserInputService

local constants = require(script.Parent.constants)

local function getActiveGamepad() -- Luacid: Inlined by compiler; 10 call sites recovered
    local lastInputType = UserInputService:GetLastInputType()

    return if lastInputType.Name:match("^Gamepad") and table.find(UserInputService:GetConnectedGamepads(), lastInputType) ~= nil then lastInputType else nil
end

local function isHeld(keyCode: Enum.KeyCode, keyCode2: Enum.KeyCode): boolean -- Luacid: Inlined by compiler; 8 call sites recovered
    if UserInputService:IsKeyDown(keyCode) then
        return true
    end

    local activeGamepad = getActiveGamepad()
    return not (activeGamepad == nil) and UserInputService:IsGamepadButtonDown(activeGamepad, keyCode2)
end

local function getThumbstickDirection(bool1: boolean)
    local activeGamepad = getActiveGamepad()

    if not activeGamepad then
        return 0
    end

    for _, value in UserInputService:GetGamepadState(activeGamepad) do
        if value.KeyCode ~= Enum.KeyCode.Thumbstick1 then
            continue
        end

        local valuePositionX = value.Position.X
        local valuePositionY = value.Position.Y
        local bool2 = if bool1 then constants.thumbstickDeadzone <= valuePositionY or constants.thumbstickDeadzone <= valuePositionX else constants.thumbstickDeadzone <= valuePositionX or valuePositionY <= -constants.thumbstickDeadzone
        local bool3 = if bool1 then valuePositionY <= -constants.thumbstickDeadzone or valuePositionX <= -constants.thumbstickDeadzone else valuePositionX <= -constants.thumbstickDeadzone or constants.thumbstickDeadzone <= valuePositionY
        return if bool2 then 1 elseif bool3 then -1 else 0
    end

    return 0
end

local function getSelectionEntryDirection(bool1: boolean)
    local var1

    if bool1 then
        var1 = isHeld(Enum.KeyCode.Up, Enum.KeyCode.DPadUp) or isHeld(Enum.KeyCode.Right, Enum.KeyCode.DPadRight)
    else
        var1 = isHeld(Enum.KeyCode.Right, Enum.KeyCode.DPadRight) or isHeld(Enum.KeyCode.Down, Enum.KeyCode.DPadDown)
    end

    local var2

    if bool1 then
        var2 = isHeld(Enum.KeyCode.Down, Enum.KeyCode.DPadDown) or isHeld(Enum.KeyCode.Left, Enum.KeyCode.DPadLeft)
    else
        var2 = isHeld(Enum.KeyCode.Left, Enum.KeyCode.DPadLeft) or isHeld(Enum.KeyCode.Up, Enum.KeyCode.DPadUp)
    end
    if var1 then
        return 1
    elseif var2 then
        return -1
    end
    return (getThumbstickDirection(bool1))
end

return getSelectionEntryDirection
