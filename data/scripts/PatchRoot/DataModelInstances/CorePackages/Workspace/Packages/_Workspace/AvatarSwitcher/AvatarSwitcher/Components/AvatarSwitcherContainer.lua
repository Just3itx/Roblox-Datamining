-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:21:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local SignalsReact = require(AvatarSwitcherParent.SignalsReact)
local useSignalState = SignalsReact.useSignalState
local useUnifiedEventListenerInExperience = require(AvatarSwitcherParent.AvatarExperienceAnalytics).useUnifiedEventListener.useUnifiedEventListenerInExperience

local EmptyState = require(AvatarSwitcher.Components.EmptyState)
local VerticalLayout = require(AvatarSwitcher.Components.VerticalLayout)
local HorizontalLayout = require(AvatarSwitcher.Components.HorizontalLayout)
local SingleItemLayout = require(AvatarSwitcher.Components.SingleItemLayout)
local TopBar = require(AvatarSwitcher.Components.TopBar)
local OutfitsGridWithMessage = require(AvatarSwitcher.Components.OutfitsGridWithMessage)
local PreviewPanel = require(AvatarSwitcher.Components.PreviewPanel)
local RespawnDialogContainer = require(AvatarSwitcher.Components.Modals.RespawnDialogContainer)
local getAvatarSwitcherStore = require(AvatarSwitcher.Stores.getAvatarSwitcherStore)
local ExperienceAvatarSupportType = require(AvatarSwitcher.Enums.ExperienceAvatarSupportType)

local AvatarExperienceCommon = require(AvatarSwitcherParent.AvatarExperienceCommon)
local AvatarExperienceFlags = require(AvatarSwitcherParent.AvatarExperienceFlags)
local FFlagAvatarSwitcherUiFixes = AvatarExperienceFlags.FFlagAvatarSwitcherUiFixes
local FFlagAXTimeoutAcknowledgementGating = AvatarExperienceFlags.FFlagAXTimeoutAcknowledgementGating
local TimeoutBanner = AvatarExperienceCommon.Components.TimeoutBanner

local function AvatarSwitcherContainer(tbl1)
    local var1 = useTokens()
    local var2 = useSignalState(getAvatarSwitcherStore)
    local var3 = useSignalState(var2.getIsEmpty)
    local bool1 = SignalsReact.useSignalState(var2.getExperienceAvatarSupportType) == ExperienceAvatarSupportType.NoSupport

    useUnifiedEventListenerInExperience()

    if FFlagAXTimeoutAcknowledgementGating then
        AvatarExperienceCommon.Hooks.useAvatarChangeAcknowledgementPrompt(true)
    end

    React.useEffect(function()
        task.spawn(function()
            var2.fetchExperienceAvatarSupportType()
        end)
    end, {})

    local topBar = React.createElement(TopBar, { onClose = tbl1.toggleWindow })

    local headerSlot = React.createElement(Foundation.View, { tag = "auto-y size-full-0 col gap-0" }, {
        TopBar = topBar,
        TimeoutBanner = React.createElement(
            Foundation.View,
            { tag = "auto-y size-full-0 bg-surface-200" },
            {
                Banner = React.createElement(TimeoutBanner, { shouldFetch = true, shouldNavigateOnClick = false })
            }
        )
    })

    local outfitsGrid = React.createElement(OutfitsGridWithMessage)
    local element4 = React.createElement(PreviewPanel, { compactLayout = tbl1.verticalLayout })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Active = true,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = var1.Color.OverMedia.OverMedia_0.Color3,
        BackgroundTransparency = if FFlagAvatarSwitcherUiFixes then var1.Color.OverMedia.OverMedia_0.Transparency * GuiService.PreferredTransparency else var1.Color.OverMedia.OverMedia_0.Transparency
    }

    local tbl3 = {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) }),
        Layout = 0,
        RespawnDialogContainer = 0
    }
    local element5

    if var3 then
        element5 = React.createElement(EmptyState, { headerSlot = headerSlot })
    elseif bool1 then
        element5 = React.createElement(SingleItemLayout, {
            headerSlot = headerSlot,
            contentSlot = React.createElement(
                Foundation.View,
                { tag = "size-full-full padding-x-xlarge col gap-medium" },
                { OutfitsGrid = outfitsGrid }
            )
        }, {})
    elseif tbl1.verticalLayout then
        element5 = React.createElement(VerticalLayout, {
            headerSlot = headerSlot,
            topItemSlot = element4,
            bottomItemSlot = React.createElement(
                Foundation.View,
                { tag = "size-full-full padding-x-xlarge padding-top-xlarge" },
                { OutfitsGrid = outfitsGrid }
            )
        })
    else
        element5 = React.createElement(HorizontalLayout, {
            headerSlot = headerSlot,
            leftItemSlot = React.createElement(Foundation.View, { tag = "size-full-full padding-x-xlarge" }, { OutfitsGrid = outfitsGrid }),
            rightItemSlot = element4
        })
    end

    tbl3.Layout = element5

    tbl3.RespawnDialogContainer = React.createElement(RespawnDialogContainer, {
        toggleWindow = tbl1.toggleWindow,
        getRespawnBehaviour = tbl1.getRespawnBehaviour,
        respawnBehaviorChangedEvent = tbl1.respawnBehaviorChangedEvent
    })
    return (createElement(str1, tbl2, tbl3))
end

return AvatarSwitcherContainer
