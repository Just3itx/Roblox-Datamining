-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local ChatModerationStatusHydrationMiddleware = require(ExpChatParent.AppChat.ChatModerationStatusHydrationMiddleware)
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local Rodux = require(ExpChatParent.Rodux)

local RaiseActionAsEventMiddleware = ExpChatShared.RaiseActionAsEventMiddleware
local installReducer = require(script.Parent.installReducer)
local stickyTabMiddleware = require(script.Parent.StickyTabs.stickyTabMiddleware)

local FFlagAppChatReactiveFeatureRestrictions = require(ExpChatParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions
local FFlagExpChatStickyTabs = require(ExpChatParent.SharedFlags).FFlagExpChatStickyTabs

local function createStore(arg1)
    if FFlagExpChatStickyTabs then
        return Rodux.Store.new(
            installReducer,
            arg1,
            FFlagAppChatReactiveFeatureRestrictions
                and {
                    Rodux.thunkMiddleware,
                    ChatModerationStatusHydrationMiddleware,
                    RaiseActionAsEventMiddleware,
                    stickyTabMiddleware
                }
                or { Rodux.thunkMiddleware, RaiseActionAsEventMiddleware, stickyTabMiddleware }
        )
    end

    return Rodux.Store.new(
        installReducer,
        arg1,
        FFlagAppChatReactiveFeatureRestrictions
            and { Rodux.thunkMiddleware, ChatModerationStatusHydrationMiddleware, RaiseActionAsEventMiddleware }
            or { Rodux.thunkMiddleware, RaiseActionAsEventMiddleware }
    )
end

return createStore
