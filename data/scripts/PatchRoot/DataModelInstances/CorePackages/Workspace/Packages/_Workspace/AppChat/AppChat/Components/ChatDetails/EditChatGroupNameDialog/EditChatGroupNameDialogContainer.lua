-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local SocialLibraries = require(AppChat.SocialLibraries)
local memo = React.memo
local useCallback = React.useCallback
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useState = React.useState
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local _ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local ResponseStatus = AppChatNetworking.Constants.ResponseStatus

local ResponseIndicator = SocialLibraries.Components.ResponseIndicator

local EditChatGroupNameDialog = require(script.Parent.EditChatGroupNameDialog)
local InputDialogContainer = require(AppChat.Components.Common.InputDialog.InputDialogContainer)
local FFlagAppChatFoundationGroupNameDialog = require(AppChat.Flags.FFlagAppChatFoundationGroupNameDialog)

local GetFFlagIsSquadEnabled = require(AppChatParent.SharedFlags).GetFFlagIsSquadEnabled

local Logger = require(AppChat.Logger)

local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local AppFocusRoot = FocusNavigationUtils.AppFocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local InputHandlers = require(AppChatParent.InputHandlers)

local function logRenameError(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    if FFlagAppChatFoundationGroupNameDialog then
        Logger:error(str1)
        return
    end

    Logger.error(str1)
end

local tbl1 = { Success = 0, Moderated = 0, Default = 0, Waiting = 0 }
local function Success() -- Luacid: Inlined by compiler; 1 call site recovered
    return { visible = false, isLoading = false, warningTextKey = nil }
end

tbl1.Success = Success

local function Moderated() -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        visible = true,
        isLoading = false,
        warningTextKey = if GetFFlagIsSquadEnabled() then "Feature.Chat.Response.ChatNameFullyModerated.V2" else "Feature.Chat.Response.ChatNameFullyModerated"
    }
end

tbl1.Moderated = Moderated

function tbl1.Default(existingName, newName)
    return {
        visible = true,
        isLoading = false,
        warningTextKey = {
            if GetFFlagIsSquadEnabled() then "Feature.Chat.Message.FailedToRenameConversation.V2" else "Feature.Chat.Message.FailedToRenameConversation",
            EXISTING_NAME = existingName,
            NEW_NAME = newName
        }
    }
end

local function Waiting() -- Luacid: Inlined by compiler; 1 call site recovered
    return { visible = true, isLoading = true }
end

tbl1.Waiting = Waiting

local tbl2 = {
    onModalClose = function() end,
    titleKey = if GetFFlagIsSquadEnabled() then "Feature.Chat.Label.GroupName" else "Feature.Chat.Label.ChatGroupName",
    cancelTitleKey = "Feature.Chat.Action.Cancel",
    confirmationTitleKey = "Feature.Chat.Action.Save",
    placeholderTextKey = if GetFFlagIsSquadEnabled() then "Feature.Chat.Description.NameGroup" else "Feature.Chat.Description.NameGroupChat"
}

function EditChatGroupNameDialogContainer(tbl3)
    local var1 = Cryo.Dictionary.join(tbl2, tbl3)
    local var2, var3 = useState({ visible = true, isLoading = false })

    local var4 = useDispatch()
    local var5 = useCallback(function(arg1, arg2)
        return var4(AppChatNetworking.rodux.UpdateConversationTitle.API(arg1, arg2))
    end, { var4 })

    local var6 = useSelector(function(arg1)
        local conversationId = var1.conversationId
        local conversation = arg1.ChatAppReducer.Conversations[conversationId]

        return if not conversation or conversation.isDefaultTitle then "" else conversation.title
    end)

    local onActivated = useCallback(function(arg1): boolean
        if var1.conversationId then
            local tbl4 = Waiting()
            var3(tbl4)
            var5(var1.conversationId, arg1.InputBox):andThen(function(arg2)
                if not (arg2 and arg2.responseBody and arg2.responseBody.conversations and arg2.responseBody.conversations[1]) then
                    logRenameError("Conversation rename response is invalid.")
                    var3((tbl1.Default(var6, arg1.InputBox)))
                elseif arg2.responseBody.conversations[1].status == ResponseStatus.SUCCESS then
                    local tbl5 = Success()
                    var3(tbl5)
                    var1.onModalClose()
                elseif arg2.responseBody and arg2.responseBody.conversations[1].status == ResponseStatus.MODERATED then
                    logRenameError("Conversation rename was moderated.")
                    var3((Moderated()))
                else
                    logRenameError("Conversation rename request failed.")
                    var3((tbl1.Default(var6, arg1.InputBox)))
                end
            end):catch(function(_)
                var3((tbl1.Default(var6, arg1.InputBox)))
            end)
        end

        return true
    end, { var1.conversationId, var6 })

    local customEventHandlers = React.useMemo(function()
        local result = {}

        result[FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(function(arg1)
                var1.onModalClose()
                arg1:cancel()
            end)
        }
        return result
    end, { var1.onModalClose })

    local var9 = useLocalization({
        titleText = var1.titleKey,
        placeholderText = var1.placeholderTextKey,
        cancelText = var1.cancelTitleKey,
        confirmText = var1.confirmationTitleKey,
        warningText = var2.warningTextKey
    })

    if FFlagAppChatFoundationGroupNameDialog then
        if not var2.visible then
            return nil
        end

        return React.createElement(InputDialogContainer, {
            titleText = var9.titleText,
            placeholderText = var9.placeholderText,
            cancelText = var9.cancelText,
            confirmText = var9.confirmText,
            warningText = var9.warningText,
            inputText = var6,
            maxCharacters = 150,
            maxUtf16Units = 300,
            isLoading = var2.isLoading,
            onActivated = onActivated,
            onModalClose = var1.onModalClose
        })
    end

    local element = React.createElement(React.Fragment, nil, {
        responseIndicator = var2.isLoading
            and React.createElement(ResponseIndicator, { soakAreaColor3 = Color3.fromRGB(25, 25, 25), soakAreaTransparency = 0.8 }),
        dialog = var2.visible
            and React.createElement(
                EditChatGroupNameDialog,
                Cryo.Dictionary.join(var1, var9, { onActivated = onActivated, inputText = var6, conversationTitle = var6 })
            )
    })

    return React.createElement(AppFocusRoot, {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isIsolated = true,
        isAutoFocusRoot = true,
        isFocusable = true,
        customEventHandlers = customEventHandlers
    }, element)
end

return memo(EditChatGroupNameDialogContainer)
