-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local SignalsReact = require(ExpChatParent.SignalsReact)

local Config = require(ExpChat.Config)
local Parent = require(script.Parent)

local function useIsChatBackgroundVisible()
    local var1 = Parent(false)

    local var2 = var1.getIsFocused or var1.getIsTextBoxFocused
    local var3 = SignalsReact.useSignalState(var2)
    local var4 = SignalsReact.useSignalState(var1.getLastActivity)

    local var5, var6 = React.useState(true)
    React.useEffect(function()
        if var3 then
            var6(true)
            return nil
        end

        local var7 = Config.ChatWindowBackgroundFadeOutTime - (os.clock() - var4)
        if var7 <= 0 then
            var6(false)
            return nil
        end
        var6(true)
        local var8 = task.delay(var7, function()
            var6(false)
        end)
        return function()
            pcall(task.cancel, var8)
        end
    end, { var4, var3 })

    return var5
end

return useIsChatBackgroundVisible
