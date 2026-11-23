-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local _React = require(BuildExperienceParent.React)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local GetPlayButtonStore = require(BuildExperience.Stores.GetPlayButtonStore)

local _ModelPickerTypes = require(BuildExperience.Components.ModelPicker.ModelPickerTypes)

local function createLibraryStore()
    local getIsOpen, setIsOpen = Signals.createSignal(false)
    local getWorldViewportRect, setWorldViewportRect = Signals.createSignal(nil)
    local getWorldChatTop, setWorldChatTop = Signals.createSignal(nil)
    local getWorldChatLeft, setWorldChatLeft = Signals.createSignal(nil)

    local getFocusRequest, var10 = Signals.createSignal(nil)

    local getChatResourceRequest, var12 = Signals.createSignal(nil)

    local getChatComposerState, setChatComposerState = Signals.createSignal(nil)

    local getPromptFailure, var16 = Signals.createSignal(nil)

    local getChipEvent, var18 = Signals.createSignal(nil)
    local num1 = 0

    local function useIsOpen()
        return SignalsReact.useSignalState(getIsOpen)
    end

    local function requestFocus(position: vector, radius: number, model)
        num1 += 1
        var10({ token = num1, position = position, radius = radius, model = model })
    end

    local function requestAddAllToChat(resources, replacePaths, focusComposer: boolean?) -- Luacid: Inlined by compiler; 1 call site recovered
        if #resources == 0 then
            return
        end
        num1 += 1
        var12(
            {
                token = num1,
                action = "Add",
                resources = resources,
                replacePaths = replacePaths,
                focusComposer = focusComposer
            }
        )
    end

    local function requestRemoveAllFromChat(resources)
        if #resources == 0 then
            return
        end
        num1 += 1
        var12({ token = num1, action = "Remove", resources = resources, replacePaths = {} })
    end

    local function requestAddToChat(arg1, str1: string?, focusComposer: boolean?)
        requestAddAllToChat({ arg1 }, str1 == nil and {} or { str1 }, focusComposer)
    end

    return {
        getIsOpen = getIsOpen,
        getIsChatOpen = GetPlayButtonStore(false).getIsActive,
        useIsOpen = useIsOpen,
        setIsOpen = setIsOpen,
        getFocusRequest = getFocusRequest,
        requestFocus = requestFocus,
        clearFocus = function()
            var10(nil)
        end,
        getWorldViewportRect = getWorldViewportRect,
        setWorldViewportRect = setWorldViewportRect,
        getWorldChatTop = getWorldChatTop,
        setWorldChatTop = setWorldChatTop,
        getWorldChatLeft = getWorldChatLeft,
        setWorldChatLeft = setWorldChatLeft,
        getChatResourceRequest = getChatResourceRequest,
        consumeChatResourceRequest = function(token)
            local var19 = getChatResourceRequest(false)
            if var19 ~= nil and var19.token == token then
                var12(nil)
            end
        end,
        requestAddToChat = requestAddToChat,
        requestRemoveFromChat = function(arg1)
            requestRemoveAllFromChat({ arg1 })
        end,
        requestAddAllToChat = requestAddAllToChat,
        requestRemoveAllFromChat = requestRemoveAllFromChat,
        getChatComposerState = getChatComposerState,
        setChatComposerState = setChatComposerState,
        getPromptFailure = getPromptFailure,
        reportPromptFailure = function(errorCode: number?)
            num1 += 1
            var16({ token = num1, errorCode = errorCode })
        end,
        getChipEvent = getChipEvent,
        reportChipEvent = function(kind: string, uris)
            num1 += 1
            var18({ token = num1, kind = kind, uris = uris })
        end
    }
end

return createLibraryStore
