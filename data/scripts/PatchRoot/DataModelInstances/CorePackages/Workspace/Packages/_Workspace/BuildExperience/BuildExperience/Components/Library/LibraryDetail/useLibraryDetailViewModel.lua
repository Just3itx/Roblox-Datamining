-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local _createBuildLibraryStore = require(BuildExperience.Stores.BuildLibrary.createBuildLibraryStore)
local LibraryTypes = require(BuildExperience.Components.Library.LibraryTypes)
local _LibraryDetailView = require(script.Parent.LibraryDetailView)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local function useLibraryDetailViewModel(tbl1, tbl2)
    local var1 = if tbl2 ~= nil then tbl2.userInputService else UserInputService
    local var2 = if tbl2 ~= nil then tbl2.guiService else GuiService
    local isActive = tbl1.isActive ~= false
    local bool2 = tbl1.chatActions ~= nil
    local var3, var4 = React.useState(0)
    local var5, var6 = React.useState(0)
    React.useEffect(function()
        if not bool2 then
            var4(0)
            return
        end

        local function updateKeyboardTop() -- Luacid: Inlined by compiler; 1 call site recovered
            local guiInset = var2:GetGuiInset()
            local var7 = var4
            local var8 = if var1.OnScreenKeyboardVisible then math.max(0, var1.OnScreenKeyboardPosition.Y - guiInset.Y) else 0
            var7(var8)
        end

        updateKeyboardTop()
        local connection = var1:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(updateKeyboardTop)

        local connection2 = var1:GetPropertyChangedSignal("OnScreenKeyboardSize"):Connect(updateKeyboardTop)

        local connection3 = var1:GetPropertyChangedSignal("OnScreenKeyboardPosition"):Connect(updateKeyboardTop)
        return function()
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
        end
    end, { bool2, var1, var2 })
    local onPageMetricsChanged = React.useCallback(function(arg1)
        var6(arg1.AbsolutePosition.Y + arg1.AbsoluteSize.Y)
    end, {})

    local var8 = if bool2 and not (var3 <= 0 or var5 <= 0) then math.max(0, var5 - var3) else 0
    local var9 = useLocalization(
        {
            composerPlaceholder = LocalizationStrings.CHAT_COMPOSER_PLACEHOLDER,
            soundLabel = "Feature.Build.Label.Sounds"
        }
    )
    local chatActions = tbl1.chatActions
    if chatActions ~= nil and (chatActions.placeholder == nil or chatActions.placeholder == "") then
        chatActions = table.clone(chatActions)
        chatActions.placeholder = var9.composerPlaceholder
    end
    local var10 = React.useCallback(function(arg1)
        return tbl1.library.getItem(arg1, tbl1.itemId)
    end, { tbl1.library, tbl1.itemId })
    local var11 = SignalsReact.useSignalState(var10)
    if not tbl1.isReady then
        var11 = nil
    end
    React.useEffect(function()
        local resourceActions = tbl1.resourceActions
        if var11 == nil or not isActive then
            return
        end

        local var12 = LibraryTypes.toChatResource(var11)
        local bool3 = resourceActions.onAddResource(var12) == true
        return function()
            if bool3 then
                resourceActions.onRemoveResource(var12)
            end
        end
    end, {
        var11 or false,
        tbl1.resourceActions,
        tbl1.library,
        isActive
    })
    React.useEffect(function()
        if var11 == nil or var11.model == nil or not isActive then
            return nil
        end
        local connection = var11.model.Destroying:Connect(tbl1.onBack)
        return function()
            connection:Disconnect()
        end
    end, { var11 or false, tbl1.onBack, isActive })

    local image = if var11 == nil or var11.kind ~= "Image" then nil else var11.image
    local var12, var13 = React.useState(nil)
    local onImageLoaded = React.useCallback(function(assetFetchStatus)
        var13(if assetFetchStatus == Enum.AssetFetchStatus.Success then nil else image)
    end, { image or false })

    local soundId = if var11 == nil or var11.kind ~= "Sound" then nil else var11.soundId
    local liveModel = var11 ~= nil
        and var11.model ~= nil
        and {
            id = var11.id,
            displayName = var11.displayName,
            path = var11.path,
            className = var11.className,
            model = var11.model
        }
        or nil

    local status = if tbl1.isReady then if liveModel == nil
        and (var11 == nil or var11.kind ~= "Image" or var11.image == nil or var11.image == "")
        and (var11 == nil or var11.kind ~= "Sound" or soundId == nil or soundId == "") then "Failed" else "Ready" else "Loading"

    return {
        isActive = isActive,
        keyboardOverlap = var8,
        onPageMetricsChanged = onPageMetricsChanged,
        liveModel = liveModel,
        image = image,
        imageLoadFailed = not (image == nil) and var12 == image,
        onImageLoaded = onImageLoaded,
        soundId = soundId,
        modelName = if var11 == nil then nil else var11.displayName,
        description = if var11 == nil then nil else var11.description,
        status = status,
        unavailableText = tbl1.unavailableText,
        soundLabel = var9.soundLabel,
        chatActions = chatActions
    }
end

return useLibraryDetailViewModel
