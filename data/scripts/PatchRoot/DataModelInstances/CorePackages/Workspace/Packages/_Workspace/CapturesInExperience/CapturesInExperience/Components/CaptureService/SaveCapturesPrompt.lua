-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:01Z
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

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert

local CapturePromptItem = require(scriptParentParentParent.Components.CaptureService.CapturePromptItem)

local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffectOnce = RoactUtils.Hooks.useEffectOnce
local useLocalization = Localization.Hooks.useLocalization
local usePinInputStateWhileOpen = require(scriptParentParentParent.Hooks.usePinInputStateWhileOpen)
local useScreenSize = RobloxAppHooks.useScreenSize

local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local SaveCapturesPromptFinished = require(scriptParentParentParent.Thunks.SaveCapturesPromptFinished)
local _Types = require(scriptParentParentParent.Types)

local FFlagCapturePermissionsPromptFreeMouse = require(scriptParentParentParent.Flags.FFlagCapturePermissionsPromptFreeMouse)

local function func1(content) -- Luacid: Inlined by compiler; 4 call sites recovered
    return typeof(content) == "Content" and content.Object ~= nil and content.Object:IsA("VideoCapture")
end

local function func2(contents) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, content in contents do
        if func1(content) then
            return true
        end
    end
    return false
end

return function(tbl1)
    local var1 = useAnalytics()
    local var2 = useDispatch()
    local screenSize = useScreenSize()

    local var4, var5 = React.useState(Vector2.new(0, 0))
    local var6, var7 = React.useState(Vector2.new(0, 0))
    local var8, var9 = React.useState(1)
    local var10, var11 = React.useState({})

    local contents = tbl1.promptData.contents
    local var12 = tbl1.enableInputDelayed == nil or tbl1.enableInputDelayed
    local bool1 = func2(contents)
    local var13 = useLocalization({
        bodyText = "Feature.Captures.Body.SaveCapturesPrompt",
        no = "Feature.Captures.Action.NoThanks",
        title = "Feature.Captures.Title.SaveCapturesPrompt",
        yes = "Feature.Captures.Action.Save"
    })

    usePinInputStateWhileOpen(FFlagCapturePermissionsPromptFreeMouse)

    React.useEffect(function()
        var1.fireEvent(EventNames.SaveCapturesPromptViewed)
    end, {})

    React.useEffect(function()
        if bool1 then
            var1.fireEvent(EventNames.SaveCapturesPromptVideoPrompted)
        end
    end, { bool1 })

    useEffectOnce(function()
        local tbl2 = ({})
        for k, _ in contents do
            tbl2[k] = true
        end
        var11(tbl2)
    end, { contents })

    local updateSelected = React.useCallback(function(bool2: boolean)
        var11(function(arg1)
            local var14 = table.clone(arg1)
            var14[var8] = bool2
            return var14
        end)
    end, { var8 })

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var5(arg1.AbsoluteSize)
    end, { var5 })

    local var3 = React.useCallback(function(arg1)
        var7(arg1.AbsoluteSize)
    end, { var7 })

    local onActivated = React.useCallback(function()
        local num1 = 0
        local num2 = 0
        local bool2 = false

        local tbl2 = {}
        for value, value2 in var10 do
            tbl2[contents[value]] = value2
            if value2 then
                num1 += 1

                if func1(contents[value]) then
                    bool2 = true
                end
            end

            num2 += 1
        end

        if bool2 then
            var1.fireEvent(EventNames.SaveCapturesPromptVideoAccepted)
        end

        var1.fireEvent(EventNames.SaveCapturesPromptAccepted, { savedCaptures = num1, totalCaptures = num2 })

        var2(SaveCapturesPromptFinished(tbl1.promptId, tbl2))
    end, { tbl1.promptData, tbl1.promptId, var10 })

    local var14 = React.useCallback(function()
        if func2(tbl1.promptData.contents) then
            var1.fireEvent(EventNames.SaveCapturesPromptVideoRejected)
        end

        var1.fireEvent(EventNames.SaveCapturesPromptRejected)
        local tbl2 = ({})
        for _, content in tbl1.promptData.contents do
            tbl2[content] = false
        end
        var2(SaveCapturesPromptFinished(tbl1.promptId, tbl2))
    end, { tbl1.promptData, tbl1.promptId })

    local var15 = React.useCallback(function()
        var9(math.max(1, var8 - 1))
    end, { var8 })

    local var16 = React.useCallback(function()
        var9(math.min(#contents, var8 + 1))
    end, { contents, var8 })

    local buttonStackInfo = React.useMemo(function()
        return {
            buttons = {
                {
                    props = {
                        onActivated = var14,
                        text = var13.no
                    },
                    isDefaultChild = true
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        delayInputSeconds = 2,
                        enableInputDelayed = var12,
                        isDelayedInput = var12,
                        onActivated = onActivated,
                        text = var13.yes
                    },
                    isDefaultChild = false
                }
            }
        }
    end, { var13, onActivated, var14 })

    local middleContent = React.useCallback(function()
        local var22 = var4.Y - var6.Y
        local y = screenSize.Y - 80 - var22

        local createElement = React.createElement
        local var23 = View
        local tbl2 = {
            Size = UDim2.new(1, 0, 0, 200),
            sizeConstraint = {
                MaxSize = Vector2.new(math.huge, y)
            },
            onAbsoluteSizeChanged = var3
        }
        local tbl3 = {
            CapturePromptItem = React.createElement(
                CapturePromptItem,
                {
                    content = contents[var8],
                    isSelected = var10[var8],
                    showCheckbox = #contents > 1,
                    updateSelected = updateSelected
                }
            ),
            Overlay = React.createElement(View, {
                LayoutOrder = 2,
                tag = "padding-small size-full",
                ZIndex = 2
            }, {
                CountView = React.createElement(View, {
                    tag = "bg-over-media-0 anchor-top-left auto-xy clip padding-x-small padding-y-xsmall position-top-left radius-circle",
                    Visible = #contents > 1
                }, {
                    Count = React.createElement(
                        FoundationText,
                        {
                            tag = "auto-xy content-emphasis text-body-small",
                            Text = `{var8}/{#contents}`
                        }
                    )
                }),
                PrevCaptureButton = if var8 > 1 then React.createElement(
                    View,
                    {
                        tag = "bg-over-media-0 anchor-center-left auto-xy clip position-center-left radius-circle",
                        onActivated = var15
                    },
                    {
                        CycleLeftIcon = React.createElement(Icon, { name = "icons/actions/cycleLeft" })
                    }
                ) else nil,
                NextCaptureButton = if var8 < #contents then React.createElement(
                    View,
                    {
                        tag = "bg-over-media-0 anchor-center-right auto-xy clip position-center-right radius-circle",
                        onActivated = var16
                    },
                    {},
                    {
                        CycleRightIcon = React.createElement(Icon, { name = "icons/actions/cycleRight" })
                    }
                ) else nil
            })
        }
        return createElement(var23, tbl2, tbl3)
    end, {
        var4,
        contents,
        var6,
        var8,
        var3,
        var16,
        var15,
        screenSize,
        var10,
        updateSelected
    })

    return React.createElement(InteractiveAlert, {
        bodyText = var13.bodyText,
        buttonStackInfo = buttonStackInfo,
        isMiddleContentFocusable = false,
        middleContent = middleContent,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        position = UDim2.fromScale(0.5, 0.5),
        screenSize = screenSize,
        title = var13.title
    })
end
