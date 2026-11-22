-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local React = require(MomentsCreationParent.React)

local UserInputService = game:GetService("UserInputService")

local function readKeyboardTop(): number? -- Luacid: Inlined by compiler; 2 call sites recovered
    return if UserInputService.OnScreenKeyboardVisible then UserInputService.OnScreenKeyboardPosition.Y else nil
end

local function useOnScreenKeyboardTop()
    local var1, var2 = React.useState(readKeyboardTop)

    React.useEffect(function()
        local function update() -- Luacid: Inlined by compiler; 1 call site recovered
            var2((readKeyboardTop()))
        end
        local tbl1 = { UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(update), UserInputService:GetPropertyChangedSignal("OnScreenKeyboardPosition"):Connect(update), UserInputService:GetPropertyChangedSignal("OnScreenKeyboardSize"):Connect(update) }
        update()

        return function()
            for _, value in tbl1 do
                value:Disconnect()
            end
        end
    end, {})

    return var1
end

return useOnScreenKeyboardTop
