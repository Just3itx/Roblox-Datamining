-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local function bindLibraryBackInput(callback: (...any) -> (...any))
    local buildLibraryBack = Instance.new("InputContext")
    buildLibraryBack.Name = "BuildLibraryBack"
    buildLibraryBack.Priority = 2000
    buildLibraryBack.Sink = true
    local back = Instance.new("InputAction")
    back.Name = "Back"
    back.Type = Enum.InputActionType.Bool
    for _, keyCode in { Enum.KeyCode.Escape, Enum.KeyCode.ButtonB } do
        local inputBinding = Instance.new("InputBinding")
        inputBinding.KeyCode = keyCode
        inputBinding.Parent = back
    end
    back.Parent = buildLibraryBack

    local bool1 = false

    local bool2 = false

    local enabled = false
    local function update() -- Luacid: Inlined by compiler; 4 call sites recovered
        local buildLibraryBackEnabled = not (bool1 or bool2) and UserInputService:GetFocusedTextBox() == nil

        if not buildLibraryBackEnabled then
            enabled = false
        end
        buildLibraryBack.Enabled = buildLibraryBackEnabled
    end

    update()

    local tbl1 = {
        back.Pressed:Connect(function()
            enabled = buildLibraryBack.Enabled
        end),
        back.Released:Connect(function()
            if enabled then
                enabled = false
                callback()
            end
        end),
        UserInputService.TextBoxFocused:Connect(update),
        UserInputService.TextBoxFocusReleased:Connect(function()
            bool2 = UserInputService:IsKeyDown(Enum.KeyCode.Escape)
                or UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonB)
            update()
        end),
        UserInputService.InputEnded:Connect(function(input: InputObject)
            if bool2 and (input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.ButtonB) then
                bool2 = false
                update()
            end
        end)
    }

    buildLibraryBack.Parent = CoreGui
    return {
        setChatOpen = function(bool3: boolean)
            bool1 = bool3
            update()
        end,
        unbind = function()
            for _, value in tbl1 do
                value:Disconnect()
            end
            buildLibraryBack:Destroy()
        end
    }
end

return bindLibraryBackInput
