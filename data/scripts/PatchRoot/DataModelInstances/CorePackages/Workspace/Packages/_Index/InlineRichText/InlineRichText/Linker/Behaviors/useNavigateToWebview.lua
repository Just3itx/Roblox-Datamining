-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent

local React = require(InlineRichTextParent.React)

local useDispatch = require(InlineRichTextParent.RoactUtils).Hooks.RoactRodux.useDispatch
local NavigateDown = require(InlineRichTextParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(InlineRichTextParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(InlineRichTextParent.RobloxAppNavigation).NavigationCommands else nil
local AppPage = require(InlineRichTextParent.RobloxAppEnums).AppPage
local _Types = require(InlineRichText.Types)

local FFlagInlineRichTextUseWebViewService = require(InlineRichTextParent.SharedFlags).FFlagInlineRichTextUseWebViewService
local openWebView = require(InlineRichText.Utils.openWebView)

return function(_: nil)
    if FFlagInlineRichTextUseWebViewService then
        return React.useCallback(function(str1: string)
            openWebView(str1)
        end, {})
    end
    local var1 = useDispatch()
    return React.useCallback(function(detail: string)
        local tbl1 = {
            name = AppPage.GenericWebPage,
            detail = detail
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        var1(NavigateDown(tbl1))
    end, { var1 })
end
