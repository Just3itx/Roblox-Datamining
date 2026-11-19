-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local TweenService = game:GetService("TweenService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local TextService = game:GetService("TextService")
local GuiService = game:GetService("GuiService")
local LocalizationService = game:GetService("LocalizationService")
local VRService = game:GetService("VRService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local MouseIconOverrideService = require(CorePackages.Workspace.Packages.CoreScriptsCommon).MouseIconOverrideService
local Constants = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Constants
local Shimmer = require(RobloxGui.Modules.Shimmer)
local GetFFlagDisplayChannelNameOnErrorPrompt = require(RobloxGui.Modules.Flags.GetFFlagDisplayChannelNameOnErrorPrompt)

local FFlagLuaSupportMicroGamepadPreferredInput = require(CorePackages.Workspace.Packages.SharedFlags).FFlagLuaSupportMicroGamepadPreferredInput
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization

local fFlag = settings():GetFFlag("LocalizeErrorCodeString")

local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0)

local localization = Localization.new(LocalizationService.RobloxLocaleId)

local function attemptTranslate(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 3 call sites recovered
    local success, result = pcall(function()
        return localization:Format(arg1, arg3)
    end)
    if success then
        arg2 = result or arg2
    end

    return arg2
end

local tbl1 = {
    Default = function()
        return Create("Frame")({
            Name = "ErrorPrompt",
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            BackgroundColor3 = Constants.COLORS.FLINT,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, Constants.ERROR_PROMPT_MAX_WIDTH.Default, 0, Constants.ERROR_PROMPT_HEIGHT.Default),
            Visible = false,
            AutoLocalize = false,
            ZIndex = 8,
            Create("UIListLayout")(
                {
                    Name = "PromptLayout",
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center
                }
            ),
            Create("UIScale")({ Name = "PromptScale", Scale = 0 }),
            Create("Frame")({
                Name = "TitleFrame",
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, Constants.ERROR_TITLE_FRAME_HEIGHT.Default),
                BorderSizePixel = 0,
                ZIndex = 8,
                Create("UIPadding")({ Name = "TitleFramePadding", PaddingBottom = UDim.new(0, 11), PaddingTop = UDim.new(0, 11) }),
                Create("TextLabel")({
                    Name = "ErrorTitle",
                    TextColor3 = Constants.COLORS.WHITE,
                    TextSize = 25,
                    Size = UDim2.new(1, 0, 0, 28),
                    BackgroundTransparency = 1,
                    Font = Enum.Font.SourceSansSemibold,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    ZIndex = 8
                })
            }),
            Create("Frame")({
                Name = "SplitLine",
                LayoutOrder = 2,
                Size = UDim2.new(1, -2 * Constants.SIDE_PADDING, 0, Constants.SPLIT_LINE_THICKNESS),
                BackgroundColor3 = Constants.COLORS.PUMICE,
                BorderSizePixel = 0,
                ZIndex = 8
            }),
            Create("Frame")({
                Name = "MessageArea",
                LayoutOrder = 3,
                Size = UDim2.new(1, 0, 1, -Constants.ERROR_TITLE_FRAME_HEIGHT.Default - Constants.SPLIT_LINE_THICKNESS),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ZIndex = 8,
                Create("UIPadding")({
                    Name = "MessageAreaPadding",
                    PaddingBottom = UDim.new(0, Constants.SIDE_PADDING),
                    PaddingLeft = UDim.new(0, Constants.SIDE_PADDING),
                    PaddingRight = UDim.new(0, Constants.SIDE_PADDING),
                    PaddingTop = UDim.new(0, Constants.SIDE_PADDING)
                }),
                Create("Frame")({
                    Name = "ErrorFrame",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    ZIndex = 8,
                    Create("UIListLayout")({
                        Name = "ErrorFrameLayout",
                        Padding = UDim.new(0, Constants.LAYOUT_PADDING),
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }),
                    Create("TextLabel")({
                        Name = "ErrorMessage",
                        LayoutOrder = 1,
                        Size = UDim2.new(1, 0, 1, -Constants.BUTTON_HEIGHT - Constants.LAYOUT_PADDING),
                        TextSize = 20,
                        TextColor3 = Constants.COLORS.PUMICE,
                        ZIndex = 8,
                        BackgroundTransparency = 1,
                        TextWrapped = true,
                        Font = Enum.Font.SourceSans
                    }),
                    Create("Frame")({
                        Name = "ButtonArea",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, Constants.BUTTON_HEIGHT),
                        ZIndex = 8,
                        LayoutOrder = 2,
                        SelectionGroup = true,
                        SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
                        SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
                        SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
                        SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
                        Create("UIGridLayout")({
                            Name = "ButtonLayout",
                            CellPadding = UDim2.new(0, Constants.BUTTON_CELL_PADDING, 0, 0),
                            CellSize = UDim2.new(1, 0, 0, Constants.BUTTON_HEIGHT),
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            SortOrder = Enum.SortOrder.LayoutOrder
                        })
                    })
                })
            })
        })
    end
}

local tbl2 = {
    Default = function(text, layoutOrder, arg1)
        return Create("ImageButton")({
            Name = text .. "Button",
            BackgroundTransparency = 1,
            ImageColor3 = arg1 and Constants.COLORS.WHITE or Constants.COLORS.PUMICE,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.new(1, 0, 1, 0),
            Image = arg1 and Constants.PRIMARY_BUTTON_TEXTURE or Constants.SECONDARY_BUTTON_TEXTURE,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 8, 9, 9),
            LayoutOrder = layoutOrder,
            ZIndex = 8,
            Create("TextLabel")({
                Name = "ButtonText",
                Text = text,
                Size = UDim2.new(1, 0, 1, 0),
                TextColor3 = arg1 and Constants.COLORS.SLATE or Constants.COLORS.PUMICE,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                Font = Enum.Font.SourceSans,
                TextSize = 20,
                ZIndex = 8
            })
        })
    end
}

local module = {}
module.__index = module

function module.new(arg1, arg2)
    local self = setmetatable({}, module)
    self._frame = arg1 and tbl1[arg1]() or tbl1.Default()

    self._isOpen = false
    self._openAnimation = TweenService:Create(self._frame.PromptScale, tweenInfo, { Scale = 1 })
    self._closeAnimation = TweenService:Create(self._frame.PromptScale, tweenInfo, { Scale = 0 })

    self._buttonCount = 0
    self._playAnimation = true
    self._hideErrorCode = false
    self._menuIsOpenKey = "ErrorPrompt"

    if arg2 then
        if arg2.PlayAnimation ~= nil then
            self._playAnimation = arg2.PlayAnimation
        end

        if arg2.HideErrorCode ~= nil then
            self._hideErrorCode = arg2.HideErrorCode
        end

        if arg2.MenuIsOpenKey ~= nil then
            self._menuIsOpenKey = arg2.MenuIsOpenKey
        end

        self._frame.MessageArea.ErrorFrame.ErrorMessage.TextScaled = arg2.MessageTextScaled or false
    end

    if not VRService.VREnabled and UserInputService.GamepadEnabled then
        GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function()
            if self._isOpen and GuiService.SelectedCoreObject == nil then
                GuiService:Select(self._frame.MessageArea.ErrorFrame.ButtonArea)
            end
        end)
    end

    return self
end

local function sinkInput(_, _, _): Enum.ContextActionResult
    return Enum.ContextActionResult.Sink
end

function module:_open(arg1, arg2, arg3)
    self:setErrorText(arg1, arg2, arg3)
    self:_resizeHeight(RobloxGui.AbsoluteSize.Y)
    if not self._isOpen then
        MouseIconOverrideService.push("ErrorPromptOverride", Enum.OverrideMouseIconBehavior.ForceShow)
        GuiService:SetMenuIsOpen(true, self._menuIsOpenKey)
        self._frame.Visible = true
        self._isOpen = true
        if self._playAnimation then
            self._openAnimation:Play()
            self._openAnimation.Completed:wait()
            self._frame.PromptScale.Scale = 1
        else
            self._frame.PromptScale.Scale = 1
        end
    end

    if self._isOpen
        and (VRService.VREnabled
            or UserInputService.PreferredInput == Enum.PreferredInput.Gamepad
            or FFlagLuaSupportMicroGamepadPreferredInput and UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad)
    then
        GuiService:Select(self._frame.MessageArea.ErrorFrame.ButtonArea)
    end
    ContextActionService:BindCoreAction(
        "ErrorPromptAction",
        sinkInput,
        false,
        Enum.KeyCode.ButtonSelect,
        Enum.KeyCode.ButtonStart
    )
end

function module:_close()
    if not self._isOpen then
        return
    end

    MouseIconOverrideService.pop("ErrorPromptOverride")
    GuiService:SetMenuIsOpen(false, self._menuIsOpenKey)
    self._isOpen = false
    if self._playAnimation then
        self._closeAnimation:Play()
        self._closeAnimation.Completed:wait()
    else
        self._frame.PromptScale.Scale = 0
    end
    self._frame.Visible = false
    ContextActionService:UnbindCoreAction("ErrorPromptAction")
end

function module:setParent(arg1)
    self._frame.Parent = arg1
end

function module:setErrorText(errorMessageText, arg1, arg2)
    local errorMessage = self._frame.MessageArea.ErrorFrame.ErrorMessage
    local channelName = RunService:GetRobloxClientChannel()
    if self._hideErrorCode then
        errorMessage.Text = errorMessageText
        return
    end
    if fFlag then
        local var1 = if arg1 then arg1.Value else -1
        local var2 = attemptTranslate(
            "InGame.ConnectionError.Message.ErrorCode",
            ("Error Code: %d"):format(var1),
            {
                ERROR_CODE = tostring(var1)
            }
        )

        errorMessage.Text = (if GetFFlagDisplayChannelNameOnErrorPrompt() and arg2 and channelName then ("%s\n(%s, %s)"):format(
            errorMessageText,
            var2,
            localization:Format("InGame.ConnectionError.Message.ChannelName", { CHANNEL_NAME = channelName })
                or ("Channel: %s"):format(channelName)
        ) else nil)
            or ("%s\n(%s)"):format(errorMessageText, var2)
    elseif not arg1 then
        errorMessage.Text = ("%s\n(Error Code: -1)"):format(errorMessageText)
    else
        errorMessage.Text = ("%s\n(Error Code: %d)"):format(errorMessageText, arg1.Value)
    end
end

function module:setErrorTitle(errorTitleText, arg1)
    if not errorTitleText then
        return
    end
    local errorTitle = self._frame.TitleFrame.ErrorTitle
    if arg1 then
        errorTitle.Text = attemptTranslate(arg1, errorTitleText, nil)
        return
    end
    errorTitle.Text = errorTitleText
end

function module.onErrorChanged(arg1, arg2, arg3, arg4)
    if arg2 == "" then
        arg1:_close()
    elseif arg2 ~= "" then
        arg1:_open(arg2, arg3, arg4)
    end
end

function module:_relayout()
    local buttonArea = self._frame.MessageArea.ErrorFrame.ButtonArea
    if self._buttonCount == 0 then
        buttonArea.Visible = false
        return
    end
    local xOffset = (self._frame.Size.X.Offset - (self._buttonCount - 1) * Constants.BUTTON_CELL_PADDING - 2 * Constants.SIDE_PADDING) / self._buttonCount
    buttonArea.Visible = true
    buttonArea.ButtonLayout.CellSize = UDim2.new(0, xOffset, 0, Constants.BUTTON_HEIGHT)
end

function module:clearButtons()
    local buttonArea = self._frame.MessageArea.ErrorFrame.ButtonArea
    if self._primaryShimmer then
        self._primaryShimmer = nil
    end
    local children = buttonArea:GetChildren()
    for _, child in pairs(children) do
        if child.name ~= "ButtonLayout" then
            child:Destroy()
        end
    end
end

function module:updateButtons(arg1, arg2)
    arg2 = arg2 or "Default"

    self:clearButtons()

    local buttonArea = self._frame.MessageArea.ErrorFrame.ButtonArea

    local num1 = 0

    for _, value in pairs(arg1 or {}) do
        local valueText = value.Text
        if value.LocalizationKey then
            valueText = attemptTranslate(value.LocalizationKey, value.Text, nil)
        end
        local var1 = tbl2[arg2](valueText, value.LayoutOrder, value.Primary)
        if value.Primary then
            self._primaryShimmer = Shimmer.new(var1, "PrimaryButton")
        end
        var1.Parent = buttonArea
        var1.Activated:connect(value.Callback)
        num1 += 1
    end

    if self._buttonCount ~= num1 then
        self._buttonCount = num1
        self:_relayout()
    end
end

function module.primaryShimmerPlay(arg1)
    if arg1._primaryShimmer then
        arg1._primaryShimmer:play()
    end
end

function module.primaryShimmerStop(arg1)
    if arg1._primaryShimmer then
        arg1._primaryShimmer:stop()
    end
end

function module.resizeWidthAndHeight(arg1, arg2, arg3)
    arg1:_resizeWidth(arg2)
    arg1:_resizeHeight(arg3)
    arg1:_relayout()
end

function module:_resizeWidth(arg1)
    local offset = self._frame.Size.X.Offset
    local xOffset = arg1 - 2 * Constants.SIDE_MARGIN

    if Constants.ERROR_PROMPT_MAX_WIDTH.Default < xOffset then
        if offset == Constants.ERROR_PROMPT_MAX_WIDTH.Default then
            return
        end
        xOffset = Constants.ERROR_PROMPT_MAX_WIDTH.Default
    end

    if xOffset < Constants.ERROR_PROMPT_MIN_WIDTH.Default then
        if offset == Constants.ERROR_PROMPT_MIN_WIDTH.Default then
            return
        end
        xOffset = Constants.ERROR_PROMPT_MIN_WIDTH.Default
    end

    self._frame.Size = UDim2.new(0, xOffset, 0, self._frame.Size.Y.Offset)
end

function module:_resizeHeight(arg1)
    local errorMessage = self._frame.MessageArea.ErrorFrame.ErrorMessage
    local vector2 = Vector2.new(self._frame.Size.X.Offset - 2 * Constants.SIDE_PADDING, 1000)
    local vector2_2 = TextService:GetTextSize(errorMessage.Text, errorMessage.TextSize, errorMessage.Font, vector2)

    local yOffset = math.max(
        math.min(
            Constants.ERROR_TITLE_FRAME_HEIGHT.Default + vector2_2.Y + Constants.SPLIT_LINE_THICKNESS + Constants.BUTTON_HEIGHT + Constants.LAYOUT_PADDING + 2 * Constants.SIDE_PADDING + 1,
            arg1 - 2 * Constants.VERTICAL_MARGIN
        ),
        Constants.ERROR_PROMPT_MIN_HEIGHT.Default
    )
    self._frame.Size = UDim2.new(0, self._frame.Size.X.Offset, 0, yOffset)
end

return module
