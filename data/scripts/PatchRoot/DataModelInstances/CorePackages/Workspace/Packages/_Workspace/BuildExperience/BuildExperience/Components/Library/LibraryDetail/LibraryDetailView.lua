-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local ChatActions = require(BuildExperience.Components.Chat.ChatActions)
local FFlagBuildExperienceAnswerForm = require(BuildExperience.Flags.FFlagBuildExperienceAnswerForm)
local AnswerFormContainer = if FFlagBuildExperienceAnswerForm then require(BuildExperience.Components.AnswerForm.AnswerFormContainer) else nil
local _ChatComposer = require(BuildExperience.Components.Chat.ChatComposer)
local _LibraryTypes = require(BuildExperience.Components.Library.LibraryTypes)
local ModelViewport = require(BuildExperience.Components.Library.ModelViewport)
local LibraryAudioPlayerContainer = require(BuildExperience.Components.Library.LibraryAudioPlayer.LibraryAudioPlayerContainer)
local useHardwareInsets = require(BuildExperience.Components.ChatSheet.useHardwareInsets)
local FFlagBuildExperienceLibrary = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceLibrary

local Image = Foundation.Image
local Skeleton = Foundation.Skeleton
local ScrollView = Foundation.ScrollView
local FoundationText = Foundation.Text
local View = Foundation.View

local Radius = Foundation.Enums.Radius

local function LibraryDetailView(tbl1)
    local bottom = useHardwareInsets().bottom
    local var1, var2, var3

    if FFlagBuildExperienceAnswerForm then
        var1 = Foundation.Hooks.useScaledValue(400)
        local var4
        var2, var4 = React.useBinding(0)
        var3 = var4
    else
        var1 = nil
        var2 = nil
        var3 = nil
    end
    local isCompact, var5 = React.useState(false)
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var5(arg1.AbsoluteSize.Y < 400)
    end, {})
    local textBoxRef = React.useRef(nil)
    local var8 = if tbl1.chatActions == nil then nil else table.clone(tbl1.chatActions)

    if var8 ~= nil then
        var8.textBoxRef = textBoxRef
        var8.allowsTypingWhileResponding = true

        if FFlagBuildExperienceLibrary then
            var8.onRemoveResourceAttachment = nil
        end
        local onSend = var8.onSend
        function var8.onSend()
            local var9 = onSend()
            if var9 and textBoxRef.current ~= nil then
                textBoxRef.current.releaseFocus()
            end
            return var9
        end
    end
    local bool1 = FFlagBuildExperienceAnswerForm

    if bool1 then
        if tbl1.isActive == false or var8 == nil then
            bool1 = false
        else
            bool1 = var8.answerForm ~= nil
        end
    end

    local liveModel = tbl1.liveModel
    local title = if liveModel ~= nil then liveModel.displayName else tbl1.modelName or ""
    local element

    if tbl1.status == "Ready" and liveModel ~= nil then
        element = React.createElement(View, {
            tag = "col size-full clip",
            testId = "Library.Preview.ModelRegion"
        }, {
            Viewport = React.createElement(
                View,
                {
                    LayoutOrder = 1,
                    tag = "fill size-full-0 clip",
                    testId = "Library.Preview.ViewportRegion"
                },
                {
                    Model = React.createElement(ModelViewport, {
                        model = liveModel.model,
                        size = UDim2.fromScale(1, 1),
                        backgroundTransparency = 1,
                        cameraDistanceScale = 1.25,
                        isInteractive = tbl1.isActive ~= false,
                        testId = "Library.Preview.Model",
                        unavailableText = tbl1.unavailableText
                    })
                }
            )
        })
    elseif tbl1.status == "Ready" and tbl1.image ~= nil then
        if tbl1.imageLoadFailed then
            element = React.createElement(FoundationText, {
                Text = tbl1.unavailableText,
                tag = "size-full-0 auto-y padding-large text-body-medium text-align-x-center content-default"
            })
        else
            element = React.createElement(Image, {
                Image = tbl1.image,
                onLoaded = tbl1.onImageLoaded,
                ScaleType = Enum.ScaleType.Fit,
                tag = "size-full",
                testId = "Library.Preview.Image"
            })
        end
    elseif tbl1.status == "Ready" and tbl1.soundId ~= nil then
        local createElement = React.createElement
        local var10 = ScrollView
        local tbl2 = {
            tag = "size-full clip",
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.fromOffset(0, 0),
                ScrollingDirection = Enum.ScrollingDirection.Y
            },
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            testId = "Library.Preview.Sound"
        }

        local tbl3 = {
            Content = React.createElement(
                View,
                {
                    tag = "col align-x-center align-y-center size-full auto-y padding-x-large padding-y-medium"
                },
                {
                    [tbl1.soundId] = React.createElement(LibraryAudioPlayerContainer, {
                        soundId = tbl1.soundId,
                        unavailableText = tbl1.unavailableText,
                        soundLabel = tbl1.soundLabel,
                        title = title,
                        isActive = tbl1.isActive,
                        isCompact = isCompact
                    })
                }
            )
        }
        element = createElement(var10, tbl2, tbl3)
    elseif tbl1.status == "Failed" then
        element = React.createElement(FoundationText, {
            Text = tbl1.unavailableText,
            tag = "size-full-0 auto-y padding-large text-body-medium text-align-x-center content-default"
        })
    else
        element = React.createElement(
            View,
            {
                tag = "col align-x-center gap-large size-full-0 auto-y padding-y-xlarge",
                testId = "Library.Preview.Skeleton"
            },
            {
                Preview = React.createElement(Skeleton, { Size = UDim2.fromOffset(320, 320), radius = Radius.Medium })
            }
        )
    end

    local createElement = React.createElement
    local var10 = View
    local tbl2 = {
        onAbsolutePositionChanged = tbl1.onPageMetricsChanged,
        onAbsoluteSizeChanged = tbl1.onPageMetricsChanged,
        padding = {
            bottom = UDim.new(0, math.max(tbl1.keyboardOverlap or 0, bottom))
        },
        tag = "col size-full",
        testId = "Library.Preview"
    }

    local tbl3 = {
        Content = React.createElement(View, { LayoutOrder = 1, tag = "fill size-full-0" }, { Body = element }),
        Description = if tbl1.description == nil or tbl1.status ~= "Ready" then nil else React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "col size-full-0 auto-y padding-x-xlarge padding-bottom-xlarge padding-top-medium"
            },
            {
                Text = React.createElement(FoundationText, {
                    Text = tbl1.description,
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-muted",
                    testId = "Library.Preview.Description"
                })
            }
        ),
        AnswerForm = 0,
        Composer = 0
    }
    local element2

    if bool1 then
        element2 = React.createElement(
            ScrollView,
            {
                LayoutOrder = 3,
                Size = var2:map(function(num1: number): UDim2
                    return UDim2.new(1, 0, 0, math.min(num1, var1))
                end),
                onAbsoluteCanvasSizeChanged = function(arg1)
                    var3(arg1.AbsoluteCanvasSize.Y)
                end,
                tag = "shrink size-full-0 padding-x-medium",
                scroll = {
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    CanvasSize = UDim2.new(),
                    ScrollingDirection = Enum.ScrollingDirection.Y
                },
                testId = "Library.Preview.AnswerFormScroll"
            },
            React.createElement(AnswerFormContainer, {
                state = var8.answerForm,
                actions = var8.localToolActions,
                onSubmitText = var8.onSubmitAnswerText,
                onStop = var8.onStop,
                errorText = var8.composerErrorText,
                isReadOnly = var8.isReadOnly
            })
        )
    else
        element2 = nil
    end

    tbl3.AnswerForm = element2

    tbl3.Composer = if var8 == nil or tbl1.isActive == false or bool1 then nil else React.createElement(
        View,
        {
            LayoutOrder = 3,
            tag = "col size-full-0 auto-y padding-x-medium padding-bottom-medium",
            testId = "Library.Preview.Composer"
        },
        {
            Actions = React.createElement(ChatActions, var8)
        }
    )
    return (createElement(var10, tbl2, tbl3))
end

return LibraryDetailView
