-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local React = require(MomentsCreationParent.React)

local UserInputService = game:GetService("UserInputService")

local computeKeyboardInset = require(MomentsCreation.Utils.computeKeyboardInset)

local function useDescriptionKeyboardInset(bool1: boolean)
    local var1, var2 = React.useBinding(0)
    local var3 = React.useRef(nil)

    local var4 = React.useCallback(function()
        local current = var3.current
        local var4 = if current == nil then 0 else current.AbsolutePosition.Y + current.AbsoluteSize.Y
        local var5 = computeKeyboardInset(
            bool1,
            UserInputService.OnScreenKeyboardVisible,
            UserInputService.OnScreenKeyboardPosition.Y,
            var4,
            UserInputService.OnScreenKeyboardSize.Y
        )
        var2(var5)
    end, { bool1 })

    local var5 = React.useCallback(function(current)
        var3.current = current
        var4()
    end, { var4 })

    React.useEffect(function()
        var4()
        if not bool1 then
            return
        end

        local tbl1 = { UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(var4), UserInputService:GetPropertyChangedSignal("OnScreenKeyboardPosition"):Connect(var4), UserInputService:GetPropertyChangedSignal("OnScreenKeyboardSize"):Connect(var4) }

        return function()
            for _, value in tbl1 do
                value:Disconnect()
            end
        end
    end, { bool1, var4 })

    return var1, var5
end

return useDescriptionKeyboardInset
