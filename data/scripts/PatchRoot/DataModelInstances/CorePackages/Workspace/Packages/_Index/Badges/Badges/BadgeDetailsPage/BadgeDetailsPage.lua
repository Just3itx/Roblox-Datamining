-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BadgesParent = script:FindFirstAncestor("Badges").Parent

local fetchBadgeDetailsPage = require(script.Parent.fetchBadgeDetailsPage)
local getBadgeDetailsPageKey = require(script.Parent.getBadgeDetailsPageKey)
local BadgeDetailsSheetState = require(script.Parent.BadgeDetailsSheetState)
local _Navigation = require(BadgesParent.Navigation)
local Foundation = require(BadgesParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local React = require(BadgesParent.React)
local useNavigation = require(BadgesParent.Navigation).useNavigation
local useRouteName = require(BadgesParent.Navigation).useRouteName
local useNavigationFocus = require(BadgesParent.Navigation).useNavigationFocus
local Responsive = require(BadgesParent.Responsive)
local useBreakpointXOrSmaller = Responsive.useBreakpointXOrSmaller
local SduiSharedUtilities = require(BadgesParent.SduiSharedUtilities)
local SduiFeatureEntryPoint = SduiSharedUtilities.SduiFeatureEntryPoint
local SduiPageEntryPoint = SduiSharedUtilities.SduiPageEntryPoint
local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer
local CompositionTags = require(BadgesParent.AppComposition).CompositionTags

local setIsBadgeDetailsSheetOpen = BadgeDetailsSheetState.setIsBadgeDetailsSheetOpen
local FFlagSduiPageEntryUseSharedHooks = require(BadgesParent.SharedFlags).FFlagSduiPageEntryUseSharedHooks

local function getFromPropsOrNavigationParams(tbl1, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local param = tbl1.navigation and tbl1.navigation.getParam("extraProps")
    return tbl1[str1] or param and param[str1]
end

local function _(str1: string, str2: string): string -- Luacid: unused: defined but never referenced
    return str1 .. "_" .. str2
end

return React.memo(function(tbl1) -- name: BadgeDetailsPage
    local var1 = useTokens()
    local fromPropsOrNavigationParams = getFromPropsOrNavigationParams(tbl1, "badgeId")
    local configKey = getBadgeDetailsPageKey(fromPropsOrNavigationParams)

    local pageTimer = React.useMemo(function()
        return getFromPropsOrNavigationParams(tbl1, "pageTimer") or SduiLoadTimer.createLoadTimer("BadgeDetails")
    end, {})

    local var3 = useNavigation()
    local var4 = useRouteName()
    local isOpen = useNavigationFocus()
    local var6 = useBreakpointXOrSmaller(Responsive.Keys.Small)

    local onClose = React.useCallback(function()
        if var4 == "BadgeDetails" and isOpen then
            var3.goBack()
        end
    end, { var3, var4, isOpen })

    React.useEffect(function()
        if fromPropsOrNavigationParams then
            fetchBadgeDetailsPage(fromPropsOrNavigationParams, pageTimer)
        end
    end, { fromPropsOrNavigationParams, pageTimer })

    React.useEffect(function()
        setIsBadgeDetailsSheetOpen(not var6 and isOpen)

        return function()
            setIsBadgeDetailsSheetOpen(false)
        end
    end, { var6, isOpen })

    local scrollingFrameRef = React.useRef(nil)

    local renderUtilities = React.useCallback(function()
        return React.createElement(SduiFeatureEntryPoint, {
            appPage = "BadgeDetails",
            configKey = configKey,
            identifier = "badge_details_context_menu",
            AutomaticSize = Enum.AutomaticSize.XY,
            pageTimer = pageTimer,
            shouldDisplayError = false,
            shouldDisplayLoading = false
        })
    end, { configKey, pageTimer })

    if fromPropsOrNavigationParams == nil then
        return nil
    elseif var6 then
        return React.createElement(SduiPageEntryPoint, {
            appPage = "BadgeDetails",
            configKey = configKey,
            identifier = if FFlagSduiPageEntryUseSharedHooks then "badge_details_feed" else configKey .. "_badge_details_feed",
            pageTimer = pageTimer,
            renderUtilities = renderUtilities,
            includeNavigationHeaderBar = true,
            contentTag = CompositionTags.ContentRegion.Body
        })
    end

    return React.createElement(
        Foundation.Sheet.Root,
        {
            snapPoints = { 1 },
            isOpen = isOpen,
            displaySize = Foundation.Enums.DialogSize.Large,
            onClose = onClose
        },
        {
            Header = React.createElement(Foundation.Sheet.Header, { hasCloseAffordance = true }, {
                ContextMenu = React.createElement(
                    "Frame",
                    {
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0
                    },
                    {
                        UIListLayout = React.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            HorizontalAlignment = Enum.HorizontalAlignment.Right,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            SortOrder = Enum.SortOrder.LayoutOrder
                        }),
                        ContextMenuEntryPoint = React.createElement(
                            "Frame",
                            {
                                LayoutOrder = 1,
                                AutomaticSize = Enum.AutomaticSize.XY,
                                BackgroundTransparency = 1,
                                BorderSizePixel = 0
                            },
                            {
                                EntryPoint = renderUtilities()
                            }
                        )
                    }
                )
            }),
            Content = React.createElement(
                Foundation.Sheet.Content,
                { scrollingFrameRef = scrollingFrameRef },
                React.createElement(SduiPageEntryPoint, {
                    appPage = "BadgeDetails",
                    configKey = configKey,
                    identifier = if FFlagSduiPageEntryUseSharedHooks then "badge_details_feed" else configKey .. "_badge_details_feed",
                    pageTimer = pageTimer,
                    includeNavigationHeaderBar = false,
                    backgroundStyle = var1.Color.None,
                    disableRootPadding = true,
                    scrollingFrameRef = scrollingFrameRef,
                    snackbarPortalLayoutOrder = 2147483647
                })
            )
        }
    )
end)
