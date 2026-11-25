-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local SduiCoreSystemParent = SduiCoreSystem.Parent

local buildDefaultProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildDefaultProp)
local buildStringProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildStringProp)
local buildTableProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildTableProp)
local buildRepeatedProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildRepeatedProp)
local buildContainerProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildContainerProp)
local buildNestedComponentProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildNestedComponentProp)
local buildLazyNestedComponentProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildLazyNestedComponentProp)

local buildLazyNestedComponentListProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildLazyNestedComponentListProp)
local buildNestedComponentListProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildNestedComponentListProp)
local buildActionProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildActionProp)
local SduiParsers = require(SduiCoreSystem.SduiParsers)
local _SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)
local SduiClientBindingParsers = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiClientBindingParsers)
local ProtoVariableMapper = require(SduiCoreSystem.ClientBinding.ProtoVariableMapper)

local FFlagSduiMarketplaceCatalogCategorySupport = require(SduiCoreSystemParent.SharedFlags).FFlagSduiMarketplaceCatalogCategorySupport
local FFlagSduiMarketplaceCatalogSortSupport = require(SduiCoreSystemParent.SharedFlags).FFlagSduiMarketplaceCatalogSortSupport
local FFlagSduiCatalogItemCard = require(SduiCoreSystemParent.SharedFlags).FFlagSduiCatalogItemCard
local FFlagSduiSheetComponent = require(SduiCoreSystemParent.SharedFlags).FFlagSduiSheetComponent
local FFlagSduiSystemBannerComponent = require(SduiCoreSystemParent.SharedFlags).FFlagSduiSystemBannerComponent
local FFlagSduiBannerContextComponent = require(SduiCoreSystemParent.SharedFlags).FFlagSduiBannerContextComponent
local FFlagLuaAppSduiHomePageSupport = require(SduiCoreSystemParent.SharedFlags).FFlagLuaAppSduiHomePageSupport
local FFlagSduiExperimentalComponent = require(SduiCoreSystemParent.SharedFlags).FFlagSduiExperimentalComponent
local FFlagSduiListComponents = require(SduiCoreSystemParent.SharedFlags).FFlagSduiListComponents

local function applyParser(arg1, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 28 call sites recovered
    return function(arg2, arg3, arg4, arg5, arg6, arg7)
        local var1, var2 = arg1(arg2, arg3, arg4, arg5, arg6, arg7, func1)

        return var1, var2
    end
end

local function createEngineEnumProtoBuilder(arg1, str1: string) -- Luacid: Inlined by compiler; 10 call sites recovered
    return applyParser(buildDefaultProp, function(arg2)
        local engineEnumParser = SduiParsers.getEngineEnumParser(arg1)
        return ProtoVariableMapper.mapProtoEngineEnumToLua(arg2, str1, engineEnumParser)
    end)
end

local tbl1 = {
    StringProp = buildStringProp,
    BoolProp = buildDefaultProp,
    FloatProp = buildDefaultProp,
    DoubleProp = buildDefaultProp,
    Int32Prop = buildDefaultProp,
    Int64Prop = buildDefaultProp,
    StructProp = applyParser(buildDefaultProp, SduiClientBindingParsers.parseStruct),
    ImageStringProp = applyParser(buildStringProp, SduiParsers.parseImageStringProp_),
    ImageSetProp = applyParser(buildStringProp, SduiParsers.parseImageSetOrImageProp_),
    ColorProp = applyParser(buildDefaultProp, SduiClientBindingParsers.parseColorPropLegacy),
    Color3Prop = applyParser(buildDefaultProp, SduiClientBindingParsers.parseColor3),
    TypographyProp = buildDefaultProp,
    TypographyFontProp = buildDefaultProp,
    UDimProp = applyParser(buildDefaultProp, SduiClientBindingParsers.parseUDim),
    UDim2Prop = applyParser(buildDefaultProp, SduiClientBindingParsers.parseUDim2),
    Vector2Prop = applyParser(buildDefaultProp, SduiParsers.parseVector2Prop_),
    NestedComponentProp = buildNestedComponentProp,
    LazyNestedComponentProp = buildLazyNestedComponentProp,
    NestedComponentListProp = buildNestedComponentListProp,
    LazyNestedComponentListProp = buildLazyNestedComponentListProp,
    StringArrayProp = applyParser(buildDefaultProp, SduiClientBindingParsers.parseStringArray),
    IconProp = applyParser(buildDefaultProp, SduiParsers.parseIconProp_),
    GradientProp = applyParser(buildDefaultProp, SduiClientBindingParsers.parseGradient),
    ArrayOfStructProp = applyParser(buildDefaultProp, SduiClientBindingParsers.parseArrayOfStruct),
    ArrayOfFloatProp = if FFlagSduiSheetComponent then buildRepeatedProp else nil
}
local var1

if FFlagLuaAppSduiHomePageSupport then
    local parsePymkItems = SduiClientBindingParsers.parsePymkItems
    var1 = applyParser(buildDefaultProp, parsePymkItems)
else
    var1 = nil
end

tbl1.ArrayOfPymkItemDataProp = var1

tbl1.ActionProp = buildActionProp
tbl1.TableProp = buildTableProp

tbl1.ContainerProp = buildContainerProp
tbl1.ArrayOfMenuItemProp = buildRepeatedProp
tbl1.MenuItemProp = buildTableProp
tbl1.MenuItem = buildTableProp
tbl1.GenericShareLinkData = buildTableProp
tbl1.ShareLinkFetchData = buildTableProp
tbl1.ExperienceShareLinkPayload = buildTableProp
tbl1.EventShareLinkPayload = buildTableProp
tbl1.MediaGallerySchema_MediaItemArrayProp = buildRepeatedProp
tbl1.ArrayOfSystemBannerActionsProp = if FFlagSduiSystemBannerComponent then buildRepeatedProp else nil
tbl1.SystemBannerActionProp = if FFlagSduiSystemBannerComponent then buildTableProp else nil
tbl1.FoundationInternalNoticeLinkProp = if FFlagSduiBannerContextComponent then buildTableProp else nil
tbl1.FoundationInternalNoticeLink = if FFlagSduiBannerContextComponent then buildTableProp else nil
tbl1.FoundationIconConfigProp = buildTableProp
tbl1.HoldActionConfigProp = buildTableProp
tbl1.HoldActionConfig = buildTableProp
tbl1.OpenPurchasePromptAction_ProductPayload = buildTableProp
tbl1.OpenPurchasePromptAction_DisplayInfo = buildTableProp
tbl1.OpenPurchasePromptAction_PurchaseOptions = buildTableProp
tbl1.OpenPurchasePromptAction_PurchaseAnalyticsMetadata = buildTableProp

tbl1.ArrayOfCatalogCategoryMenuItemProp = if FFlagSduiMarketplaceCatalogCategorySupport then buildRepeatedProp else nil

tbl1.CatalogCategoryMenuItem = if FFlagSduiMarketplaceCatalogCategorySupport then buildTableProp else nil
tbl1.ArrayOfCategoryMenuButtonProp = if FFlagSduiMarketplaceCatalogCategorySupport then buildRepeatedProp else nil

tbl1.CategoryMenuButtonProp = if FFlagSduiMarketplaceCatalogCategorySupport then buildTableProp else nil
tbl1.CategoryMenuButton = if FFlagSduiMarketplaceCatalogCategorySupport then buildTableProp else nil
tbl1.ArrayOfCatalogCategoryMenuTooltipInfoProp = if FFlagSduiMarketplaceCatalogCategorySupport then buildRepeatedProp else nil

tbl1.CatalogCategoryMenuTooltipInfoProp = if FFlagSduiMarketplaceCatalogCategorySupport then buildTableProp else nil

tbl1.CatalogCategoryMenuTooltipInfo = if FFlagSduiMarketplaceCatalogCategorySupport then buildTableProp else nil

tbl1.ArrayOfTooltipInfoActionsProp = if FFlagSduiMarketplaceCatalogCategorySupport then buildRepeatedProp else nil

tbl1.TooltipInfoActionPropsProp = if FFlagSduiMarketplaceCatalogCategorySupport then buildTableProp else nil
tbl1.TooltipInfoActionProps = if FFlagSduiMarketplaceCatalogCategorySupport then buildTableProp else nil
tbl1.ArrayOfCatalogSortContentProp = if FFlagSduiMarketplaceCatalogSortSupport then buildRepeatedProp else nil
tbl1.ArrayOfItemFooterProp = if FFlagSduiMarketplaceCatalogSortSupport then buildRepeatedProp else nil
tbl1.CardStyleProp = if FFlagSduiMarketplaceCatalogSortSupport then buildTableProp elseif FFlagSduiCatalogItemCard then buildTableProp else nil

tbl1.AnalyticsDataField = buildDefaultProp
tbl1.AutomaticSizeProp = createEngineEnumProtoBuilder(Enum.AutomaticSize, "AUTOMATIC_SIZE_")
tbl1.TextTruncateProp = createEngineEnumProtoBuilder(Enum.TextTruncate, "TEXT_TRUNCATE_")
tbl1.TextXAlignmentProp = createEngineEnumProtoBuilder(Enum.TextXAlignment, "TEXT_X_ALIGNMENT_")
tbl1.TextYAlignmentProp = createEngineEnumProtoBuilder(Enum.TextYAlignment, "TEXT_Y_ALIGNMENT_")
tbl1.UIFlexModeProp = createEngineEnumProtoBuilder(Enum.UIFlexMode, "UI_FLEX_MODE_")
tbl1.ScaleTypeProp = createEngineEnumProtoBuilder(Enum.ScaleType, "SCALE_TYPE_")
tbl1.ResamplerModeProp = createEngineEnumProtoBuilder(Enum.ResamplerMode, "RESAMPLER_MODE_")
tbl1.SizeConstraintProp = createEngineEnumProtoBuilder(Enum.SizeConstraint, "SIZE_CONSTRAINT_")
tbl1.SelectionBehaviorProp = createEngineEnumProtoBuilder(Enum.SelectionBehavior, "SELECTION_BEHAVIOR_")
tbl1.KeyCodeProp = createEngineEnumProtoBuilder(Enum.KeyCode, "KEY_CODE_")
tbl1.FocusNavActionsProp = applyParser(buildTableProp, SduiClientBindingParsers.parseFocusNavActions)
tbl1.ColorStyleProp = buildDefaultProp
tbl1.UiScaledUDim2Prop = applyParser(buildDefaultProp, SduiClientBindingParsers.parseUiScaledUDim2)
tbl1.UiScaledUDimProp = applyParser(buildDefaultProp, SduiClientBindingParsers.parseUiScaledUDim)
tbl1.UiScaledFloatProp = applyParser(buildDefaultProp, SduiClientBindingParsers.parseUiScaledNumber)

tbl1.FillBehaviorProp = buildDefaultProp
tbl1.InputSizeProp = buildDefaultProp
tbl1.ListItemInputControlProp = if FFlagSduiListComponents then buildTableProp else nil
tbl1.LaunchExperienceAction_ExperienceJoinData = buildTableProp
tbl1.AvatarConfigProp = buildTableProp
tbl1.ArrayOfAvatarProp = buildRepeatedProp

local function getPropBuilder(str1: string, bool1: boolean?)
    if not str1 then
        error("Failed to find prop builder -- missing propDescriptorName")
    end
    local var2 = tbl1[str1]
    if not var2 then
        if FFlagSduiExperimentalComponent and bool1 then
            error(`No prop builder registered under the name '{str1}'`)
        end
        warn(`Could not find propBuilder for propDescriptorName {str1}. Using default.`)
        var2 = buildDefaultProp
    end
    return var2
end

return getPropBuilder
