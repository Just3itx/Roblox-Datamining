-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

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

local DeniedPrompt = require(script.Parent.DeniedMetadata).DeniedPrompt

local tbl1 = {
    [DeniedPrompt.WasmGameJoinRedirect] = {
        title = "Feature.Denied.Denied.Wasm.GameJoin.Header",
        body = "Feature.Denied.Denied.Wasm.GameJoin.Body"
    },
    [DeniedPrompt.WasmInExpDeny] = {
        title = "Feature.Denied.Denied.Wasm.InExperienceFeature.Header",
        body = "Feature.Denied.Denied.Wasm.InExperienceFeature.Body"
    }
}

local function getCopy(prompt: string?, arg1)
    local var1 = if prompt then tbl1[prompt] else nil

    if var1 then
        return {
            title = arg1:Format(var1.title),
            body = arg1:Format(var1.body)
        }
    end

    return {
        title = arg1:Format("Feature.Denied.Denied.Header"),
        body = arg1:Format("Feature.Denied.Denied.Body")
    }
end

local function DialogContent(tbl2)
    local var1 = useTokens()

    local var2 = React.useMemo(function()
        return InExperienceLocales.Localization.new(LocalizationService.RobloxLocaleId)
    end, {})
    local copy = getCopy(tbl2.prompt, var2)
    local title = copy.title
    local body = copy.body
    local text = var2:Format("Feature.Denied.Denied.Action")

    local var4, var5 = React.useState(Vector2.zero)
    local xLarge = var1.Padding.XLarge
    local var6 = xLarge + var1.Padding.Medium
    local xOffset = math.min((if var4.X > 1 then var4.X else 390) - var6 * 2, 480)

    local headingMedium = var1.Typography.HeadingMedium
    local bodyMedium = var1.Typography.BodyMedium

    local labelMedium = var1.Typography.LabelMedium

    local var7 = React.useMemo(function()
        return normalizeFontFace(headingMedium.Font)
    end, { headingMedium.Font })
    local var8 = React.useMemo(function()
        return normalizeFontFace(bodyMedium.Font)
    end, { bodyMedium.Font })
    local var9 = React.useMemo(function()
        return normalizeFontFace(labelMedium.Font)
    end, { labelMedium.Font })

    local var10, var11 = React.useState(false)
    React.useEffect(function()
        local bool1 = false
        local function markReady() -- Luacid: Inlined by compiler; 1 call site recovered
            if not bool1 then
                var11(true)
            end
        end
        local tbl3 = {
            {
                font = var7,
                size = headingMedium.FontSize,
                text = title
            },
            {
                font = var8,
                size = bodyMedium.FontSize,
                text = body
            },
            {
                font = var9,
                size = labelMedium.FontSize,
                text = text
            }
        }

        task.spawn(function()
            pcall(function()
                for _, value in tbl3 do
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
        var7,
        var8,
        var9,
        title,
        body,
        text,
        headingMedium.FontSize,
        bodyMedium.FontSize,
        labelMedium.FontSize
    })

    local surface100 = var1.Color.Surface.Surface_100
    local actionEmphasis = var1.Color.ActionEmphasis

    local createElement = React.createElement
    local tbl3 = {
        Size = UDim2.new(1, 0, 0, var1.Size.Size_1000),
        BackgroundTransparency = 1,
        LayoutOrder = 3
    }

    local tbl4 = {
        OkButton = React.createElement(
            "TextButton",
            {
                Size = UDim2.fromScale(1, 1),
                BackgroundColor3 = actionEmphasis.Background.Color3,
                BackgroundTransparency = if var10 then actionEmphasis.Background.Transparency else 1,
                AutoButtonColor = true,
                Text = text,
                TextColor3 = actionEmphasis.Foreground.Color3,
                TextTransparency = if var10 then 0 else 1,
                TextSize = labelMedium.FontSize,
                FontFace = var9,
                BorderSizePixel = 0,
                [React.Event.Activated] = tbl2.onAcknowledge
            },
            {
                Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) })
            }
        )
    }
    local footer = createElement("Frame", tbl3, tbl4)

    local createElement2 = React.createElement
    local fragment = React.Fragment
    local tbl5 = { Backdrop = 0, Card = 0 }
    local createElement3 = React.createElement
    local tbl6 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = var1.Color.Common.Backdrop.Color3,
        BackgroundTransparency = if tbl2.opaqueBackdrop then 0 else var1.Color.Common.Backdrop.Transparency,
        BorderSizePixel = 0,
        ZIndex = 1
    }

    tbl6[React.Change.AbsoluteSize] = function(arg1)
        var5(arg1.AbsoluteSize)
    end

    tbl5.Backdrop = createElement3("Frame", tbl6)

    tbl5.Card = React.createElement("Frame", {
        Size = UDim2.new(0, xOffset, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundColor3 = surface100.Color3,
        BackgroundTransparency = if var10 then surface100.Transparency else 1,
        BorderSizePixel = 0,
        ZIndex = 2
    }, {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Large) }),
        Stroke = React.createElement("UIStroke", {
            Color = var1.Color.Stroke.Default.Color3,
            Transparency = if var10 then var1.Color.Stroke.Default.Transparency else 1,
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
            Text = title,
            TextColor3 = var1.Color.Content.Emphasis.Color3,
            TextTransparency = if var10 then 0 else 1,
            TextSize = headingMedium.FontSize,
            FontFace = var7,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 1
        }),
        Body = React.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = body,
            TextColor3 = var1.Color.Content.Default.Color3,
            TextTransparency = if var10 then 0 else 1,
            TextSize = bodyMedium.FontSize,
            FontFace = var8,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 2
        }),
        Footer = footer
    })
    return createElement2(fragment, nil, tbl5)
end

local function DeniedChallengeView(tbl2)
    local value = React.useMemo(function()
        return ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
    end, {})

    React.useEffect(function()
        return function()
            value:teardown()
        end
    end, { value })

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
                                            prompt = tbl2.prompt,
                                            onAcknowledge = tbl2.onAcknowledge,
                                            opaqueBackdrop = tbl2.opaqueBackdrop
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

return DeniedChallengeView
