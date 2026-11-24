-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

local RunService = game:GetService("RunService")
local LocalizationService = game:GetService("LocalizationService")
local TextService = game:GetService("TextService")

local React = require(GenericChallengesParent.React)

local InExperienceLocales = require(GenericChallengesParent.InExperienceLocales)

local Foundation = require(GenericChallengesParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local useTokens = Foundation.Hooks.useTokens

local normalizeFontFace = Foundation.Utility.normalizeFontFace

local FocusNavigationUtils = require(GenericChallengesParent.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceRegistry = FocusNavigationUtils.FocusNavigableSurfaceRegistry
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local ReactFocusNavigation = require(GenericChallengesParent.ReactFocusNavigation)

game:DefineFastInt("RoCaptchaLoadingStatePaintFrames", 5)

local function DialogContent(tbl1)
    local var1 = useTokens()

    local var2 = React.useMemo(function()
        return InExperienceLocales.Localization.new(LocalizationService.RobloxLocaleId)
    end, {})
    local text = var2:Format("Feature.RoCaptchaChallenge.Title.Challenge")
    local var3 = var2:Format("Feature.RoCaptchaChallenge.Content.JoinChallenge")
    local var4 = var2:Format("Feature.RoCaptchaChallenge.Action.Play")
    local var6 = var2:Format("Feature.RoCaptchaChallenge.Action.Cancel")

    local fastInt = game:GetFastInt("RoCaptchaLoadingStatePaintFrames")

    local var7 = React.useMemo(function()
        return tbl1.waitForFrame or function()
            for _ = 1, fastInt do
                RunService.Heartbeat:Wait()
            end
        end
    end, { tbl1.waitForFrame, fastInt })

    local var8, var9 = React.useState(false)
    local var10 = React.useRef(tbl1.onJoin)
    var10.current = tbl1.onJoin

    local var11 = React.useRef(false)

    local var12 = React.useCallback(function()
        var9(true)
    end, {})

    React.useEffect(function()
        if not var8 or var11.current then
            return
        end

        if fastInt == 0 then
            var11.current = true
            var10.current()
            return
        end
        local bool1 = false
        task.spawn(function()
            var7()
            if not (bool1 or var11.current) then
                var11.current = true
                var10.current()
            end
        end)
        return function()
            bool1 = true
        end
    end, { var8, var7, fastInt })

    local var13, var14 = React.useState(Vector2.zero)

    local xLarge = var1.Padding.XLarge
    local var15 = xLarge + var1.Padding.Medium
    local xOffset = math.min((if var13.X > 1 then var13.X else 390) - var15 * 2, 480)

    local headingMedium = var1.Typography.HeadingMedium
    local bodyMedium = var1.Typography.BodyMedium

    local labelMedium = var1.Typography.LabelMedium

    local var16 = React.useMemo(function()
        return normalizeFontFace(headingMedium.Font)
    end, { headingMedium.Font })
    local var17 = React.useMemo(function()
        return normalizeFontFace(bodyMedium.Font)
    end, { bodyMedium.Font })
    local var18 = React.useMemo(function()
        return normalizeFontFace(labelMedium.Font)
    end, { labelMedium.Font })

    local var19, var20 = React.useState(false)
    React.useEffect(function()
        local bool1 = false
        local function markReady() -- Luacid: Inlined by compiler; 1 call site recovered
            if not bool1 then
                var20(true)
            end
        end
        local tbl2 = {
            {
                font = var16,
                size = headingMedium.FontSize,
                text = text
            },
            {
                font = var17,
                size = bodyMedium.FontSize,
                text = var3
            },
            {
                font = var18,
                size = labelMedium.FontSize,
                text = var4
            }
        }

        task.spawn(function()
            pcall(function()
                for _, value in tbl2 do
                    if typeof(value.font) ~= "Font" then
                        continue
                    end

                    local getTextBoundsParams = Instance.new("GetTextBoundsParams")
                    getTextBoundsParams.Text = value.text
                    getTextBoundsParams.Font = value.font
                    getTextBoundsParams.Size = value.size
                    getTextBoundsParams.Width = 480
                    TextService:GetTextBoundsAsync(getTextBoundsParams)
                end
            end)

            markReady()
        end)

        task.delay(1.5, markReady)
        return function()
            bool1 = true
        end
    end, {
        var16,
        var17,
        var18,
        text,
        var3,
        var4,
        headingMedium.FontSize,
        bodyMedium.FontSize,
        labelMedium.FontSize
    })

    local surface100 = var1.Color.Surface.Surface_100
    local actionEmphasis = var1.Color.ActionEmphasis
    local actionStandard = var1.Color.ActionStandard
    local size1000 = var1.Size.Size_1000

    local createElement = React.createElement
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, size1000),
        BackgroundTransparency = 1,
        LayoutOrder = 3
    }

    local tbl3 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        CancelButton = React.createElement(
            "TextButton",
            {
                Size = UDim2.new(0.5, -4, 1, 0),
                BackgroundColor3 = actionStandard.Background.Color3,
                BackgroundTransparency = if var19 then actionStandard.Background.Transparency else 1,
                AutoButtonColor = true,
                Text = var6,
                TextColor3 = actionStandard.Foreground.Color3,
                TextTransparency = if var19 then 0 else 1,
                TextSize = labelMedium.FontSize,
                FontFace = var18,
                BorderSizePixel = 0,
                LayoutOrder = 1,
                [React.Event.Activated] = tbl1.onAbandon
            },
            {
                Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) })
            }
        ),
        JoinButton = 0
    }
    local createElement2 = React.createElement
    local tbl4 = {
        Size = UDim2.new(0.5, -4, 1, 0),
        BackgroundColor3 = actionEmphasis.Background.Color3,
        BackgroundTransparency = if var19 then if var8 then 0.5 else actionEmphasis.Background.Transparency else 1,
        AutoButtonColor = not var8,
        Active = not var8,
        Text = var4,
        TextColor3 = actionEmphasis.Foreground.Color3,
        TextTransparency = var19 and (if var8 then 0.5 else 0) or 1,
        TextSize = labelMedium.FontSize,
        FontFace = var18,
        BorderSizePixel = 0,
        LayoutOrder = 2
    }

    tbl4[React.Event.Activated] = function()
        if not var8 then
            var12()
        end
    end

    tbl3.JoinButton = createElement2(
        "TextButton",
        tbl4,
        {
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) })
        }
    )
    local footer = createElement("Frame", tbl2, tbl3)

    local createElement3 = React.createElement
    local fragment = React.Fragment
    local tbl5 = { Backdrop = 0, Card = 0 }
    local createElement4 = React.createElement
    local tbl6 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = var1.Color.Common.Backdrop.Color3,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        ZIndex = 1
    }

    tbl6[React.Change.AbsoluteSize] = function(arg1)
        var14(arg1.AbsoluteSize)
    end

    tbl5.Backdrop = createElement4("Frame", tbl6)

    tbl5.Card = React.createElement("Frame", {
        Size = UDim2.new(0, xOffset, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundColor3 = surface100.Color3,
        BackgroundTransparency = if var19 then surface100.Transparency else 1,
        BorderSizePixel = 0,
        ZIndex = 2
    }, {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Large) }),
        Stroke = React.createElement("UIStroke", {
            Color = var1.Color.Stroke.Default.Color3,
            Transparency = if var19 then var1.Color.Stroke.Default.Transparency else 1,
            Thickness = 1
        }),
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, xLarge),
            PaddingBottom = UDim.new(0, xLarge),
            PaddingLeft = UDim.new(0, xLarge),
            PaddingRight = UDim.new(0, xLarge)
        }),
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0, var1.Padding.Large),
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Title = React.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = text,
            TextColor3 = var1.Color.Content.Emphasis.Color3,
            TextTransparency = if var19 then 0 else 1,
            TextSize = headingMedium.FontSize,
            FontFace = var16,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 1
        }),
        Body = React.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = var3,
            TextColor3 = var1.Color.Content.Default.Color3,
            TextTransparency = if var19 then 0 else 1,
            TextSize = bodyMedium.FontSize,
            FontFace = var17,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 2
        }),
        Footer = footer
    })
    return createElement3(fragment, nil, tbl5)
end

local function RoCaptchaChallengeView(tbl1)
    local value = React.useMemo(function()
        return ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
    end, {})

    return React.createElement(
        "ScreenGui",
        {
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 200,
            IgnoreGuiInset = true,
            OnTopOfCoreBlur = true
        },
        {
            FoundationRoot = React.createElement(FoundationProvider, {
                colorMode = ColorMode.Dark
            }, {
                FocusNavigationProvider = React.createElement(
                    ReactFocusNavigation.FocusNavigationContext.Provider,
                    { value = value },
                    {
                        FocusNavigationRegistryProvider = React.createElement(FocusNavigableSurfaceRegistry.Provider, nil, {
                            FocusNavigableSurface = React.createElement(
                                FocusRoot,
                                {
                                    surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ModerationOverlay,
                                    isIsolated = true,
                                    isAutoFocusRoot = true
                                },
                                {
                                    Content = React.createElement(
                                        DialogContent,
                                        {
                                            onJoin = tbl1.onJoin,
                                            onAbandon = tbl1.onAbandon,
                                            waitForFrame = tbl1.waitForFrame
                                        }
                                    )
                                }
                            )
                        })
                    }
                )
            })
        }
    )
end

return RoCaptchaChallengeView
