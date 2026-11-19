-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:51:06Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Wrappers = require(Foundation.Utility.Wrappers)

local GuiService = Wrappers.Services.GuiService
local UserInputService = Wrappers.Services.UserInputService

local React = require(FoundationParent.React)

local function useKeyboardAwareSize(arg1)
    local var1, var2 = React.useBinding(UDim2.fromScale(1, 1))

    React.useLayoutEffect(function()
        if not arg1 then
            return
        end

        local function updateSafeAreaSize()
            if not UserInputService.OnScreenKeyboardVisible then
                var2(UDim2.fromScale(1, 1))
                return
            end

            local guiInset = GuiService:GetGuiInset()
            local var3 = UserInputService.OnScreenKeyboardPosition.Y - guiInset.Y

            local absoluteSize = arg1.AbsoluteSize
            local var4 = arg1.AbsolutePosition.Y + absoluteSize.Y - var3
            local uDim2 = UDim2.new(1, 0, 1, -var4)

            if var1:getValue() ~= uDim2 then
                var2(uDim2)
            end
        end

        updateSafeAreaSize()

        local connection = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(updateSafeAreaSize)
        local connection2 = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardPosition"):Connect(updateSafeAreaSize)
        local connection3 = arg1:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSafeAreaSize)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
        end
    end, { arg1 })

    return var1
end

return useKeyboardAwareSize
