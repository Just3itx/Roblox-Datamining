-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local React = require(scriptParentParent.React)
local Foundation = require(scriptParentParent.Foundation)
local Localization = require(scriptParentParent.Localization)
local Icon = Foundation.Icon
local View = Foundation.View
local FoundationText = Foundation.Text
local Menu = Foundation.Menu
local Enums = Foundation.Enums
local WhyThisAdModal = require(scriptParent.WhyThisAdModal)
local AdDisclosureTelemetry = require(scriptParent.AdDisclosureTelemetry)

local useLocalization = Localization.Hooks.useLocalization

return React.memo(function(tbl1) -- name: AdLabel
    local var1 = useLocalization({
        adLabel = "Feature.EnhancedVideo.Label.Ad",
        whyThisAdLabel = "Feature.GameDetails.Action.WhyThisAd",
        errorAdDisclosureText = "Feature.GameDetails.Message.SponsoredDisclosure.Error"
    })

    local items = {{
        id = "whyThisAd",
        icon = Enums.IconName.CircleI,
        text = var1.whyThisAdLabel
    }}

    local isOpen, var3 = React.useState(false)
    local var4, var5 = React.useState(false)

    local function toggleMenu(bool1: boolean) -- Luacid: Inlined by compiler; 3 call sites recovered
        AdDisclosureTelemetry.logAdDisclosureMenuToggled(bool1)
        var3(bool1)
    end

    local function toggleWhyThisAdModal(bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
        AdDisclosureTelemetry.logAdDisclosureWhyThisAdToggled(bool1)
        var5(bool1)
    end

    local createElement = React.createElement
    local var6 = View
    local tbl3 = { tag = "size-full margin-bottom-medium" }

    local tbl4 = {
        Menu = React.createElement(Menu, {
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, -10, 1, 0),
            isOpen = isOpen,
            items = items,
            size = Enums.InputSize.Medium,
            align = Enums.PopoverAlign.End,
            width = UDim.new(0, 180),
            onPressedOutside = function()
                toggleMenu(false)
            end,
            onActivated = function(arg1)
                if arg1 == "whyThisAd" then
                    toggleMenu(false)
                    toggleWhyThisAdModal(true)
                    tbl1.sendPauseEvent()
                end
            end
        }, {
            AdLabel = React.createElement(View, {
                tag = "row align-x-center align-y-center size-1300-600 stroke-standard stroke-default radius-small bg-over-media-100",
                onActivated = function()
                    toggleMenu(not isOpen)
                end
            }, {
                AdText = React.createElement(
                    FoundationText,
                    {
                        Text = var1.adLabel,
                        tag = "size-0-full auto-x text-label-small",
                        LayoutOrder = 1
                    }
                ),
                TrailingIconWrapper = React.createElement(View, {
                    tag = "auto-xy padding-left-small",
                    LayoutOrder = 2
                }, {
                    MoreIcon = React.createElement(Icon, { name = Enums.IconName.CircleThreeDotsHorizontal, size = Enums.IconSize.XSmall })
                })
            })
        }),
        WhyThisAdModal = 0
    }

    local var7

    if var4 then
        local createElement2 = React.createElement
        local var8 = WhyThisAdModal
        local tbl5 = {
            adDisclosureBody = if tbl1.adDisclosureText ~= nil and tbl1.adDisclosureText ~= "" then tbl1.adDisclosureText else var1.errorAdDisclosureText,
            showAdPreferencesUrl = tbl1.showAdPreferencesUrl,
            onClose = 0
        }

        function tbl5.onClose()
            toggleWhyThisAdModal(false)
        end

        var7 = createElement2(var8, tbl5)
    else
        var7 = nil
    end

    tbl4.WhyThisAdModal = var7
    return createElement(var6, tbl3, tbl4)
end)
