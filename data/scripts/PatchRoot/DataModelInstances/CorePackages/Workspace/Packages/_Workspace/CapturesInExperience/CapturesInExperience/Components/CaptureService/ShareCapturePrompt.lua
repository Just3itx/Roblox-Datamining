-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Foundation = require(scriptParentParentParentParent.Foundation)
local Localization = require(scriptParentParentParentParent.Localization)
local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local RobloxAppHooks = require(scriptParentParentParentParent.RobloxAppHooks)
local UIBlox = require(scriptParentParentParentParent.UIBlox)

local View = Foundation.View

local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert

local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization
local usePinInputStateWhileOpen = require(scriptParentParentParent.Hooks.usePinInputStateWhileOpen)
local useScreenSize = RobloxAppHooks.useScreenSize

local CapturePromptItem = require(scriptParentParentParent.Components.CaptureService.CapturePromptItem)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local ShareCapturePromptFinished = require(scriptParentParentParent.Thunks.ShareCapturePromptFinished)
local _Types = require(scriptParentParentParent.Types)

local FFlagCapturePermissionsPromptFreeMouse = require(scriptParentParentParent.Flags.FFlagCapturePermissionsPromptFreeMouse)

return function(tbl1)
    local var1 = useAnalytics()
    local var2 = useDispatch()
    local screenSize = useScreenSize()

    local var4, var5 = React.useState(Vector2.new(0, 0))
    local var6, var7 = React.useState(Vector2.new(0, 0))
    local var8, var9 = React.useState(Vector2.new(0, 0))

    local content = tbl1.promptData.content
    local isU13LocalSavePrompt = tbl1.promptData.isU13LocalSavePrompt
    local var10 = tbl1.enableInputDelayed == nil or tbl1.enableInputDelayed
    local isVideoCapture = typeof(content) == "Content" and content.Object ~= nil and content.Object:IsA("VideoCapture")
    local var11 = useLocalization({
        no = "Feature.Captures.Action.NoThanks",
        saveBodyText = "Feature.Captures.Body.SaveCapturesPrompt",
        saveTitle = "Feature.Captures.Title.SaveCapturesPrompt",
        saveYes = "Feature.Captures.Action.Save",
        shareBodyText = "Feature.Captures.Body.ShareCapturePrompt",
        shareTitle = "Feature.Captures.Title.ShareCapturePrompt",
        shareYes = "Feature.Captures.Action.Share"
    })
    local bodyText = if isU13LocalSavePrompt then var11.saveBodyText else var11.shareBodyText
    local title = if isU13LocalSavePrompt then var11.saveTitle else var11.shareTitle
    local text = if isU13LocalSavePrompt then var11.saveYes else var11.shareYes
    usePinInputStateWhileOpen(FFlagCapturePermissionsPromptFreeMouse)

    React.useEffect(function()
        if isU13LocalSavePrompt then
            return
        end

        var1.fireEvent(EventNames.ShareCapturePromptViewed)
        if isVideoCapture then
            var1.fireEvent(EventNames.ShareCapturePromptVideoPrompted)
        end
    end, { var1.fireEvent, isU13LocalSavePrompt, isVideoCapture })

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var5(arg1.AbsoluteSize)
    end, { var5 })

    local var3 = React.useCallback(function(arg1)
        var7(arg1.AbsoluteSize)
    end, { var7 })

    local onActivated = React.useCallback(function()
        if not isU13LocalSavePrompt then
            var1.fireEvent(EventNames.ShareCapturePromptAccepted)
            if isVideoCapture then
                var1.fireEvent(EventNames.ShareCapturePromptVideoAccepted)
            end
        end

        var2(ShareCapturePromptFinished(tbl1.promptId, tbl1.promptData, true))
    end, {
        var1.fireEvent,
        var2,
        isU13LocalSavePrompt,
        isVideoCapture,
        tbl1.promptData,
        tbl1.promptId
    })

    local var12 = React.useCallback(function()
        if not isU13LocalSavePrompt then
            var1.fireEvent(EventNames.ShareCapturePromptRejected)
            if isVideoCapture then
                var1.fireEvent(EventNames.ShareCapturePromptVideoRejected)
            end
        end

        var2(ShareCapturePromptFinished(tbl1.promptId, tbl1.promptData, false))
    end, {
        var1.fireEvent,
        var2,
        isU13LocalSavePrompt,
        isVideoCapture,
        tbl1.promptData,
        tbl1.promptId
    })

    local var19 = React.useCallback(function(arg1)
        var9(arg1.Resolution)
    end, { var9 })

    local buttonStackInfo = React.useMemo(function()
        return {
            buttons = {
                {
                    props = {
                        onActivated = var12,
                        text = var11.no
                    },
                    isDefaultChild = true
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        delayInputSeconds = 2,
                        enableInputDelayed = var10,
                        isDelayedInput = var10,
                        onActivated = onActivated,
                        text = text
                    },
                    isDefaultChild = false
                }
            }
        }
    end, {
        var10,
        var11,
        onActivated,
        var12,
        text
    })
    local middleContent = React.useCallback(function()
        local var21 = var4.Y - var6.Y
        local y = screenSize.Y - 80 - var21

        return React.createElement(View, {
            Size = UDim2.new(1, 0, 0, 200),
            sizeConstraint = {
                MaxSize = Vector2.new(math.huge, y)
            },
            onAbsoluteSizeChanged = var3
        }, {
            CapturePromptItem = React.createElement(CapturePromptItem, {
                content = content,
                isSelected = true,
                showCheckbox = false,
                updateSelected = function() end
            })
        })
    end, {
        var4,
        content,
        var6,
        var19,
        var8
    })

    return React.createElement(InteractiveAlert, {
        bodyText = bodyText,
        buttonStackInfo = buttonStackInfo,
        isMiddleContentFocusable = false,
        middleContent = middleContent,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        position = UDim2.fromScale(0.5, 0.5),
        screenSize = screenSize,
        title = title
    })
end
