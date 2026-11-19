-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:10:54Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local FoundationParent = script:FindFirstAncestor("Foundation").Parent
local SafeFlags = require(FoundationParent.SafeFlags)

local FoundationFixColorOnScrubbableNumberInput = SafeFlags.createGetFFlag("FoundationFixColorOnScrubbableNumberInput")()
local var2 = SafeFlags.createGetFFlag("FoundationAlertLinkWrap")()
local var3 = var2 and SafeFlags.createGetFFlag("FoundationAlertStackTrailingOnOverflow")()
local FoundationEducationalTooltipRefresh = SafeFlags.createGetFFlag("FoundationEducationalTooltipRefresh3")()

local FoundationEducationalTooltipMinMediaWidth = SafeFlags.createGetFFlag("FoundationEducationalTooltipMinMediaWidth3")()
local FoundationSliderCapture = SafeFlags.createGetFFlag("FoundationSliderCapture")()
local FoundationNumberInputScrubCallbackProps = SafeFlags.createGetFFlag("FoundationNumberInputScrubCallbackProps2")()

return {
    FoundationUsePath2DSpinner = SafeFlags.createGetFFlag("FoundationUsePath2DSpinner")(),
    FoundationGuiObjectInputSinkProperty = SafeFlags.createGetFFlag("FoundationGuiObjectInputSinkProperty")(),
    FoundationDisableTokenScaling = SafeFlags.createGetFFlag("FoundationDisableTokenScaling2")(),
    FoundationBaseMenuContentSizing = SafeFlags.createGetFFlag("FoundationBaseMenuContentSizing")(),
    FoundationPopoverPluginOverlayMeasurement = SafeFlags.createGetFFlag("FoundationPopoverPluginOverlayMeasurement2")(),
    FoundationViewMemoizationChanges = SafeFlags.createGetFFlag("FoundationViewMemoizationChanges")(),
    FoundationWidgetManagerSnapshotFlush = SafeFlags.createGetFFlag("FoundationWidgetManagerSnapshotFlush")(),
    FoundationSegmentedControlBeta = SafeFlags.createGetFFlag("FoundationSegmentedControlBeta")(),
    FoundationTooltipPressedOutside = SafeFlags.createGetFFlag("FoundationTooltipPressedOutside")(),
    FoundationListItemDecoupledInput = SafeFlags.createGetFFlag("FoundationListItemDecoupledInput")(),
    FoundationPopoverPluginAnchorRefresh = SafeFlags.createGetFFlag("FoundationPopoverPluginAnchorRefresh")(),
    FoundationPopoverClickOutsideInGuiShadow = SafeFlags.createGetFFlag("FoundationPopoverClickOutsideInGuiShadow")(),
    FoundationPopoverContentAnchorFix = SafeFlags.createGetFFlag("FoundationPopoverContentAnchorFix")(),
    FoundationPopoverRecomputeContentSize = SafeFlags.createGetFFlag("FoundationPopoverRecomputeContentSize")(),
    FoundationAnimatedHighlightSettling = SafeFlags.createGetFFlag("FoundationAnimatedHighlightSettling")(),
    FoundationNumberInputScrubCallbackProps = FoundationNumberInputScrubCallbackProps,
    FoundationPopoverPluginFocusable = SafeFlags.createGetFFlag("FoundationPopoverPluginFocusable")(),
    FoundationProviderStableEmptyTable = SafeFlags.createGetFFlag("FoundationProviderStableEmptyTable")(),
    FoundationPopoverClampMinBound = SafeFlags.createGetFFlag("FoundationPopoverClampMinBound")(),
    FoundationFixColorOnScrubbableNumberInput = FoundationFixColorOnScrubbableNumberInput,
    FoundationPluginShadowSize = SafeFlags.createGetFFlag("FoundationPluginShadowSize")(),
    FoundationProgressBarBetaUpdate = SafeFlags.createGetFFlag("FoundationProgressBarBetaUpdate2")(),
    FoundationCenterSheetHeightFix = SafeFlags.createGetFFlag("FoundationCenterSheetHeightFix")(),
    FoundationNumberInputScrubbingUsesOffset = FoundationFixColorOnScrubbableNumberInput and SafeFlags.createGetFFlag("FoundationNumberInputScrubbingUsesOffset")(),
    FoundationSliderCapture = FoundationSliderCapture,
    FoundationAlertLinkWrap = SafeFlags.createGetFFlag("FoundationAlertLinkWrap")(),
    FoundationAlertStackTrailingOnOverflow = var2 and SafeFlags.createGetFFlag("FoundationAlertStackTrailingOnOverflow")(),
    FoundationEducationalTooltipMinMediaWidth = FoundationEducationalTooltipMinMediaWidth,
    FoundationStudioFontFaceMigration = SafeFlags.createGetFFlag("FoundationStudioFontFaceMigration")(),
    FoundationFontFaceMigration = SafeFlags.createGetFFlag("FoundationFontFaceMigration3")(),
    FoundationSheetReversedContent = SafeFlags.createGetFFlag("FoundationSheetReversedContent")(),
    FoundationStatusIndicatorDesignUpdate = SafeFlags.createGetFFlag("FoundationStatusIndicatorDesignUpdate")(),
    FoundationUnifiedScrimScrolling = SafeFlags.createGetFFlag("FoundationUnifiedScrimScrolling2")(),
    FoundationFixChipAccessoryLayout = SafeFlags.createGetFFlag("FoundationFixChipAccessoryLayout")(),
    FoundationRemoveDeprecatedSemanticTokens = SafeFlags.createGetFFlag("FoundationRemoveDeprecatedSemanticTokens")(),
    FoundationBottomSheetOverlayShadow = SafeFlags.createGetFFlag("FoundationBottomSheetOverlayShadow")(),
    FoundationCenterSheetOverlayShadow = SafeFlags.createGetFFlag("FoundationCenterSheetOverlayShadow")(),
    FoundationDialogOverlayShadow = SafeFlags.createGetFFlag("FoundationDialogOverlayShadow")(),
    FoundationPopoverOverlayShadow = SafeFlags.createGetFFlag("FoundationPopoverOverlayShadow")(),
    FoundationFixTabsFitGap = SafeFlags.createGetFFlag("FoundationFixTabsFitGap")(),
    FoundationAlertUseLink = var3 and SafeFlags.createGetFFlag("FoundationAlertUseLink")(),
    FoundationBadgeBetaUpdate = SafeFlags.createGetFFlag("FoundationBadgeBetaUpdate4")(),
    FoundationBadgeOverMediaAdaptive = SafeFlags.createGetFFlag("FoundationBadgeOverMediaAdaptive")(),
    FoundationBaseMenuAccessorySizing = SafeFlags.createGetFFlag("FoundationBaseMenuAccessorySizing")(),
    FoundationBottomSheetInternalBackdrop = SafeFlags.createGetFFlag("FoundationBottomSheetInternalBackdrop")(),
    FoundationCenterSheetInternalBackdrop = SafeFlags.createGetFFlag("FoundationCenterSheetInternalBackdrop")(),
    FoundationDevOnlyPropAsserts = SafeFlags.createGetFFlag("FoundationDevOnlyPropAsserts")(),
    FoundationDialogInternalBackdrop = SafeFlags.createGetFFlag("FoundationDialogInternalBackdrop")(),
    FoundationEducationalTooltipBodyOnlyContentLayout = FoundationEducationalTooltipRefresh
        and FoundationEducationalTooltipMinMediaWidth
        and SafeFlags.createGetFFlag("FoundationEducationalTooltipBodyOnlyContentLayout")(),
    FoundationEducationalTooltipRefresh = FoundationEducationalTooltipRefresh,
    FoundationSideSheetInternalBackdrop = SafeFlags.createGetFFlag("FoundationSideSheetInternalBackdrop")(),
    FoundationTabsStableOnActivated = SafeFlags.createGetFFlag("FoundationTabsStableOnActivated")(),
    FoundationInternalNoticeUseLink = SafeFlags.createGetFFlag("FoundationInternalNoticeUseLink")(),
    FoundationLightweightGuiControlState = SafeFlags.createGetFFlag("FoundationLightweightGuiControlState")(),
    FoundationNumberInputScrubEndedAlone = FoundationNumberInputScrubCallbackProps and SafeFlags.createGetFFlag("FoundationNumberInputScrubEndedAlone")(),
    FoundationSideSheetInternalDrawer = SafeFlags.createGetFFlag("FoundationSideSheetInternalDrawer")(),
    FoundationSliderRebuild = FoundationSliderCapture and SafeFlags.createGetFFlag("FoundationSliderRebuild2")(),
    FoundationTabsAccessory = SafeFlags.createGetFFlag("FoundationTabsAccessory")()
}
