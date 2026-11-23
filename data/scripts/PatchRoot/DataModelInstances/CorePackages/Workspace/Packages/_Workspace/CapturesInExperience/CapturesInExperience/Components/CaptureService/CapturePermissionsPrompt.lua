-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:40:54Z
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

local FoundationText = Foundation.Text

local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization
local useScreenSize = RobloxAppHooks.useScreenSize

local PermissionPromptFinished = require(scriptParentParentParent.Thunks.PermissionPromptFinished)

return function(tbl1)
    local var1 = useDispatch()
    local var2 = useLocalization({
        allowAccessToCapturesTitle = "Feature.Captures.Title.AllowAccessToCaptures",
        allowAccessToCapturesBody = "Feature.Captures.Body.AllowAccessToCaptures",
        allow = "Feature.Captures.Action.Allow",
        dontAllow = "Feature.Captures.Action.DontAllow"
    })

    local screenSize = useScreenSize()

    local onActivated = React.useCallback(function()
        var1(PermissionPromptFinished(tbl1.promptId, true))
    end, { tbl1.promptId })

    local var3 = React.useCallback(function()
        var1(PermissionPromptFinished(tbl1.promptId, false))
    end, { tbl1.promptId })

    local buttonStackInfo = React.useMemo(function()
        return {
            buttons = {
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = onActivated,
                        text = var2.allow
                    },
                    isDefaultChild = false
                },
                {
                    props = {
                        onActivated = var3,
                        text = var2.dontAllow
                    },
                    isDefaultChild = true
                }
            }
        }
    end, { onActivated, var3 })

    local middleContent = React.useCallback(function()
        return React.createElement(
            FoundationText,
            {
                tag = "size-full-1200 text-align-x-center text-body-large text-wrap",
                Text = var2.allowAccessToCapturesBody
            }
        )
    end, {})

    return React.createElement(InteractiveAlert, {
        buttonStackInfo = buttonStackInfo,
        isMiddleContentFocusable = false,
        middleContent = middleContent,
        position = UDim2.fromScale(0.5, 0.5),
        screenSize = screenSize,
        title = var2.allowAccessToCapturesTitle
    })
end
