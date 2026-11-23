-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")

local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local useEffect = require(AppChatParent.React).useEffect

local tbl1 = {
    Enum.PlayerActions.CharacterForward,
    Enum.PlayerActions.CharacterBackward,
    Enum.PlayerActions.CharacterLeft,
    Enum.PlayerActions.CharacterRight,
    Enum.PlayerActions.CharacterJump,
    Enum.KeyCode.LeftShift,
    Enum.KeyCode.RightShift,
    Enum.KeyCode.Tab,
    Enum.UserInputType.Gamepad1,
    Enum.UserInputType.Gamepad2,
    Enum.UserInputType.Gamepad3,
    Enum.UserInputType.Gamepad4,
    Enum.UserInputType.Touch,
    Enum.UserInputType.Keyboard,
    Enum.UserInputType.MouseButton1,
    Enum.UserInputType.MouseButton2
}

return function(bool1: boolean)
    useEffect(function()
        if bool1 then
            ContextActionService:BindCoreActionAtPriority("AppChatDisableGameControls", function(_, _, arg1): Enum.ContextActionResult
                return if arg1.KeyCode == Enum.KeyCode.Escape then Enum.ContextActionResult.Pass else Enum.ContextActionResult.Sink
            end, false, Enum.ContextActionPriority.Low.Value, unpack(tbl1))
        end

        return function()
            if bool1 then
                ContextActionService:UnbindCoreAction("AppChatDisableGameControls")
            end
        end
    end, { bool1 })
end
