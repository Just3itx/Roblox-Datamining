-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local useSelector = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useSelector
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization

local _MarketplaceOffersBannerTypes = require(AvatarExperienceCatalog.Api.GetMarketplaceOffersBanner.MarketplaceOffersBannerTypes)
local getFoundationIconName = require(script.Parent.getFoundationIconName)

local AXPartialPageModal = AvatarExperienceCommon.Components.AXPartialPageModal

local useTokens = Foundation.Hooks.useTokens
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local FFlagAXPartialPageModalBackgroundShim = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXPartialPageModalBackgroundShim
local bool1 = game:DefineFastFlag("AXUpdateOffersModalHero", false)

local uDim2 = UDim2.new(0.5, -82, 0.5, 12)

local uDim2_2 = UDim2.new(0.5, 92, 0.5, -19)

local num1 = if bool1 then 230 else 540

local function selectScreenSize(arg1)
    return arg1.ScreenSize
end

local function getTermsScrollHeight(vector2: Vector2): number -- Luacid: Inlined by compiler; 1 call site recovered
    local bool2 = vector2.X < 540
    return math.clamp(math.floor(vector2.Y * (if bool2 then 0.35 else 0.5)), 180, if bool2 then 280 else num1)
end

local function RichTextBlock(tbl1)
    return React.createElement(
        Foundation.Text,
        {
            tag = tbl1.tag,
            Text = tbl1.segment,
            RichText = true,
            LayoutOrder = tbl1.layoutOrder
        }
    )
end

local function HeroFrame(tbl1)
    local var1 = useTokens()

    return React.createElement(Foundation.View, {
        testId = tbl1.testId,
        tag = "bg-surface-100 stroke-standard stroke-emphasis",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = tbl1.position,
        Size = UDim2.fromOffset(tbl1.framePx, tbl1.framePx),
        Rotation = tbl1.rotation,
        ZIndex = tbl1.zIndex,
        cornerRadius = UDim.new(0, var1.Radius.Small)
    }, {
        IconCenter = React.createElement(Foundation.View, {
            tag = "size-full col align-x-center align-y-center"
        }, {
            Glyph = React.createElement(Foundation.Icon, {
                testId = `{tbl1.testId}Icon`,
                name = tbl1.iconName,
                variant = IconVariant.Regular,
                size = tbl1.iconSize,
                style = var1.Color.Content.Emphasis
            })
        })
    })
end

local function CatalogOffersBannerOfferModals(tbl1)
    local var1 = useTokens()
    local var2 = useLocalization({ viewTermsButtonText = "Feature.Catalog.Action.ViewTerms" })

    local modal = tbl1.modal
    local onOpenTermsModal = tbl1.onOpenTermsModal
    local termsBody = modal.termsBody
    local bool2 = not (termsBody == nil) and termsBody ~= ""
    local segment = if bool2 then modal.offerBodyLinkText .. " " else modal.offerBodyLinkText
    local termsScrollHeight = getTermsScrollHeight((useSelector(selectScreenSize)))

    local body = React.createElement(
        Foundation.View,
        { tag = "row wrap align-x-left align-y-top gap-xsmall size-full-0 auto-y" },
        {
            Body = if segment == "" then nil else React.createElement(
                RichTextBlock,
                {
                    segment = segment,
                    tag = "auto-xy text-body-medium text-wrap text-align-x-left",
                    layoutOrder = 1
                }
            ),
            TermsLink = if bool2 then React.createElement(Foundation.Text, {
                tag = "auto-xy text-body-medium text-wrap text-align-x-left content-muted",
                Text = `<u>{var2.viewTermsButtonText}</u>`,
                RichText = true,
                onActivated = onOpenTermsModal,
                LayoutOrder = 2
            }) else nil
        }
    )
    local var4

    if tbl1.offersModalOpen then
        local createElement = React.createElement
        local var5 = AXPartialPageModal
        local tbl2 = {
            visible = true,
            onBackgroundPress = tbl1.onCloseOffersModal,
            hasBackgroundShim = if FFlagAXPartialPageModalBackgroundShim then true else nil,
            buttonStackProps = {
                rowLayout = false,
                buttons = {{
                    props = {
                        text = tbl1.okButtonText,
                        variant = ButtonVariant.Emphasis,
                        size = InputSize.Medium,
                        onActivated = tbl1.onCloseOffersModal
                    }
                }}
            }
        }

        local tbl3 = { ViewFrame = 0 }
        local createElement2 = React.createElement
        local view = Foundation.View
        local tbl4 = {
            tag = {
                ["col align-x-left align-y-top size-full-0 auto-y"] = true,
                ["padding-bottom-xxlarge"] = bool1,
                ["padding-y-xxlarge"] = not bool1
            }
        }
        local tbl5 = { Contents = 0 }
        local createElement3 = React.createElement
        local view2 = Foundation.View
        local tbl6 = {
            tag = {
                ["col align-x-left gap-medium size-full-0 auto-y"] = true,
                ["padding-y-xlarge"] = not bool1
            }
        }
        local tbl7 = { HeroIcon = 0, ModalTitle = 0, ModalBody = 0 }
        local createElement4 = React.createElement
        local view3 = Foundation.View
        local tbl8 = {
            tag = {
                ["row align-x-center align-y-center auto-y"] = true,
                ["padding-bottom-xxlarge"] = bool1
            },
            LayoutOrder = 0,
            Size = UDim2.new(1, 0, 0, 136)
        }
        local tbl9 = { HeroIconSlot = 0 }
        local createElement5 = React.createElement
        local view4 = Foundation.View
        local tbl10 = {
            Size = UDim2.fromOffset(136, 136),
            BackgroundTransparency = 1
        }
        local tbl11 = { TiltedSquare = 0, HeroFrameLeft = 0, HeroFrameRight = 0, HeroFrame = 0 }
        local element2

        if bool1 then
            element2 = nil
        else
            element2 = React.createElement(Foundation.View, {
                Size = UDim2.fromOffset(108, 108),
                BackgroundTransparency = 1,
                Rotation = -15,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                cornerRadius = UDim.new(0, var1.Radius.Small),
                stroke = {
                    Color = var1.Color.Content.Emphasis.Color3,
                    Thickness = var1.Stroke.Standard,
                    Transparency = 0.84
                }
            }, {
                IconCounterRotate = React.createElement(
                    Foundation.View,
                    { tag = "size-full", BackgroundTransparency = 1, Rotation = 15 },
                    {
                        Icon = React.createElement(Foundation.Icon, {
                            name = getFoundationIconName(modal.modalHeroIcon),
                            variant = IconVariant.Regular,
                            size = 64,
                            style = var1.Color.Content.Emphasis,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.fromScale(0.5, 0.5)
                        })
                    }
                )
            })
        end

        tbl11.TiltedSquare = element2

        tbl11.HeroFrameLeft = if bool1 then React.createElement(HeroFrame, {
            framePx = 74,
            position = uDim2,
            rotation = 15,
            zIndex = 1,
            iconName = IconName.Shirt,
            iconSize = var1.Size.Size_1200,
            testId = "CatalogOffersModalHeroFrameLeft"
        }) else nil

        tbl11.HeroFrameRight = if bool1 then React.createElement(HeroFrame, {
            framePx = 84,
            position = uDim2_2,
            rotation = 15,
            zIndex = 1,
            iconName = IconName.Shoe,
            iconSize = var1.Size.Size_1200,
            testId = "CatalogOffersModalHeroFrameRight"
        }) else nil

        tbl11.HeroFrame = if bool1 then React.createElement(HeroFrame, {
            framePx = var1.Size.Size_2600,
            position = UDim2.fromScale(0.5, 0.5),
            rotation = -15,
            zIndex = 2,
            iconName = getFoundationIconName(modal.modalHeroIcon),
            iconSize = var1.Size.Size_1600,
            testId = "CatalogOffersModalHeroFrame"
        }) else nil
        tbl9.HeroIconSlot = createElement5(view4, tbl10, tbl11)
        tbl7.HeroIcon = createElement4(view3, tbl8, tbl9)

        tbl7.ModalTitle = React.createElement(Foundation.Text, {
            tag = "size-full-0 auto-xy padding-bottom-small text-heading-small text-wrap text-align-x-left",
            Text = modal.modalTitle,
            LayoutOrder = 1
        })

        tbl7.ModalBody = React.createElement(Foundation.View, { tag = "size-full-0 auto-y", LayoutOrder = 2 }, { Body = body })
        tbl5.Contents = createElement3(view2, tbl6, tbl7)
        tbl3.ViewFrame = createElement2(view, tbl4, tbl5)
        var4 = createElement(var5, tbl2, tbl3)
    else
        var4 = nil
    end

    local var5

    if tbl1.termsModalOpen and bool2 then
        local createElement = React.createElement
        local var6 = AXPartialPageModal
        local tbl2 = {
            visible = true,
            onBackgroundPress = tbl1.onCloseTermsModal,
            hasBackgroundShim = if FFlagAXPartialPageModalBackgroundShim then true else nil,
            buttonStackProps = {
                rowLayout = false,
                buttons = {{
                    props = {
                        text = tbl1.okButtonText,
                        variant = ButtonVariant.Standard,
                        size = InputSize.Medium,
                        onActivated = tbl1.onCloseTermsModal
                    }
                }}
            }
        }

        local tbl3 = {
            ViewFrame = React.createElement(Foundation.View, {
                tag = {
                    ["col align-x-left gap-medium size-full-0 auto-y"] = true,
                    ["padding-bottom-large"] = bool1,
                    ["padding-y-large"] = not bool1
                }
            }, {
                TermsTitle = if modal.termsModalTitle then React.createElement(Foundation.Text, {
                    tag = "size-full-0 auto-xy text-heading-small text-wrap text-align-x-left",
                    Text = modal.termsModalTitle,
                    LayoutOrder = 1
                }) else nil,
                TermsScroll = React.createElement(Foundation.ScrollView, {
                    LayoutOrder = 2,
                    Size = UDim2.new(1, 0, 0, termsScrollHeight),
                    scroll = {
                        scrollBarVisibility = Foundation.Enums.Visibility.None,
                        ScrollingDirection = Enum.ScrollingDirection.Y,
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        CanvasSize = UDim2.fromScale(0, 1)
                    },
                    selection = { Selectable = false }
                }, {
                    TermsBody = React.createElement(Foundation.Text, {
                        tag = "size-full-0 auto-xy padding-bottom-large text-body-medium text-wrap text-align-x-left",
                        Text = termsBody or "",
                        RichText = true,
                        selection = { Selectable = false }
                    })
                })
            })
        }
        var5 = createElement(var6, tbl2, tbl3)
    else
        var5 = nil
    end

    return React.createElement(React.Fragment, nil, { OffersModal = var4, TermsModal = var5 })
end

return CatalogOffersBannerOfferModals
