-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent

local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local getSduiActionHandlerRegistry = SduiCoreSystem.getSduiActionHandlerRegistry

local FFlagSduiDismissPromptAction = require(SduiSharedContentParent.SharedFlags).FFlagSduiDismissPromptAction
local FFlagLuaAppSduiMovePromptsActions = require(SduiSharedContentParent.SharedFlags).FFlagLuaAppSduiMovePromptsActions
local FFlagSduiShowToastAction = require(SduiSharedContentParent.SharedFlags).FFlagSduiShowToastAction
local FFlagSduiActionSequence = require(SduiSharedContentParent.SharedFlags).FFlagSduiActionSequence
local FFlagSduiNavigate = require(SduiSharedContentParent.SharedFlags).FFlagSduiNavigate
local FFlagSduiSetPageScopeFieldAction = require(SduiSharedContent.Flags.FFlagSduiSetPageScopeFieldAction)
local FFlagSduiReactionsComponent = require(SduiSharedContentParent.SharedFlags).FFlagSduiReactionsComponent

local function registerSharedActions()
    local tbl1 = {
        [SduiActionType.CustomAnalyticsEvent] = {
            lazyHandler = function()
                return require(SduiSharedContent.Actions.SduiAnalyticsEventAction)
            end,
            skipUnifiedLogging = true
        },
        [SduiActionType.LoadMoreFromApi] = {
            lazyHandler = function()
                return require(SduiSharedContent.Actions.SduiLoadMoreFromApi)
            end,
            skipUnifiedLogging = true
        },
        [SduiActionType.RefreshFromApi] = {
            lazyHandler = function()
                return require(SduiSharedContent.Actions.SduiRefreshFromApi)
            end,
            skipUnifiedLogging = true
        },
        [SduiActionType.Share] = {
            lazyHandler = function()
                return require(SduiSharedContent.Actions.SduiShareAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.OpenSocialProofUserListSheet] = {
            lazyHandler = function()
                return require(SduiSharedContent.Actions.SduiOpenSocialProofUserListSheetAction)
            end,
            skipUnifiedLogging = true
        },
        [SduiActionType.DismissPrompt] = FFlagSduiDismissPromptAction and not FFlagLuaAppSduiMovePromptsActions and {
            lazyHandler = function()
                return require(SduiSharedContent.Actions.SduiDismissPromptAction)
            end,
            skipUnifiedLogging = false
        }
            or nil,
        [SduiActionType.ShowToast] = FFlagSduiShowToastAction and {
            lazyHandler = function()
                return require(SduiSharedContent.Actions.SduiShowToastAction)
            end,
            skipUnifiedLogging = false
        } or nil,
        [SduiActionType.ActionSequence] = FFlagSduiActionSequence and {
            lazyHandler = function()
                return require(SduiSharedContent.Actions.SduiActionSequenceAction)
            end,
            skipUnifiedLogging = true
        } or nil,
        [SduiActionType.Navigate] = FFlagSduiNavigate and {
            lazyHandler = function()
                return require(SduiSharedContent.Actions.SduiNavigateAction)
            end
        } or nil,
        [SduiActionType.SetPageScopeField] = FFlagSduiSetPageScopeFieldAction and {
            lazyHandler = function()
                return require(SduiSharedContent.Actions.SduiSetPageScopeFieldAction)
            end
        } or nil,
        [SduiActionType.ToggleContentReaction] = FFlagSduiReactionsComponent and {
            lazyHandler = function()
                return require(SduiSharedContent.Actions.SduiToggleContentReactionAction)
            end,
            skipUnifiedLogging = false
        } or nil
    }

    getSduiActionHandlerRegistry().registerActionHandlerConfigs(tbl1)
end

return registerSharedActions
