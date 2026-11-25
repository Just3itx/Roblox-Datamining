-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local useSelector = require(ProfilePlatformParent.RoactUtils).Hooks.RoactRodux.useSelector

local Enums = require(ProfilePlatform.Common.Enums)
local CollectionCarousel = require(ProfilePlatformParent.CollectionViews).CollectionCarousel
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local useScreenSize = require(ProfilePlatformParent.RobloxAppHooks).useScreenSize
local useScreenSize2 = require(ProfilePlatformParent.CoreScriptsRoactCommon).useScreenSize
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)
local useDynamicSizeMargin = require(ProfilePlatform.Hooks.useDynamicSizeMargin)
local FormFactor = require(ProfilePlatformParent.FormFactor).Enums.FormFactor

local Responsive = require(ProfilePlatformParent.Responsive)
local useBreakpointX = Responsive.useBreakpointX
local useIsSpatial = require(ProfilePlatformParent.Responsive).useIsSpatial
local usePreferredInput = Responsive.usePreferredInput
local Foundation = require(ProfilePlatformParent.Foundation)

local AssetTile = require(script.Parent.AssetTile)
local MarketplaceAssetTile = require(script.Parent.MarketplaceAssetTile)
local _AssetInfo = require(ProfilePlatform.Common.AssetInfo)

local TextKeys = require(ProfilePlatform.Common.TextKeys)
local FFlagProfilePlatformEnableInventory = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableInventory
local FFlagProfilePlatformEnableVR = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableVR)

local FFlagProfilePlatformDisableCurrentlyWearingOnConsole = require(ProfilePlatform.Flags.FFlagProfilePlatformDisableCurrentlyWearingOnConsole)
local FFlagAddIEMProfilePage = require(ProfilePlatformParent.SharedFlags).FFlagAddIEMProfilePage

local FFlagProfilePlatformFixResaleLimitedPrice = require(ProfilePlatform.Flags.FFlagProfilePlatformFixResaleLimitedPrice)

local FFlagProfilePlatformEnableBundlesInAssetsCarousel = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableBundlesInAssetsCarousel
local FFlagAXEnableProfileTab = require(ProfilePlatformParent.SharedFlags).FFlagAXEnableProfileTab
local FFlagSplitPaneProfileMaxWidth = require(ProfilePlatformParent.SharedFlags).FFlagSplitPaneProfileMaxWidth
local bool1 = game:DefineFastFlag("SeeMoreCurrentlyWearingCompact", false)
local bool2 = game:DefineFastFlag("SeeMoreCurrentlyWearingWide", false)

local bool3 = game:DefineFastFlag("ProfilePlatformUseNewLayoutForAssetsCarousel", false)

local useTokens = Foundation.Hooks.useTokens

local num1 = 2

local function AssetsCarousel(tbl1)
    local var1 = FFlagAXEnableProfileTab and tbl1.tileVariant == Enums.ProfileTabVariants.MeTab
    local bool4 = if FFlagAXEnableProfileTab then useProfileFormFactor().formFactor == Enums.ProfileFormFactor.Wide else nil
    local source = if FFlagAddIEMProfilePage then useProfileWrapperContext().sourceInfo.source else nil
    local var2 = if bool3 then useTokens() else nil
    local var3 = if FFlagProfilePlatformEnableVR then useIsSpatial() else nil
    local bool5 = if FFlagProfilePlatformDisableCurrentlyWearingOnConsole then usePreferredInput() == Responsive.Input.Directional else false
    local var4 = FFlagProfilePlatformEnableVR and var3 or FFlagProfilePlatformDisableCurrentlyWearingOnConsole and bool5

    local var5 = useScreenSize()
    local var6 = if FFlagAddIEMProfilePage then useScreenSize2() else nil

    if FFlagAddIEMProfilePage and source == Enums.Sources.InExperienceProfile then
        var5 = var6
    end

    local sideMargin, var8 = useDynamicSizeMargin()
    local var9, var10 = React.useState(0)
    local var11 = if FFlagProfilePlatformEnableInventory then tbl1.title else useLocalization({ currentlyWearing = TextKeys.CurrentlyWearing })

    if bool1 or bool2 then
        local var12 = useSelector(function(arg1): boolean
            return arg1.FormFactor == FormFactor.WIDE
        end)

        if bool2 and var12 then
            num1 = 4
        elseif bool1 and not var12 then
            num1 = 3
        end
    end

    local var12 = if FFlagAddIEMProfilePage then useBreakpointX() else nil

    if FFlagAddIEMProfilePage and source == Enums.Sources.InExperienceProfile then
        if var12 == Responsive.Keys.XSmall then
            num1 = 2
        elseif var12 == Responsive.Keys.Small then
            num1 = 3
        else
            num1 = 5
        end
    end

    local num2 = if FFlagAXEnableProfileTab and var1 and bool4 then 5 else num1

    local useCallback = React.useCallback
    local function func1(arg1, layoutOrder, size)
        local createElement = React.createElement
        local str1 = "Frame"
        local tbl2 = { Size = size, BackgroundTransparency = 1, LayoutOrder = layoutOrder }

        local tbl3 = {}
        local str2 = `{arg1.name}`
        local createElement2 = React.createElement
        local var13 = if var1 then MarketplaceAssetTile else AssetTile
        local tbl4 = {
            name = arg1.name,
            price = arg1.price,
            isOffSale = if arg1.isOffSale then true else nil,
            lowestResalePrice = if FFlagProfilePlatformFixResaleLimitedPrice then arg1.lowestResalePrice else nil,
            assetId = arg1.id,
            itemType = if FFlagProfilePlatformEnableBundlesInAssetsCarousel then arg1.itemType else "Asset",
            onActivated = 0
        }
        function tbl4.onActivated()
            if var4 then
                return
            end
            tbl1.openItemDetails(arg1.id, arg1.itemType, nil, nil, layoutOrder)
        end

        tbl3[str2] = createElement2(var13, tbl4)
        return createElement(str1, tbl2, tbl3), "CW_Tile"
    end
    local openItemDetails = tbl1.openItemDetails
    local var13 = if FFlagAXEnableProfileTab then var1 else nil
    local renderItem = useCallback(func1, { openItemDetails, var4, var13 })

    local getItemHeight = React.useCallback(function(num3: number): number
        var10(num3)
        return num3 + 42 + (if FFlagAddIEMProfilePage and source == Enums.Sources.InExperienceProfile then 16 else 0)
    end, {})

    local bool6 = num2 < #tbl1.assets

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(
            1,
            0,
            0,
            var9 + 42 + (if FFlagAddIEMProfilePage and source == Enums.Sources.InExperienceProfile then 16 else 0) + (if bool6 then 0 else 60 + var5.Y * 0.01)
        ),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder,
        [React.Change.AbsoluteSize] = var8
    }
    local tbl3 = { ConstrainedCarousel = 0, CollectionCarousel = 0 }
    local var16

    if FFlagSplitPaneProfileMaxWidth then
        local createElement2 = React.createElement
        local str2 = "Frame"
        local tbl4 = {
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.fromOffset(0, 0),
            BackgroundTransparency = 1
        }
        local tbl5 = {
            MaxWidthConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(850, math.huge) }),
            CollectionCarousel = React.createElement(CollectionCarousel, {
                LayoutOrder = tbl1.layoutOrder,
                title = if FFlagProfilePlatformEnableInventory then tbl1.title else var11.currentlyWearing,
                items = tbl1.assets,
                renderItem = renderItem,
                getItemHeight = getItemHeight,
                numColumns = if FFlagAXEnableProfileTab then num2 else num1,
                fractionalItemAmount = 0.8,
                columnGap = if FFlagAXEnableProfileTab and var1 and bool4 then 12 elseif bool3 then var2.Gap.Medium else 8,
                sideMargin = sideMargin,
                onActivateHeader = tbl1.onActivateHeader
            })
        }
        var16 = createElement2(str2, tbl4, tbl5)
    else
        var16 = nil
    end

    tbl3.ConstrainedCarousel = var16
    local var17

    if FFlagSplitPaneProfileMaxWidth then
        var17 = nil
    else
        local createElement2 = React.createElement
        local var18 = CollectionCarousel
        local tbl4 = {
            LayoutOrder = tbl1.layoutOrder,
            title = if FFlagProfilePlatformEnableInventory then tbl1.title else var11.currentlyWearing,
            items = tbl1.assets,
            renderItem = renderItem,
            getItemHeight = getItemHeight,
            numColumns = 0,
            fractionalItemAmount = 0.8,
            columnGap = 0,
            sideMargin = 0,
            onActivateHeader = 0
        }

        if not FFlagAXEnableProfileTab then
            num2 = num1
        end

        tbl4.numColumns = num2

        tbl4.columnGap = if FFlagAXEnableProfileTab and var1 and bool4 then 12 elseif bool3 then var2.Gap.Medium else 8

        tbl4.sideMargin = sideMargin
        tbl4.onActivateHeader = tbl1.onActivateHeader
        var17 = createElement2(var18, tbl4)
    end

    tbl3.CollectionCarousel = var17
    return createElement(str1, tbl2, tbl3)
end

return AssetsCarousel
