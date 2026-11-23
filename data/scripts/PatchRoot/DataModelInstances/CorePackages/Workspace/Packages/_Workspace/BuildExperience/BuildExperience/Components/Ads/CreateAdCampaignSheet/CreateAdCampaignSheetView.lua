-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent
local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)
local InlineLayout = require(BuildExperienceParent.InlineLayout)

local Button = Foundation.Button
local Chip = Foundation.Chip
local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local OptionSelectorGroup = Foundation.OptionSelectorGroup
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View
local InlineLayout2 = InlineLayout.Components.InlineLayout
local LinkElement = InlineLayout.Components.InlineLayoutElements.LinkElement
local TextElement = InlineLayout.Components.InlineLayoutElements.TextElement

local CreateAdCampaignSheetConfig = require(script.Parent.CreateAdCampaignSheetConfig)
local FFlagBuildAdsUiPolish = require(BuildExperience.Flags.FFlagBuildAdsUiPolish)

local ButtonVariant = Foundation.Enums.ButtonVariant
local ChipSize = Foundation.Enums.ChipSize
local ChipVariant = Foundation.Enums.ChipVariant
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local OptionSelectorGroupSize = Foundation.Enums.OptionSelectorGroupSize
local useTokens = Foundation.Hooks.useTokens

local snapPoints = { 1 }
local tbl2 = {
    name = "u",
    attributes = {}
}

local function createLegalTextElement(text: string, fontStyle, textStyle)
    return TextElement.new({ Text = text, fontStyle = fontStyle, textStyle = textStyle })
end

local function createLegalElements(text: string, fontStyle, textStyle, onActivated: (...any) -> (...any), onActivated2: (...any) -> (...any))
    local tbl3 = {
        {
            startMarker = CreateAdCampaignSheetConfig.ADVERTISING_TERMS_START_MARKER,
            endMarker = CreateAdCampaignSheetConfig.ADVERTISING_TERMS_END_MARKER,
            onActivated = onActivated
        },
        {
            startMarker = CreateAdCampaignSheetConfig.ADVERTISING_STANDARDS_START_MARKER,
            endMarker = CreateAdCampaignSheetConfig.ADVERTISING_STANDARDS_END_MARKER,
            onActivated = onActivated2
        }
    }
    local num1 = 1
    local legalElements = {}

    while num1 <= #text do
        local var1 = nil
        local var2 = nil
        local var3 = nil
        for _, value in tbl3 do
            local var4, var5 = string.find(text, value.startMarker, num1, true)
            if var4 ~= nil and (var2 == nil or var4 < var2) then
                var3 = var5
                var1 = value
                var2 = var4
            end
        end

        if var1 == nil or var2 == nil or var3 == nil then
            table.insert(legalElements, createLegalTextElement(string.sub(text, num1), fontStyle, textStyle))
            return legalElements
        end
        if num1 < var2 then
            table.insert(legalElements, createLegalTextElement(string.sub(text, num1, var2 - 1), fontStyle, textStyle))
        end

        local var4, var5 = string.find(text, var1.endMarker, var3 + 1, true)
        if var4 == nil or var5 == nil then
            table.insert(legalElements, createLegalTextElement(string.sub(text, var2), fontStyle, textStyle))
            return legalElements
        end

        local str1 = string.sub(text, var3 + 1, var4 - 1)
        local onActivated3 = var1.onActivated
        table.insert(
            legalElements,
            LinkElement.new(
                { TextElement.new({ Text = str1, EngineTags = { tbl2 }, fontStyle = fontStyle, textStyle = textStyle }) },
                {
                    onActivated = function()
                        onActivated3(str1)
                    end
                }
            )
        )

        num1 = var5 + 1
    end

    return legalElements
end

local function AdCampaignLegalText(tbl3)
    local var1 = useTokens()
    local bodyMedium = var1.Typography.BodyMedium
    local elements = createLegalElements(
        tbl3.text,
        bodyMedium,
        var1.Color.Content.Default,
        tbl3.onAdvertisingTerms,
        tbl3.onAdvertisingStandards
    )

    return React.createElement(View, {
        LayoutOrder = tbl3.LayoutOrder,
        tag = "size-full-0 auto-y"
    }, {
        Layout = React.createElement(
            InlineLayout2,
            {
                Elements = elements,
                VerticalPadding = UDim.new(0, bodyMedium.FontSize * (bodyMedium.LineHeight - 1) / 2)
            }
        )
    })
end

local function createBenefitRows(benefits)
    local benefitRows = ({})
    for layoutOrder, benefit in benefits do
        local str1 = `Benefit{layoutOrder}`
        local createElement = React.createElement
        local var1 = View

        local tbl3 = {
            Icon = React.createElement(Icon, { LayoutOrder = 1, name = benefit.icon, size = IconSize.Large, tag = "content-emphasis" }),
            Label = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = benefit.text,
                tag = "fill auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
            })
        }
        benefitRows[str1] = createElement(
            var1,
            {
                LayoutOrder = layoutOrder,
                tag = "row align-y-center gap-xxlarge size-full-0 auto-y padding-y-xsmall"
            },
            tbl3
        )
    end

    return benefitRows
end

local function CampaignPrice(tbl3)
    local var1 = useTokens()

    if tbl3.option.originalPriceText == nil then
        return React.createElement(
            View,
            {
                LayoutOrder = 1,
                testId = tbl3.testId,
                tag = "row align-y-center gap-xxsmall auto-xy"
            },
            {
                Icon = React.createElement(Icon, {
                    LayoutOrder = 1,
                    name = Foundation.Enums.IconName.Robux,
                    size = IconSize.Small,
                    tag = "content-default",
                    testId = `{tbl3.testId}-robux-icon`
                }),
                Amount = React.createElement(
                    FoundationText,
                    {
                        LayoutOrder = 2,
                        Text = tbl3.option.priceText,
                        tag = "auto-xy text-body-medium content-default"
                    }
                )
            }
        )
    end
    return React.createElement(
        View,
        {
            LayoutOrder = 1,
            testId = tbl3.testId,
            tag = "row align-y-center gap-small auto-xy"
        },
        {
            OriginalPrice = React.createElement(View, { LayoutOrder = 1, tag = "auto-xy" }, {
                Content = React.createElement(View, {
                    ZIndex = 1,
                    tag = "row align-y-center gap-xxsmall auto-xy"
                }, {
                    Icon = React.createElement(Icon, {
                        LayoutOrder = 1,
                        name = Foundation.Enums.IconName.Robux,
                        size = IconSize.Small,
                        tag = "content-default",
                        testId = `{tbl3.testId}-robux-icon`
                    }),
                    Amount = React.createElement(
                        FoundationText,
                        {
                            LayoutOrder = 2,
                            Text = tbl3.option.originalPriceText,
                            tag = "auto-xy text-body-medium content-default"
                        }
                    )
                }),
                Strikethrough = React.createElement(View, {
                    ZIndex = 2,
                    tag = "position-center-left anchor-center-left",
                    Size = UDim2.new(1, 0, 0, 1),
                    backgroundStyle = var1.Color.Content.Default,
                    testId = `{tbl3.testId}-strikethrough`
                })
            }),
            Free = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl3.option.priceText,
                tag = "auto-xy text-title-medium content-emphasis",
                testId = `{tbl3.testId}-free`
            })
        }
    )
end

local function CampaignOptionItem(tbl3)
    local var1 = useTokens()
    local ref = React.useRef(nil)

    React.useImperativeHandle(tbl3.optionRef, function()
        return ref.current
    end)

    return React.createElement(View, {
        LayoutOrder = tbl3.LayoutOrder,
        tag = "size-full-0 auto-y"
    }, {
        Selector = React.createElement(OptionSelectorGroup.Item, {
            value = tbl3.option.value,
            label = tbl3.option.title,
            metadata = tbl3.option.runDates,
            description = tbl3.option.description,
            isDisabled = tbl3.isInteractionDisabled,
            ref = ref
        }),
        Price = React.createElement(
            View,
            {
                Position = UDim2.new(1, -var1.Padding.XLarge, 0, var1.Padding.XLarge),
                ZIndex = 2,
                tag = "anchor-top-right auto-xy"
            },
            {
                Content = React.createElement(CampaignPrice, { option = tbl3.option, testId = `{tbl3.testId}-price` })
            }
        )
    })
end

local function CreateAdCampaignSheetView(arg1)
    local var1 = useTokens()
    local bool1 = arg1.variant == "twoOptions"

    local yOffset = math.ceil(var1.Typography.CaptionSmall.FontSize * var1.Typography.CaptionSmall.LineHeight * 2)

    local yOffset2 = math.ceil(var1.Typography.CaptionMedium.FontSize * var1.Typography.CaptionMedium.LineHeight * 2)

    local str1 = if bool1 then "two-options-ad-campaign" else "create-ad-campaign"

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl3 = {
        isOpen = arg1.isOpen,
        ref = if bool1 then arg1.sheetRootRef else nil,
        preferCenterSheet = true,
        snapPoints = snapPoints,
        onClose = arg1.onClose,
        testId = if bool1 then "TwoOptionsAdCampaignSheet" else nil
    }
    local tbl4 = { Header = 0, Content = 0, Actions = 0 }
    local createElement2 = React.createElement
    local header = Sheet.Header
    local tbl5 = { hasCloseAffordance = false }

    local tbl6 = { HeaderRow = 0 }
    local createElement3 = React.createElement
    local var2 = View
    local tbl7 = {
        LayoutOrder = 1,
        tag = {
            ["row align-y-center size-full-0 auto-y"] = true,
            ["flex-between"] = not bool1 or arg1.showCloseButton,
            ["align-x-right"] = bool1 and not arg1.showCloseButton
        }
    }
    local tbl8 = {
        Close = if bool1 and not arg1.showCloseButton then nil else React.createElement(IconButton, {
            LayoutOrder = 1,
            icon = Foundation.Enums.IconName.X,
            size = InputSize.Large,
            variant = ButtonVariant.Utility,
            isDisabled = arg1.isCreatePending,
            onActivated = arg1.onClose,
            testId = if bool1 then `{str1}-close` else nil
        }),
        Balance = 0
    }
    local element2

    if FFlagBuildAdsUiPolish then
        element2 = React.createElement(Chip, {
            LayoutOrder = 2,
            text = arg1.balanceText,
            leading = Foundation.Enums.IconName.Robux,
            variant = ChipVariant.Standard,
            size = ChipSize.Medium,
            onActivated = not bool1 and function() end or arg1.onOpenBuyRobux,
            isDisabled = not bool1 or arg1.isCreatePending,
            testId = if bool1 then "two-options-ad-campaign-balance" else nil
        })
    else
        element2 = React.createElement(View, {
            LayoutOrder = 2,
            onActivated = if bool1 and not arg1.isCreatePending then arg1.onOpenBuyRobux else nil,
            tag = "row align-y-center gap-small auto-xy padding-right-small",
            testId = if bool1 then "two-options-ad-campaign-balance" else nil
        }, {
            Icon = React.createElement(Icon, {
                LayoutOrder = 1,
                name = Foundation.Enums.IconName.Robux,
                size = IconSize.Medium,
                tag = {
                    ["content-emphasis"] = arg1.balanceState == "ready",
                    ["content-muted"] = arg1.balanceState ~= "ready"
                }
            }),
            Amount = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = arg1.balanceText,
                tag = {
                    ["auto-xy text-label-medium"] = true,
                    ["content-emphasis"] = arg1.balanceState == "ready",
                    ["content-muted"] = arg1.balanceState ~= "ready"
                }
            })
        })
    end

    tbl8.Balance = element2
    tbl6.HeaderRow = createElement3(var2, tbl7, tbl8)
    tbl4.Header = createElement2(header, tbl5, tbl6)

    local createElement4 = React.createElement
    local content = Sheet.Content
    local var3 = nil
    local tbl9 = { Body = 0 }
    local createElement5 = React.createElement
    local var4 = View
    local tbl10 = {
        tag = {
            ["col size-full-0 auto-y"] = true,
            ["gap-large"] = not bool1,
            ["gap-xlarge"] = bool1
        }
    }
    local tbl11 = {
        Introduction = React.createElement(View, {
            LayoutOrder = 1,
            tag = "col gap-xxsmall size-full-0 auto-y"
        }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = arg1.title,
                tag = "size-full-0 auto-y text-heading-medium text-wrap text-align-x-left content-emphasis"
            }),
            Description = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = arg1.description,
                tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-left content-emphasis"
            })
        }),
        Campaign = 0,
        Disclaimer = 0,
        Included = 0,
        Legal = 0
    }
    local element3

    if bool1 then
        local createElement6 = React.createElement
        local var5 = View
        local tbl12 = { LayoutOrder = 2, tag = "col gap-medium size-full-0 auto-y" }

        local tbl13 = {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = arg1.startCampaignTitle,
                tag = "size-full-0 auto-y text-title-large text-wrap text-align-x-left content-emphasis"
            }),
            Options = 0
        }

        local createElement7 = React.createElement
        local root2 = OptionSelectorGroup.Root
        local tbl14 = {
            LayoutOrder = 2,
            value = arg1.selectedOption,
            onValueChanged = arg1.onOptionChanged,
            size = OptionSelectorGroupSize.Medium,
            Selectable = not arg1.isCreatePending,
            testId = "two-options-ad-campaign-options"
        }
        local tbl15 = {
            Feedback = if arg1.feedbackOption == nil then nil else React.createElement(CampaignOptionItem, {
                LayoutOrder = 1,
                option = arg1.feedbackOption,
                optionRef = if arg1.selectedOption == arg1.feedbackOption.value then arg1.defaultOptionRef else nil,
                isInteractionDisabled = arg1.isCreatePending,
                testId = "two-options-ad-campaign-feedback-option"
            }),
            Plays = if arg1.playsOption == nil then nil else React.createElement(CampaignOptionItem, {
                LayoutOrder = 2,
                option = arg1.playsOption,
                optionRef = if arg1.selectedOption == arg1.playsOption.value then arg1.defaultOptionRef else nil,
                isInteractionDisabled = arg1.isCreatePending,
                testId = "two-options-ad-campaign-plays-option"
            })
        }
        tbl13.Options = createElement7(root2, tbl14, tbl15)
        element3 = createElement6(var5, tbl12, tbl13)
    else
        element3 = React.createElement(View, {
            LayoutOrder = 2,
            tag = "row align-y-center gap-small size-full-0 auto-y padding-medium stroke-standard stroke-default radius-medium bg-surface-0"
        }, {
            Name = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = arg1.campaignTitle,
                tag = "fill auto-y text-label-large text-wrap text-align-x-left content-emphasis"
            }),
            Price = React.createElement(View, {
                LayoutOrder = 2,
                tag = "row align-y-center gap-small auto-xy"
            }, {
                Estimated = React.createElement(View, { LayoutOrder = 1, tag = "auto-xy" }, {
                    Content = React.createElement(View, {
                        ZIndex = 1,
                        tag = "row align-y-center gap-xxsmall auto-xy"
                    }, {
                        Icon = React.createElement(
                            Icon,
                            {
                                LayoutOrder = 1,
                                name = Foundation.Enums.IconName.Robux,
                                size = IconSize.Small,
                                tag = "content-default"
                            }
                        ),
                        Amount = React.createElement(
                            FoundationText,
                            {
                                LayoutOrder = 2,
                                Text = arg1.estimatedPriceText,
                                tag = "auto-xy text-body-large content-default"
                            }
                        )
                    }),
                    Strikethrough = React.createElement(View, {
                        ZIndex = 2,
                        tag = "position-center-left anchor-center-left",
                        Size = UDim2.new(1, 0, 0, var1.Stroke.Standard),
                        backgroundStyle = var1.Color.Content.Default,
                        testId = "create-ad-campaign-strikethrough"
                    })
                }),
                Free = React.createElement(
                    FoundationText,
                    {
                        LayoutOrder = 2,
                        Text = arg1.freeText,
                        tag = "auto-xy text-title-large content-emphasis"
                    }
                )
            })
        })
    end

    tbl11.Campaign = element3

    tbl11.Disclaimer = if bool1 then nil else React.createElement(FoundationText, {
        LayoutOrder = 3,
        Text = arg1.earnedRobuxDisclaimer,
        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default"
    })
    local element4

    if bool1 then
        element4 = nil
    else
        element4 = React.createElement(View, {
            LayoutOrder = 4,
            tag = "col gap-xxlarge size-full-0 auto-y padding-xlarge stroke-standard stroke-default radius-medium bg-surface-0"
        }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = arg1.includedTitle,
                tag = "size-full-0 auto-y text-title-large text-wrap text-align-x-left content-emphasis"
            }),
            Benefits = React.createElement(
                View,
                {
                    LayoutOrder = 2,
                    tag = "col gap-xxlarge size-full-0 auto-y padding-bottom-small padding-left-medium"
                },
                (createBenefitRows(arg1.benefits))
            )
        })
    end

    tbl11.Included = element4

    tbl11.Legal = React.createElement(AdCampaignLegalText, {
        LayoutOrder = 5,
        text = arg1.legalText,
        onAdvertisingTerms = arg1.onAdvertisingTerms,
        onAdvertisingStandards = arg1.onAdvertisingStandards
    })
    tbl9.Body = createElement5(var4, tbl10, tbl11)
    tbl4.Content = createElement4(content, var3, tbl9)

    local createElement6 = React.createElement
    local actions = Sheet.Actions
    local var5 = nil
    local tbl12 = { Footer = 0 }
    local createElement7 = React.createElement
    local var6 = View
    local tbl13 = { tag = "col gap-medium size-full-0 auto-y" }

    local tbl14 = {
        Error = if arg1.hasCreateError then React.createElement(FoundationText, {
            LayoutOrder = 0,
            Text = arg1.createErrorText,
            Size = if bool1 then UDim2.new(1, 0, 0, yOffset2) else nil,
            tag = {
                ["auto-y text-caption-medium text-wrap text-align-x-left text-align-y-bottom content-system-alert"] = bool1,
                ["size-full-0 auto-y text-caption-medium text-wrap text-align-x-left content-system-alert"] = not bool1
            },
            testId = `{str1}-create-error`
        }) else nil,
        AdCredits = 0,
        Create = 0,
        Moderation = 0
    }
    local element6

    if bool1 and arg1.showAdCreditsCallout then
        element6 = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "size-full-0 auto-y padding-bottom-small",
                testId = "two-options-ad-campaign-ad-credits"
            },
            {
                Link = React.createElement(View, {
                    onActivated = arg1.onOpenAdsManager,
                    tag = "row align-y-center size-full-0 auto-y padding-medium stroke-standard stroke-default radius-medium",
                    testId = "two-options-ad-campaign-ad-credits-link"
                }, {
                    Copy = React.createElement(View, {
                        LayoutOrder = 1,
                        tag = "col fill gap-xxsmall auto-y"
                    }, {
                        Title = React.createElement(FoundationText, {
                            LayoutOrder = 1,
                            Text = arg1.adCreditsTitle,
                            tag = "size-full-0 auto-y text-title-small text-wrap text-align-x-left content-emphasis"
                        }),
                        Description = React.createElement(FoundationText, {
                            LayoutOrder = 2,
                            Text = arg1.adCreditsAction,
                            tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-default"
                        })
                    }),
                    ExternalLink = React.createElement(Icon, {
                        LayoutOrder = 2,
                        name = Foundation.Enums.IconName.ArrowUpRightFromSquare,
                        size = IconSize.Small,
                        tag = "auto-xy content-emphasis",
                        testId = "two-options-ad-campaign-ad-credits-icon"
                    })
                })
            }
        )
    else
        element6 = nil
    end

    tbl14.AdCredits = element6

    tbl14.Create = React.createElement(Button, {
        LayoutOrder = 2,
        text = arg1.createText,
        size = InputSize.Medium,
        variant = ButtonVariant.Emphasis,
        width = UDim.new(1, 0),
        isDisabled = if bool1 then arg1.isCreateDisabled else nil,
        isLoading = arg1.isCreatePending or bool1 and arg1.isFundingCheckPending,
        onActivated = arg1.onCreate,
        testId = `{str1}-create-button`
    })
    tbl14.Moderation = React.createElement(FoundationText, {
        LayoutOrder = 3,
        Text = arg1.moderationNotice,
        Size = UDim2.new(1, 0, 0, yOffset),
        tag = "auto-y text-caption-small text-wrap text-align-x-left content-default",
        testId = `{str1}-moderation-notice`
    })
    tbl12.Footer = createElement7(var6, tbl13, tbl14)
    tbl4.Actions = createElement6(actions, var5, tbl12)
    return createElement(root, tbl3, tbl4)
end

return CreateAdCampaignSheetView
