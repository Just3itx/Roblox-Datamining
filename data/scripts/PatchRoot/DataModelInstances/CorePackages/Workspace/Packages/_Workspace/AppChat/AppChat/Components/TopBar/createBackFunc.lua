-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local EnumScreens = require(AppChat.EnumScreens)
local FFlagAppChatFixBackButtonOnRotation = require(AppChat.Flags.FFlagAppChatFixBackButtonOnRotation)
local canPopParentStack = require(AppChat.Utils.canPopParentStack)

local function createBackFunc(tbl1)
    local navigateToRootStack = tbl1.navigateToRootStack

    return if navigateToRootStack then function()
        if tbl1.closeInputBar then
            tbl1.closeInputBar()
        end

        if not tbl1.isRoot then
            tbl1.navigation.pop()

            return
        end

        if FFlagAppChatFixBackButtonOnRotation and canPopParentStack(tbl1.navigation) then
            tbl1.navigation.pop()
            return
        end
        tbl1.navigation.navigate(EnumScreens.EmptyConversation)
        navigateToRootStack()
    end else tbl1.navigation.pop
end

return createBackFunc
