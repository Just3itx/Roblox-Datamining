-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local SignalsReact = require(AppChatParent.SignalsReact)

local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)

local function TopBarFromStore(tbl1)
    local screenName = tbl1.screenName
    local render = tbl1.render

    local topBarStore = GetTopBarStore(false)
    local screenTopBar = topBarStore.getScreenTopBar(screenName)
    local var1 = SignalsReact.useSignalState(screenTopBar)

    return render((React.useMemo(function()
        return {
            getScreenTopBar = function(str1: string)
                if str1 == screenName then
                    return var1
                end
                return topBarStore.getScreenTopBar(str1)(false)
            end,
            setScreenTopBar = topBarStore.setScreenTopBar
        }
    end, {
        screenName,
        var1,
        topBarStore.getScreenTopBar,
        topBarStore.setScreenTopBar
    })))
end
return TopBarFromStore
